%% INTRODUCTION %%

% File: sat_reaction_wheels_aocs.m
% Author: Yuvannithi Thirumaran
% Date: August 6, 2024

% Description: This MATLAB and Simulink project implements an attitude 
% control system for a satellite using reaction wheel-based control. 
% Simulation results include satellite attitude (Euler angles and 
% quaternions), angular rate, momentum, and torque (satellite and reaction 
% wheels).

% Dependencies: Simulink

close all
clear
clc

%% GIVEN %%

% Intial Attitude in degrees
initialAttitude = [0; 0; 0]; % [phi; theta; psi]

% Initial Rate in degrees per second
initialRate = [15; -15; 15];  % [phiDot; thetaDot; psiDot]

% Desired Attitude in degrees
desiredAttitude = [30; 50; 70]; % [phi; theta; psi]

% Desired Rate in degrees per second
desiredRate = [0.2; 0.2; 0.2]; % [phiDot; thetaDot; psiDot]

% Moment of Inertia of Reaction Wheel
moiReactionWheel = 0.00042; % in kg m^2

% Moment of Inertia of Satellite
moiSatellite = [2.10 0.00 0.01;
                0.00 2.30 -0.03;
                0.01 -0.03 1.72]; % in kgm^2

% Disturbance Torque Acting on the Satellite in the ECI Frame
disturbanceTorque = [10^-6; 10^-6; 10^-6]; % in Nm

% Maximum Torque Generated by the Reaction Wheel
maxTorqueReactionWheel = 0.015; % in Nm

% Angular Momentum Generated by the Reaction Wheel
amReactionWheel = 0.035; % in Nms

%% SIMULATION PARAMETERS %%

% PD Controller Gains
kp = [1; 1; 1]; % proportional gain
kd = [1; 1; 1]; % derivative gain

% Reaction Wheel Tilt Angle in degrees
beta = 28.5;

%% MODELING AND SIMULATION

out = sim('sim_sat_reaction_wheels_aocs.slx', 1*60);
out.logsout;

%% PLOTS %%

% Satellite torque
time1 = out.logsout{1}.Values.Time;
data1 = out.logsout{1}.Values.Data;
figure('Name', 'sat_torque')
subplot(3, 1, 1)
plot(time1, data1(:,1), 'linewidth', 2)
grid on
title('Satellite torque')
ylabel('\tau_{x} (Nm)');
subplot(3, 1, 2)
plot(time1, data1(:,2), 'linewidth', 2)
grid on
ylabel('\tau_{y} (Nm)')
subplot(3, 1, 3)
plot(time1, data1(:,3), 'linewidth', 2)
grid on
ylabel('\tau_{z} (Nm)')
xlabel('Time (s)')

% Reaction wheels torque
time2 = out.logsout{2}.Values.Time;
data2 = out.logsout{2}.Values.Data;
figure('Name', 'reaction_wheels_torque')
subplot(2, 2, 1)
plot(time2, data2(:,1), 'linewidth', 2)
yline(maxTorqueReactionWheel, 'r--');
yline(-maxTorqueReactionWheel, 'r--');
title('Reaction wheels torque')
grid on
ylabel('\tau_{rw_{1}} (Nm)');
ylim([-1.5*maxTorqueReactionWheel, 1.5*maxTorqueReactionWheel])
subplot(2, 2, 2)
plot(time2, data2(:,2), 'linewidth', 2)
yline(maxTorqueReactionWheel, 'r--');
yline(-maxTorqueReactionWheel, 'r--');
title('Reaction wheels torque')
grid on
ylabel('\tau_{rw_{2}} (Nm)')
ylim([-1.5*maxTorqueReactionWheel, 1.5*maxTorqueReactionWheel])
subplot(2, 2, 3)
plot(time2, data2(:,3), 'linewidth', 2)
yline(maxTorqueReactionWheel, 'r--');
yline(-maxTorqueReactionWheel, 'r--');
grid on
ylabel('\tau_{rw_{3}} (Nm)')
xlabel('Time (s)')
ylim([-1.5*maxTorqueReactionWheel, 1.5*maxTorqueReactionWheel])
subplot(2, 2, 4)
plot(time2, data2(:,4), 'linewidth', 2)
yline(maxTorqueReactionWheel, 'r--');
yline(-maxTorqueReactionWheel, 'r--');
grid on
ylabel('\tau_{rw_{4}} (Nm)')
xlabel('Time (s)')
ylim([-1.5*maxTorqueReactionWheel, 1.5*maxTorqueReactionWheel])

% Satellite angular momentum
time3 = out.logsout{3}.Values.Time;
data3 = out.logsout{3}.Values.Data;
figure('Name', 'sat_angular_momentum')
subplot(3, 1, 1)
plot(time3, data3(:,1), 'linewidth', 2)
title('Satellite angular momentum')
grid on
ylabel('H_{x} (Nms)');
subplot(3, 1, 2)
plot(time3, data3(:,2), 'linewidth', 2)
grid on
ylabel('H_{y} (Nms)')
subplot(3, 1, 3)
plot(time3, data3(:,3), 'linewidth', 2)
xlabel('Time (s)')
grid on
ylabel('H_{z} (Nms)')
xlabel('Time (s)')

% Satellite angular rate
time4 = out.logsout{4}.Values.Time;
data4 = out.logsout{4}.Values.Data;
figure('Name', 'sat_angular_rate')
subplot(3, 1, 1)
plot(time4, data4(:,1), 'linewidth', 2)
title('Satellite angular rate')
yline(desiredRate(1,1), 'r--')
grid on
ylabel('\omega_{x} (\circ/s)');
subplot(3, 1, 2)
plot(time4, data4(:,2), 'linewidth', 2)
yline(desiredRate(2,1), 'r--')
grid on
ylabel('\omega_{y} (\circ/s)');
subplot(3, 1, 3)
plot(time4, data4(:,3), 'linewidth', 2)
yline(desiredRate(3,1), 'r--')
grid on
ylabel('\omega_{z} (\circ/s)');
xlabel('Time (s)')

% Satellite attitude in quaternion
time5 = out.logsout{5}.Values.Time;
data5 = out.logsout{5}.Values.Data;
figure('Name', 'sat_attitude_quaternion')
subplot(2, 2, 1)
plot(time5, squeeze(data5(1,1,:)), 'linewidth', 2)
title('Satellite attitude in quaternion')
grid on
ylim([-1,1])
ylabel('q_{1}');
subplot(2, 2, 2)
plot(time5, squeeze(data5(2,1,:)), 'linewidth', 2)
title('Satellite attitude in quaternion')
grid on
ylim([-1,1])
ylabel('q_{2}')
subplot(2, 2, 3)
plot(time5, squeeze(data5(3,1,:)), 'linewidth', 2)
grid on
ylim([-1,1])
ylabel('q_{3}')
xlabel('Time (s)')
subplot(2, 2, 4)
plot(time5, squeeze(data5(4,1,:)), 'linewidth', 2)
grid on
ylim([-1,1])
ylabel('q_{4}')
xlabel('Time (s)')

% Satellite attitude in euler angles
time6 = out.logsout{6}.Values.Time;
data6 = out.logsout{6}.Values.Data;
figure('Name', 'sat_attitude_euler_angles')
subplot(3, 1, 1)
plot(time6, squeeze(data6(1,1,:)), 'linewidth', 2)
title('Satellite attitude in euler angles')
yline(desiredAttitude(1,1), 'r--')
grid on
ylabel('\phi (\circ)');
subplot(3, 1, 2)
plot(time6, squeeze(data6(2,1,:)), 'linewidth', 2)
yline(desiredAttitude(2,1), 'r--')
grid on
ylabel('\theta (\circ)')
subplot(3, 1, 3)
plot(time6, squeeze(data6(3,1,:)), 'linewidth', 2)
yline(desiredAttitude(3,1), 'r--')
grid on
ylabel('\psi (\circ)')
xlabel('Time (s)')