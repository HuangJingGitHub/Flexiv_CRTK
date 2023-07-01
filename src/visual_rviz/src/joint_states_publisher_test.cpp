#include <ros/ros.h>
#include <sensor_msgs/JointState.h>

int main( int argc, char** argv) {
  int joint_num = 7;
  ros::init(argc, argv, "basic_shapes");
  ros::NodeHandle n;
  ros::Rate r(10);
  ros::Publisher joint_states_pub = n.advertise<sensor_msgs::JointState>("/joint_states", 10000);

  std::vector<std::string> joint_name_vec;
  for (int i = 1; i <=7; i++)
    joint_name_vec.push_back("joint" + std::to_string(i));
  // Set our initial shape type to be a cube

  int time = 0;
  while (ros::ok()) {
    sensor_msgs::JointState cur_joint_state;

    cur_joint_state.header.stamp = ros::Time::now();
    for (int i = 0; i < joint_num; i++) {
      cur_joint_state.name = joint_name_vec;
      cur_joint_state.position.push_back(0);
      cur_joint_state.velocity.push_back(0);
      cur_joint_state.effort.push_back(0);
    }
    
    cur_joint_state.position[1] = sin(time * 0.01);
    cur_joint_state.position[3] = sin(time * 0.01);
    cur_joint_state.position[5] = cos(time * 0.01);
    time++;
    // Publish the marker
    joint_states_pub.publish(cur_joint_state);
    r.sleep();
  }
}
