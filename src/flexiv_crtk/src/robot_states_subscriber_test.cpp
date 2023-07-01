#include "ros/ros.h"
#include "flexiv_crtk/RobotStates_CRTK.h"

void msgArrivalCallback(const flexiv_crtk::RobotStates_CRTK& msg) {
    return;
}

int main(int argc, char **argv) {
    ros::init(argc, argv, "robot_states_sub_node");
    ros::NodeHandle node_handle;
    ros::Subscriber robot_states_subscriber = node_handle.subscribe("/flexiv/robot_states", 100, msgArrivalCallback);
}