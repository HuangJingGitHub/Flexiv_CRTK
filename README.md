# Flexiv_CRTK
Flexiv CRTK wrappers provide [CRTK](https://github.com/collaborative-robotics/documentation/wiki) wrappers for [Flexiv RDK](https://github.com/flexivrobotics/flexiv_rdk). (v 0.6). 

C++ and Python wrappers are provided. As wrappers are based on derived classes of base classes in Flexiv RDK, they are also compatible with newer versions of RDK after necessary adjustments.

## C++ Wrapper Usage
The wrapper does not rely on a built Flexiv RDK. It just needs to include two folders:
- The `include/flexiv` folder in [Flexiv RDK](https://github.com/flexivrobotics/flexiv_rdk).
- The `lib` folder containing the compiled outputs not disclosed by Flexiv.
The Robot_CRTK.hpp, where CRTK methods are implemented, will include these source files. Then,  
