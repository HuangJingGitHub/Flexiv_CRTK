#include "ros/ros.h"
#include "robot_config.hpp"
#include "flexiv_crtk/RobotStates_CRTK.h"

int main(int argc, char **argv) {
    flexiv::Log log;
    flexiv::Robot_CRTK robot(robotIP, localIP);
    try {
        if (robot.isFault()) {
            log.warn("Fault occurred on robot server, trying to clear ...");
            robot.clearFault();
            std::this_thread::sleep_for(std::chrono::seconds(2));
            if (robot.isFault()) {
                log.error("Fault cannot be cleared, exiting ...");
                return 1;
            }
            log.info("Fault on robot server is cleared");
        }
        log.info("Enabling robot ...");
        robot.enable();

        // Wait for the robot to become operational
        int secondsWaited = 0;
        while (!robot.isOperational()) {
            std::this_thread::sleep_for(std::chrono::seconds(1));
            if (++secondsWaited == 10) {
                log.warn( "Still waiting for robot to become operational, please"
                          "check that the robot 1) has no fault, 2) is booted into Auto mode");
            }
        }
        log.info("Robot is now operational");
    }
    catch (const flexiv::Exception& e) {
        log.error(e.what());
        return 1;
    } 

    ros::init(argc, argv, "robot_states_pub_node");
    ros::NodeHandle node_handle;
    ros::Publisher robot_states_publisher = node_handle.advertise<flexiv_crtk::RobotStates_CRTK>("/flexiv/robot_states", 1000);
    ros::Rate loop_rate(1000);
    
    while (ros::ok) {
        flexiv_crtk::RobotStates_CRTK robot_states_msg;
        flexiv::RobotStates cur_robot_states;
        robot.getRobotStates(cur_robot_states);

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

        robot_states_publisher.publish(robot_states_msg);
        ros::spinOnce();     
        loop_rate.sleep();
    }
}