import rospy
import numpy as np
import PyKDL as kdl
from std_msgs import Bool
from flexiv_crtk.msg import RobotStates_CRTK
from dvrk import mtm

robot_pose = kdl.Frame()

def robotStateMsgCallback(data):
    robot_pose_pos = kdl.Vector(data.position.x, data.position.y, data.position.z)
    robot_pose_rot = kdl.Rotation.Quaternion(data.orientation.x, data.orientation.y, data.orientation.z, data.orientation.w)
    robot_pose = kdl.Frame(robot_pose_pos, robot_pose_rot)

def computeDiffofRots(rot_1, rot_2):
    rot_1_to_2 = rot_2 * rot_1.inverse()
    axis_angle_cos = (rot_1_to_2[0, 0] + rot_1_to_2[1, 1] + rot_1_to_2[2, 2] - 1) / 2
    return abs(axis_angle_cos - 1)

if __name__ == '__main__':
    mr = mtm('MTMR')
    while mr.enable() == False:
        print('Enabling the master...')
        continue
    print('Mater enabled')
    
    while mr.home() == False:
        print('Homing the master...')
        continue
    print('Mater homed')

    rospy.init_node('robot_states_sub', anonymous = True)
    rospy.Subscriber('/flexiv/robot_states', RobotStates_CRTK, robotStateMsgCallback)
    align_state_pub = rospy.Publisehr('/MTM_align_state', Bool, queue_size = 100)
    ros_rate = rospy.Rate(10)

    cur_pose = mr.measured_cp()
    is_MTM_aligned = False
    while not rospy.is_shutdown():
        if computeDiffofRots(cur_pose.M, robot_pose) < 0.02:
            goal_pose = cur_pose
            goal_pose.M = robot_pose.M
            mr.move_cp(goal_pose)
            cur_pose = mr.measured_cp()
            is_MTM_aligned = False
        else:
            is_MTM_aligned = True
        align_state_pub.publish(is_MTM_aligned)
        ros_rate.sleep()
        
        if is_MTM_aligned:
            # detect user hand
            mr.body.servo_cf(np.array([0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))
            