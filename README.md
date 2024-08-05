# Satellite Attitude Control System

## Description

This MATLAB/Simulink project implements a 3DOF reaction wheel-based Attitude and Orbit Control System (AOCS) for satellite attitude control. Utilizing quaternion representation for attitude kinematics, the system employs PD control for precise attitude tracking. It includes models for satellite dynamics, wheel momentum management, and sensor integration. This project is designed for aerospace engineers seeking practical applications of control theory in spacecraft systems.

## Features

- **3DOF Control**: Implements three degrees of freedom control using reaction wheels.
- **Quaternion Representation**: Utilizes quaternion for attitude kinematics.
- **PD Control**: Employs proportional-derivative control for attitude tracking.
- **Simulation**: Includes detailed simulation of satellite dynamics and control.
- **Sensor Integration**: Models sensor feedback for realistic control scenarios.

## Project Structure

- **pixxel_assignment.m**: Main MATLAB script that sets up the parameters, runs the simulation, and generates plots.
- **pixxel_assignment_model.slx**: Simulink model file for the AOCS.

## Getting Started

### Prerequisites

- MATLAB R2022b or later
- Simulink

### Running the Project

1. Clone the repository:

    ```sh
    git clone https://github.com/your-username/Satellite_Attitude_Control.git
    cd Satellite_Attitude_Control
    ```

2. Open MATLAB and navigate to the project directory.
3. Run the main script:

    ```matlab
    pixxel_assignment
    ```

4. View the simulation results in the generated plots.

## Author

Yuvannithi Thirumaran

## License

This project is licensed under the MIT License.
