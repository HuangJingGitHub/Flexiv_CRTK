/**
 * @file Robot_CRTK.hpp
 * @copyright Copyright (C) Jing. All Rights Reserved.
 */

#ifndef FLEXIVRDK_ROBOT_CRTK_HPP_
#define FLEXIVRDK_ROBOT_CRTK_HPP_

#include "Robot.hpp"
#include "Utility.hpp"
#include "flexiv_crtk/RobotStates_CRTK.h"
#include "ros/ros.h"
#include <sensor_msgs/JointState.h>
#include <thread>

namespace flexiv {
/**
 * @class The base class is Robot
 * @brief Robot is the main interface with the robot, including system, control, motion, and
 * IO methods. Also responsible for communication.
 */
class Robot_CRTK : public Robot {
private:
    // ros::NodeHandle node_handle;
    ros::Publisher robot_states_publisher;
    ros::Publisher joint_states_publisher;
    std::vector<std::string> joint_name_vec{"joint1", "joint2", "joint3", "joint4", "joint5", "joint6", "joint7"};
    ros::Duration publish_period = ros::Duration(0.001);
    ros::Timer timer;
public:
    const int robot_dof_num = 7;
    bool ROS_mode = false;
    Robot_CRTK(const std::string& serverIP, const std::string& localIP, bool in_ROS = false): Robot(serverIP, localIP) {
        ROS_mode = in_ROS;
        if (ROS_mode) {
            int argc_alias = 0;
            char **argv_alias = nullptr;
            ros::init(argc_alias, argv_alias, "robot_states_pub_class_node");
            ros::NodeHandle node_handle;
            robot_states_publisher = node_handle.advertise<flexiv_crtk::RobotStates_CRTK>("/flexiv/robot_states", 500);
            joint_states_publisher = node_handle.advertise<sensor_msgs::JointState>("/joint_states", 2000);
            timer = node_handle.createTimer(publish_period, &Robot_CRTK::publishRobotStates, this);
        }
    }
    virtual ~Robot_CRTK() {}

    /**
     * @brief CRTK methods
     */
    std::vector<double> measured_jp() {
        RobotStates cur_robot_state;
        getRobotStates(cur_robot_state);
        return cur_robot_state.q;
    }

    std::vector<double> measured_cp() {
        RobotStates cur_robot_state;
        getRobotStates(cur_robot_state);
        return cur_robot_state.tcpPose;
    }

    std::vector<double> measured_cv() {
        RobotStates cur_robot_state;
        getRobotStates(cur_robot_state);
        return cur_robot_state.tcpVel;
    }

    std::vector<double> measured_cf() {
        RobotStates cur_robot_state;
        getRobotStates(cur_robot_state);
        return cur_robot_state.extForceInBaseFrame;
    }    

    std::vector<double> goal_cp() {
        RobotStates cur_robot_state;
        getRobotStates(cur_robot_state);
        return cur_robot_state.tcpPoseDes;
    }

    void servo_jp(const std::vector<double>& positions, 
                const std::vector<double>& velocities,
                const std::vector<double>& accelerations) {
         if (getMode() != flexiv::MODE_JOINT_POSITION) {
            setMode(flexiv::MODE_JOINT_POSITION);
            while (getMode() != flexiv::MODE_JOINT_POSITION) {
                std::this_thread::sleep_for(std::chrono::milliseconds(1));
            }                            
        }                      
        streamJointPosition(positions, velocities, accelerations);
    }

    void servo_jf(const std::vector<double>& torques,
                 bool enableGravityComp = true, 
                 bool enableSoftLimits = true) {
        streamJointTorque(torques, enableGravityComp, enableSoftLimits);
    }

    void servo_cp(const std::vector<double>& pose,
                const std::vector<double>& maxWrench
                = {100.0, 100.0, 100.0, 30.0, 30.0, 30.0}) {     
        if (getMode() != flexiv::MODE_CARTESIAN_IMPEDANCE) {
            setMode(flexiv::MODE_CARTESIAN_IMPEDANCE);
            while (getMode() != flexiv::MODE_CARTESIAN_IMPEDANCE) {
                std::this_thread::sleep_for(std::chrono::milliseconds(1));
            }                            
        }                                   
        streamTcpPose(pose, maxWrench);        
    }

    void interpolate_jp(const std::vector<double>& positions,
                        const std::vector<double>& velocities,
                        const std::vector<double>& accelerations,
                        const std::vector<double>& maxVel, 
                        const std::vector<double>& maxAcc,
                        const std::vector<double>& maxJerk) {
         if (getMode() != flexiv::MODE_JOINT_POSITION_NRT) {
            setMode(flexiv::MODE_JOINT_POSITION_NRT);
            while (getMode() != flexiv::MODE_JOINT_POSITION_NRT) {
                std::this_thread::sleep_for(std::chrono::milliseconds(1));
            }                            
        }             
        sendJointPosition(positions, velocities, accelerations, maxVel, maxAcc, maxJerk);
    }

    void interpolate_cp(const std::vector<double>& pose,
                        const std::vector<double>& maxWrench
                        = {100.0, 100.0, 100.0, 30.0, 30.0, 30.0}) {
        if (getMode() != flexiv::MODE_CARTESIAN_IMPEDANCE_NRT) {
            setMode(flexiv::MODE_CARTESIAN_IMPEDANCE_NRT);
            while (getMode() != flexiv::MODE_CARTESIAN_IMPEDANCE_NRT) {
                std::this_thread::sleep_for(std::chrono::milliseconds(1));
            }                            
        }
        sendTcpPose(pose, maxWrench);
    }

    void move_jp(const std::vector<double> target_joint_position) {
        if (getMode() != flexiv::MODE_PRIMITIVE_EXECUTION) {
            setMode(flexiv::MODE_PRIMITIVE_EXECUTION);
            while (getMode() != flexiv::MODE_PRIMITIVE_EXECUTION) {
                std::this_thread::sleep_for(std::chrono::milliseconds(1));
            }                            
        }
        std::string target_joint_position_str = "MoveJ(target=";
        for (int i = 0; i < robot_dof_num - 1; i++)
            target_joint_position_str += (std::to_string(target_joint_position[i]) + " ");
        target_joint_position_str += (std::to_string(target_joint_position.back()) + ")");
        executePrimitive(target_joint_position_str);
        
        while (flexiv::utility::parsePtStates(getPrimitiveStates(), "reachedTarget") != "1") {
            std::this_thread::sleep_for(std::chrono::seconds(1));
        }        
    }

    void move_cp(const std::vector<double> target_position) {
        if (getMode() != flexiv::MODE_PRIMITIVE_EXECUTION) {
            setMode(flexiv::MODE_PRIMITIVE_EXECUTION);
            while (getMode() != flexiv::MODE_PRIMITIVE_EXECUTION) {
                std::this_thread::sleep_for(std::chrono::milliseconds(1));
            }                            
        }
        std::string target_position_str = "MovePTP(target=";
        for (int i = 0; i < 5; i++)
            target_position_str += (std::to_string(target_position[i]) + " ");
        target_position_str += (std::to_string(target_position.back()) + " WORLD)");
        executePrimitive(target_position_str);
        
        while (flexiv::utility::parsePtStates(getPrimitiveStates(), "reachedTarget") != "1") {
            std::this_thread::sleep_for(std::chrono::seconds(1));
        } 
    }

    void publishRobotStates(const ros::TimerEvent& event) {
        flexiv_crtk::RobotStates_CRTK robot_states_msg;
        RobotStates cur_robot_states;
        getRobotStates(cur_robot_states);

        robot_states_msg.header.stamp = ros::Time::now();
        for (int i = 0; i < cur_robot_states.q.size(); i++)
            robot_states_msg.measured_jp[i] = cur_robot_states.q[i];
        
        robot_states_msg.measured_cp.position.x = cur_robot_states.tcpPose[0];
        robot_states_msg.measured_cp.position.y = cur_robot_states.tcpPose[1];
        robot_states_msg.measured_cp.position.z = cur_robot_states.tcpPose[2];
        robot_states_msg.measured_cp.orientation.x = cur_robot_states.tcpPose[3];
        robot_states_msg.measured_cp.orientation.y = cur_robot_states.tcpPose[4];
        robot_states_msg.measured_cp.orientation.z = cur_robot_states.tcpPose[5];
        robot_states_msg.measured_cp.orientation.w = cur_robot_states.tcpPose[6];

        robot_states_msg.goal_cp.position.x = cur_robot_states.tcpPoseDes[0];
        robot_states_msg.goal_cp.position.y = cur_robot_states.tcpPoseDes[1];
        robot_states_msg.goal_cp.position.z = cur_robot_states.tcpPoseDes[2];
        robot_states_msg.goal_cp.orientation.x = cur_robot_states.tcpPoseDes[3];
        robot_states_msg.goal_cp.orientation.y = cur_robot_states.tcpPoseDes[4];
        robot_states_msg.goal_cp.orientation.z = cur_robot_states.tcpPoseDes[5];
        robot_states_msg.goal_cp.orientation.w = cur_robot_states.tcpPoseDes[6];

        robot_states_msg.measured_cv.linear.x = cur_robot_states.tcpVel[0];
        robot_states_msg.measured_cv.linear.y = cur_robot_states.tcpVel[1];
        robot_states_msg.measured_cv.linear.z = cur_robot_states.tcpVel[2];
        robot_states_msg.measured_cv.angular.x = cur_robot_states.tcpVel[3];  
        robot_states_msg.measured_cv.angular.y = cur_robot_states.tcpVel[4];
        robot_states_msg.measured_cv.angular.z = cur_robot_states.tcpVel[5];  

        robot_states_msg.measured_cf.force.x = cur_robot_states.extForceInBaseFrame[0];
        robot_states_msg.measured_cf.force.y = cur_robot_states.extForceInBaseFrame[1];
        robot_states_msg.measured_cf.force.z = cur_robot_states.extForceInBaseFrame[2];
        robot_states_msg.measured_cf.torque.x = cur_robot_states.extForceInBaseFrame[3];  
        robot_states_msg.measured_cf.torque.y = cur_robot_states.extForceInBaseFrame[4];
        robot_states_msg.measured_cf.torque.z = cur_robot_states.extForceInBaseFrame[5];    

        // joint state
        sensor_msgs::JointState cur_joint_state;
        cur_joint_state.header.stamp = ros::Time::now();
        cur_joint_state.name = joint_name_vec;
        for (int i = 0; i < cur_robot_states.q.size(); i++) {
            cur_joint_state.position.push_back(cur_robot_states.q[i]);
            cur_joint_state.velocity.push_back(0);
            cur_joint_state.effort.push_back(0);
        }        
        
        robot_states_publisher.publish(robot_states_msg);  
        joint_states_publisher.publish(cur_joint_state);      
    }
};

} /* namespace flexiv */

#endif /* FLEXIVRDK_ROBOT_CRTK_HPP_ */
