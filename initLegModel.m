% File name: initLegModel
% Description:  Initializes the variables required to run the simmechanics
%               model 'robot_leg_v1.slx'
% Author: Roberto Shu
% Last Edit: 9/27/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Clear workspace
clear all; close all; clc;

g = 9.81;   % Gravity acceleration [m/s^2]
Kg = 12^5;  % Ground stiffness coefficient [N/m]
Bg = 100;    % Ground damping coefficient [N-s/m]

mass = 15; 
maxStroke = 0.074;

K = 7500;       % Spring constant [N/m]
B = 1881.7;         % Damping coefficient [N/(m/s)]

phiH0 = -85*pi/180;    % Initial hip angle [rad]
phiK0 = 60*pi/180;    % Initial knee angle [rad]
dphiK0 = 0;    % Initial knee angle [rad]
ddphiK0 = 0;    % Initial knee angle [rad]
Y0 = 3;         % Initial height [m]

% Knee PD controller
Kp = 100;
Kd = 10;
