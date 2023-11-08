# Flexiv_CRTK
Flexiv CRTK wrappers provide [CRTK](https://github.com/collaborative-robotics/documentation/wiki) wrappers for [Flexiv RDK](https://github.com/flexivrobotics/flexiv_rdk). (v 0.6). 

C++ and Python wrappers are provided. As wrappers are based on derived classes of base classes in Flexiv RDK, they are also compatible with newer versions of RDK after necessary adjustments.
The Flexiv states---CRTK query commands, Flexiv methods---CRTK motion commands correspondence are as follows.
| flexiv::RobotStates | CRTK query commands |
|---------------------|---------------------|
|        q            |   measured_js()     |

## C++ Wrapper
The C++ wrapper does not rely on a built Flexiv RDK. It just needs to include two folders from [Flexiv RDK](https://github.com/flexivrobotics/flexiv_rdk):
- The `include/flexiv` folder containing public source files.
- The `lib` folder containing compiled outputs from unpublicized source codes.

The Robot_CRTK.hpp, where CRTK methods are implemented, includes source files in `include/flexiv`. In the program, replace `#include your path to Robot.hpp` with `#include your path to Robot_CRTK.hpp`.
When instancing a robot object, use `flexiv::Robot_CRTK robot(robotIP, localIP)` to replace `flexiv::Robot robot(robotIP, localIP)`. Everything else remains the same as introduced in the RDK, and CRTK methods will be invokable.
e.g. `robot.measured_jp()` will return the robot's joint position.

When compiling the program, add the corresponding platform-dependent `.a` file in `lib` to the linked library list of the output target. 

## Python Wrapper
The Python wrapper does not rely on a built Flexiv RDK. It just needs to include the `lib_py` folder from [Flexiv RDK](https://github.com/flexivrobotics/flexiv_rdk). The `flexiv_crtk.py` implements CRTK methods and inherits methods 
of the original flexivrdk.Robot class. Import `flexiv_crtk.py` in the program to use CRTK methods.
