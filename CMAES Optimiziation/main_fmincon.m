
% Purpose:  FMINCON optimization to find optimum damping profile 
% Filename: main_fmincon.m
% Author:   Roberto Shu
% Las edit: 14/9/2015
%------------------- Instructions ---------------------------

%------------------- Initialize workspace --------------------
clear all; close all; clc;
curDir = pwd;
mainDir = fileparts(curDir);
addpath(mainDir);
addpath(fullfile(mainDir,'Images'));
addpath(fullfile(mainDir,'stl'));

%------------------- Set initialization parameters ---------------------------

    global g Kg Bg;         % Environment constant
    global mass maxStroke;  % Shin properties
    global K;             % Spring damper properties
    global Y0 PE;           % Initial conditions
    global simFileName;     % Simulation file name   
    
    g = 9.81;   % Gravity acceleration [m/s^2]
    Kg = 12^5;  % Ground stiffness coefficient [N/m]
    Bg = 100;    % Ground damping coefficient [N-s/m]
    
    mass = 15; 
    maxStroke = 0.074;
    
    K = 7500;       % Spring constant [N/m]
    B = 1876;         % Damping coefficient [N/(m/s)]
    
    Y0 = 2;         % Initial height [m]
    PE = (mass+5)*g*Y0; % Initial potential energy []
    
    simFileName = 'robot_shin_v3';
    try 
        open(simFileName);
    end
    
    %optionSim = simset('SrcWorkspace','current');
    %sim(simFileName,[],optionSim);
    
%------------------- Optimization ---------------------------

% Set options of CMA-ES optimization
    LBounds = 0;  % no bounds
    UBounds = Inf;  % no bounds
    SaveFilename = 'fmincon_results2.mat';
    options = optimset('Display','iter','TolX',1e-15,'DiffMinChange',10);
    
% Set initial conditions
    X0 = B;
    InSigma = 10;
    criterionFileName = 'criterionV3';
    
% Perform optimization
    fprintf('Performing optimization...\n');
    fprintf('   Algorithm: FMINCON\n');
    tic;
    [results.optDamping, results.fval, results.stopflag, results.output] = fmincon(criterionFileName,X0,[],[],[],[],LBounds,UBounds,[],options);
    results.optimizationTime = toc;
    fprintf('done\n');
    
% Save results
save(SaveFilename, 'results');
