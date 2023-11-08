# Flexiv_CRTK
Flexiv CRTK wrappers provide [CRTK](https://github.com/collaborative-robotics/documentation/wiki) wrappers for [Flexiv RDK](https://github.com/flexivrobotics/flexiv_rdk). (v 0.6). 

C++ and Python wrappers are provided. As wrappers are based on derived classes of base classes in Flexiv RDK, they are also compatible with newer versions of RDK after necessary adjustments.
Flexiv states-CRTK query commands, Flexiv methods-CRTK motion commands correspondences are as follows.
| flexiv::RobotStates | CRTK query command | flexiv::Robot:: | CRTK motion command |
| :---: | :---: | :---: | :---: |
| q |   measured_js() | streamJointPositiion() | servo_jp() |
| theta | ≈measured_js() | streamJointTorque() | servo_jf() |
| tcpPose | measure_cp() | streamTcpPose() | servo_cp() |
| tcpVel | measured_cv() | sendJointPosition() | interpolate_jp()
| extRenchInBase | measured_cf() | sendTcpPose() | interpolate_cp() |
| / | setpoint_js/cp/cv/cf() | executePrimitive("MoveJ, ...") | move_jp() |
| / | goal_js() | executePrimitive("MovePTP, ...") | move_cp() |
| tcpPoseDes | goal_cp() | / | servo/interpolate_jv()/cv()/cf() |
| / | goal_cv() | / | servo/interpolate_jr()/cr() |

## C++ Wrapper
The C++ wrapper does not rely on a built Flexiv RDK. It needs to include two folders from [Flexiv RDK](https://github.com/flexivrobotics/flexiv_rdk):
- The `include/flexiv` folder containing public source files.
- The `lib` folder containing compiled outputs from unpublicized source codes.

The Robot_CRTK.hpp, where CRTK methods are implemented, includes source files in `include/flexiv`. 
- In the program, replace `#include your path to Robot.hpp` with `#include your path to Robot_CRTK.hpp`.
- When instancing a robot object, use `flexiv::Robot_CRTK robot(robotIP, localIP)` to replace `flexiv::Robot robot(robotIP, localIP)`. Everything else remains the same as introduced in the RDK, and CRTK methods will be invokable.
e.g. `robot.measured_jp()` will return the robot's joint position.
- When compiling the program, add the corresponding platform-dependent `.a` file in `lib` to the linked library list of the output target. 

## Python Wrapper
The Python wrapper does not rely on a built Flexiv RDK. It just needs to include the `lib_py` folder from [Flexiv RDK](https://github.com/flexivrobotics/flexiv_rdk). The `flexiv_crtk.py` implements CRTK methods and inherits methods 
of the original flexivrdk.Robot class. Import `flexiv_crtk.py` in the program to use CRTK methods.
