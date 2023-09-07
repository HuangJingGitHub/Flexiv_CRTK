#!/usr/bin/env python
import time
# Import Flexiv RDK Python library
# fmt: off
import sys
sys.path.insert(0, "../src/flexiv_include/lib_py")
import flexivrdk
# fmt: on

class Robot_CRTK(flexivrdk.Robot):
    def __init__(self, robot_ip, local_ip):
        flexivrdk.Robot.__init__(self, robot_ip, local_ip)
        self.cur_robot_states = flexivrdk.Robotstates()
        self.robot_mode = flexivrdk.Mode
    
    def measured_jp(self):
        self.getRobotStates(self, self.cur_robot_states)
        return self.cur_robot_states.q

    def measured_cp(self):
        self.getRobotStates(self, self.cur_robot_states)
        return self.cur_robot_states.tcpPose
    
    def measured_cv(self):
        self.getRobotStates(self, self.cur_robot_states)
        return self.cur_robot_states.tepVel

    def measured_cf(self):
        self.getRobotStates(self, self.cur_robot_states)
        return self.cur_robot_states.extForceInBaseFrame
    
    def goal_cp(self):
        self.getRobotStates(self, self.cur_robot_states)
        return self.cur_robot_states.tcpPoseDes
    
    def servo_jp(self, positions, velocities, accelerations):
        if self.getMode(self) != self.robot_mode.MODE_JOINT_POSITION:
            self.setMode(self, self.robot_mode.MODE_JOINT_POSITION)
            while self.getMode(self) != self.robot_mode.MODE_JOINT_POSITION:
                time.sleep(1)
            
        self.streamJointPosition(self, positions, velocities, accelerations)
    
    def servo_jf(self, torques, enableGravityComp = True, enableSoftLimits = True):
        self.streamJointTorque(self, torques, enableGravityComp, enableSoftLimits)
    
    def servo_cp(self, pose, maxWrench = [100.0, 100.0, 100.0, 30.0, 30.0, 30.0]):
        if self.getMode(self) != self.robot_mode.MODE_CARTESIAN_IMPEDANCE:
            self.setMode(self, self.robot_mode.MODE_CARTESIAN_IMPEDANCE):
            while self.getMode(self) != self.robot_mode.MODE_CARTESIAN_IMPEDANCE:
                time.sleep(1)
            
        self.streamTcpPose(self, pose, maxWrench)
    
    def interpolate_jp(self, positions, velocities, accelerations, maxVel, maxAcc, maxJerk):
        if self.getMode(self) != self.robot_mode.MODE_JOINT_POSITION_NRT:
            self.setMode(self, self.robot_mode.MODE_JOINT_POSITION_NRT):
            while self.getMode(self) != self.robot_mode.MODE_JOINT_POSITION_NRT:
                time.sleep(1)
            
        self.sendJointPosition(self, positions, velocities, accelerations, maxVel, maxAcc, maxJerk)
    
    def interpolate_cp(self, pose, maxWrench = [100.0, 100.0, 100.0, 30.0, 30.0, 30.0]):
        if self.getMode(self) != self.robot_mode.MODE_CARTESIAN_IMPEDANCE_NRT:
            self.setMode(self, self.robot_mode.MODE_CARTESIAN_IMPEDANCE_NRT)
            while self.getMode(self) != self.robot_mode.MODE_CARTESIAN_IMPEDANCE_NRT:
                time.sleep(1)

        self.sendTcpPose(self, pose, maxWrench);
    
    