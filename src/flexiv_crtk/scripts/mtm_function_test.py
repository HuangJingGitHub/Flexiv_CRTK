#!/usr/bin/env python
import numpy as np
import PyKDL as kdl
from dvrk import mtm
import math

robot_pose = kdl.Frame()
robot_pose.M[0, 0] = -1
robot_pose.M[1, 1] = 0
robot_pose.M[2, 1] = 1
robot_pose.M[2, 2] = 0
robot_pose.M[1, 2] = 1

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

    initial_pose = ml.measured_cp()
    time = 0.01
    while True:
        target_pose = initial_pose
        target_pose.p[0] += 0.01 * math.sin(time)
        ml.move_cp(target_pose)

            