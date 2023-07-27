#include "robot_config.hpp"

void printQueryResult(const std::vector<double>& value) {
    if (value.size() == 0)
        return;

    std::cout << "[";
    for (int i = 0; i < value.size() - 1; i++)
        std::cout << value[i] << ", ";
    std::cout << value.back() << "]\n";
}

void PrintIntroduction() {
    std::cout << "Input number for testing CRTK methods: \n"
              << "0-All query commands\n"
              << "1-interpolated_cp()\n"
              << "2-servo_cp()\n"
              << "3-interpolated_jp()\n"
              << "4-servo_jp()\n"
              << "5-move_cp()\n"
              << "6-move_jp()\n"; 
}

int main(int argc, char** argv) {
    flexiv::Log log;
    try {
        flexiv::Robot_CRTK robot(robotIP, localIP);

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
        // Enable the robot, make sure the E-stop is released before enabling
        log.info("Enabling robot ...");
        robot.enable();

        // Wait for the robot to become operational
        int secondsWaited = 0;
        while (!robot.isOperational()) {
            std::this_thread::sleep_for(std::chrono::seconds(1));
            if (++secondsWaited == 10) {
                log.warn(
                    "Still waiting for robot to become operational, please "
                    "check that the robot 1) has no fault, 2) is booted "
                    "into Auto mode");
            }
        }
        log.info("Robot is now operational");

        PrintIntroduction();
        std::string test_flag;
        std::cout << "Press number to start the test.\n";
        getline(std::cin, test_flag);

        auto start_time_point = std::chrono::high_resolution_clock::now();
        auto end_time_point = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end_time_point - start_time_point);
        int total_time_microsecond = 0;
        // 0-querry commands
        if (test_flag == "0") {
            std::cout << "Calling robot.measured_jp()...\n";
            printQueryResult(robot.measured_jp());

            std::cout << "Calling robot.measured_cp()...\n";
            printQueryResult(robot.measured_cp());

            std::cout << "Calling robot.measured_cv()...\n";
            printQueryResult(robot.measured_cv());

            std::cout << "Calling robot.measured_cf()...\n";
            printQueryResult(robot.measured_cf());

            std::cout << "Calling robot.goal_cp()...\n";
            printQueryResult(robot.goal_cp());
        }
        // 1-interpolate_cp()
        else if (test_flag == "1") {
            int cnt = 0, time_step_millisecond = 1;
            double amplitude = 0.05, frequency = 0.5;
            std::vector<double> init_pose = robot.measured_cp();
            
            start_time_point = std::chrono::high_resolution_clock::now();
            while (true) {
                double y_variance = amplitude * sin(2 * M_PI * frequency * cnt * time_step_millisecond * 0.001);
                auto target_pose = init_pose;
                target_pose[1] += y_variance;
                robot.interpolate_cp(target_pose);
                cnt++;
                if (cnt == 5000)
                    break;
                std::this_thread::sleep_for(std::chrono::milliseconds(time_step_millisecond));
            }
            end_time_point = std::chrono::high_resolution_clock::now();
            duration = std::chrono::duration_cast<std::chrono::microseconds>(end_time_point - start_time_point);
            total_time_microsecond += duration.count();
            std::cout << "Average execution time for interpolate_cp() (5s test) is " << (float) total_time_microsecond / 1000 / 5000 - 1 << " ms\n";
        }
       // 2-servo_cp()
        else if (test_flag == "2") {
            int cnt = 0, time_step_millisecond = 1;
            double amplitude = 0.05, frequency = 0.5;
            std::vector<double> init_pose = robot.measured_cp();

            start_time_point = std::chrono::high_resolution_clock::now();
            while (true) {
                double y_variance = amplitude * sin(2 * M_PI * frequency * cnt * time_step_millisecond * 0.001);
                auto target_pose = init_pose;
                target_pose[1] += y_variance;
                robot.servo_cp(target_pose);
                cnt++;
                if (cnt == 100000)
                    break;                
                // std::this_thread::sleep_for(std::chrono::milliseconds(time_step_millisecond));
            }  
            end_time_point = std::chrono::high_resolution_clock::now();
            duration = std::chrono::duration_cast<std::chrono::microseconds>(end_time_point - start_time_point);
            total_time_microsecond += duration.count();
            std::cout << "Average execution time for servo_cp() (5s test) is " << (float) total_time_microsecond / 1000 / 100000 << " ms\n";                     
        }
        // 3-interpolate_jp()
        else if (test_flag == "3") {
            int cnt = 0, time_step_millisecond = 1;
            double amplitude_joint = 0.15, frequency = 0.5;
            std::vector<double> init_joint_position = robot.measured_jp();
            std::vector<double> target_joint_velocities(robot.robot_dof_num, 0.2);
            std::vector<double> target_joint_accelerations(robot.robot_dof_num, 0.5);
            std::vector<double> max_joint_velocities(robot.robot_dof_num, 0.5);
            std::vector<double> max_joint_accelerations(robot.robot_dof_num, 0.5);
            std::vector<double> max_joint_jerk(robot.robot_dof_num, 0.8);

            start_time_point = std::chrono::high_resolution_clock::now();
            while (true) {
                double joint_variance = amplitude_joint * sin(2 * M_PI * frequency * cnt * time_step_millisecond * 0.001);
                auto target_joint_position = init_joint_position;
                target_joint_position[1] += joint_variance;
                robot.interpolate_jp(target_joint_position, target_joint_velocities, target_joint_accelerations, max_joint_velocities,
                                    max_joint_accelerations, max_joint_jerk);
                cnt++;
                if (cnt == 5000)
                    break;                      
                std::this_thread::sleep_for(std::chrono::milliseconds(time_step_millisecond));
            }     
            end_time_point = std::chrono::high_resolution_clock::now();
            duration = std::chrono::duration_cast<std::chrono::microseconds>(end_time_point - start_time_point);
            total_time_microsecond += duration.count();
            std::cout << "Average execution time for interpolate_jp() (5s test) is " << (float) total_time_microsecond / 1000 / 5000 - 1 << " ms\n";                       
        }
        // 4-servo_jp()
        else if (test_flag == "4") {
            int cnt = 0, time_step_millisecond = 1;
            double amplitude_joint = 0.15, frequency = 0.5;
            std::vector<double> init_joint_position = robot.measured_jp();
            std::vector<double> target_joint_velocities(robot.robot_dof_num, 0.2);
            std::vector<double> target_joint_accelerations(robot.robot_dof_num, 0.5);
            
            start_time_point = std::chrono::high_resolution_clock::now();
            while (true) {
                double joint_variance = amplitude_joint * sin(2 * M_PI * frequency * cnt * time_step_millisecond * 0.001);
                auto target_joint_position = init_joint_position;
                target_joint_position[1] += joint_variance;
                robot.servo_jp(target_joint_position, target_joint_velocities, target_joint_accelerations);
                cnt++;
                if (cnt == 100000)
                    break;
                // std::this_thread::sleep_for(std::chrono::milliseconds(time_step_millisecond));
            }    
            end_time_point = std::chrono::high_resolution_clock::now();
            duration = std::chrono::duration_cast<std::chrono::microseconds>(end_time_point - start_time_point);
            total_time_microsecond += duration.count();
            std::cout << "Average execution time for servo_jp() (5s test) is " << (float) total_time_microsecond / 1000 / 100000 << " ms\n";                      
        }
        // 5-move_cp()    
        else if (test_flag == "5") {
            int cnt = 0, time_step_millisecond = 1;
            double amplitude = 0.05, frequency = 0.5;
            std::vector<double> init_pose = robot.measured_cp();
            std::vector<double> target_pose_6D(6, 0);
            for (int i = 0; i < 3; i++)
                target_pose_6D[i] = init_pose[i] + 0.05;
            for (int i = 3; i < 6; i++)
                target_pose_6D[i] = 50;
            robot.move_cp(target_pose_6D);    
        } 
        // 6-move_jp()    
        else if (test_flag == "6") {
            int cnt = 0, time_step_millisecond = 1;
            double amplitude = 0.05, frequency = 0.5;
            std::vector<double> init_joint_position = robot.measured_jp();
            std::vector<double> target_joint_position = init_joint_position;
            for (int i = 0; i < target_joint_position.size(); i++) {
                target_joint_position[i] = target_joint_position[i] / M_PI * 180;
                target_joint_position[i] -= 10;
            }
            robot.move_jp(target_joint_position);
        }   
        else {
            std::cout << "Invalid input, exiting......\n";
            return 1;
        }                   
    } catch (const flexiv::Exception& e) {
        log.error(e.what());
        return 1;
    }
    return 0;
}
