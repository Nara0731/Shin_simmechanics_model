% File name: parseLegModelData
% Description:  Initializes the variables required to run the simmechanics
%               model 'robot_leg_v1.slx'
% Author: Roberto Shu
% Last Edit: 10/6/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Clear workspace
%clear all; close all; clc;

% Load data
dataName = 'data_4.mat';
load(dataName);
modelName = 'SimMechanics Model';

%% Plots
color = 'k';
% Position
figure(1)
subplot(3,1,1)
hold on;
plot(height.time,height.data,color );
xlabel('time [sec]')
ylabel('Foot position [m]')
title(modelName)
subplot(3,1,2)
hold on;
plot(hip_pos.time,hip_pos.data,color );
xlabel('time [sec]')
ylabel('Hip position [m]')
subplot(3,1,3)
hold on;
plot(stroke.time,stroke.data,color )
xlabel('time [sec]')
ylabel('Damper stroke [m]')

% Forces
figure(2)
subplot(3,1,1)
hold on;
plot(Fs.time,Fs.data,color )
xlabel('time [sec]')
ylabel('Spring force [N]')
title(modelName)
subplot(3,1,2)
hold on;
plot(Fd.time,Fd.data,color )
xlabel('time [sec]')
ylabel('Damper force [N]')
subplot(3,1,3)
hold on;
plot(tauK.time,tauK.data,color )
xlabel('time [sec]')
ylabel('Knee torque [N/m]')

% GRF
figure(3)
plot(GRF.time,GRF.data,color)
hold on;
xlabel('time')
ylabel('GRF [N]')

