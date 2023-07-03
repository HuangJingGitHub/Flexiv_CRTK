#!/usr/bin/env python
import rospy
import numpy as np
import PyKDL as kdl
from std_msgs.msg import Bool
from flexiv_crtk.msg import RobotStates_CRTK
from dvrk import mtm

robot_pose = kdl.Frame()
robot_pose.M[0, 0] = -1
robot_pose.M[1, 1] = 0
robot_pose.M[2, 1] = 1
robot_pose.M[2, 2] = 0
robot_pose.M[1, 2] = 1

master_gripper_once_closed = False

def robotStateMsgCallback(data):
    #print('robot message callback')
    global robot_pose
    robot_pose_pos = kdl.Vector(data.measured_cp.position.x, data.measured_cp.position.y, data.measured_cp.position.z)
    robot_pose_rot = kdl.Rotation.Quaternion(data.measured_cp.orientation.x, 
                                            data.measured_cp.orientation.y, 
                                            data.measured_cp.orientation.z, 
                                            data.measured_cp.orientation.w)
    robot_pose = kdl.Frame(robot_pose_rot, robot_pose_pos)
    #print(robot_pose)

def masterGripperClosedCallback(data):
    global master_gripper_once_closed
    if data.data == True:
        master_gripper_once_closed = True

def computeDiffofRots(rot_1, rot_2):
    rot_1_to_2 = rot_2 * rot_1.Inverse()
    axis_angle_cos = (rot_1_to_2[0, 0] + rot_1_to_2[1, 1] + rot_1_to_2[2, 2] - 1) / 2
    return abs(axis_angle_cos - 1)

if __name__ == '__main__':
    ml = mtm('MTML')
    while ml.enable() == False:
        print('Enabling the master...')
        continue
    print('Master enabled')
    
    while ml.home() == False:
        print('Homing the master...')
        continue
    print('Master homed')

    # rospy.init_node('robot_states_sub', anonymous = True)
    rospy.Subscriber('/flexiv/robot_states', RobotStates_CRTK, robotStateMsgCallback)
    rospy.Subscriber('/MTML/gripper/closed', Bool, masterGripperClosedCallback)
    align_state_pub = rospy.Publisher('/MTM_align_state', Bool, queue_size = 100)
    ros_rate = rospy.Rate(100)

    cur_pose = ml.measured_cp()
    is_MTM_aligned = False
    while not rospy.is_shutdown():
        print('Current rotation difference:')
        print(computeDiffofRots(cur_pose.M, robot_pose.M))
        print('MTM pose:')
        print(ml.measured_cp())
        print('robot pose:')
        print(robot_pose)        
        if computeDiffofRots(cur_pose.M, robot_pose.M) > 0.02 and is_MTM_aligned == False:
            goal_pose = cur_pose
            goal_pose.M = robot_pose.M
            ml.move_cp(goal_pose)
            cur_pose = ml.measured_cp()
            is_MTM_aligned = False
        else:
            is_MTM_aligned = True
        align_state_pub.publish(is_MTM_aligned)
        ros_rate.sleep()
        
        if is_MTM_aligned:
            print('Master aligned')
            # detect user hand
            if master_gripper_once_closed:
                print('Clamp gripper detected')
                ml.body.servo_cf(np.array([0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))
            continue
            
