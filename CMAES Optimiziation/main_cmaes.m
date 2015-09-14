function results = main_cmaes()
% Purpose:  CMAES optimization to find optimum damping profile 
% Filename: maincmaes.m
% Author:   Roberto Shu
% Las edit: 14/9/2015
%------------------- Instructions ---------------------------

%------------------- Initialize workspace --------------------
clear all; close all; clc;
curDir = pwd;
mainDir = fileparts(curDir);
addpath(mainDir);
addpath(fullfile(mainDir,'Images'));
addpath(fullfile(mainDir,'Optimization'));
addpath(fullfile(mainDir,'stl'));

%------------------- Set initialization parameters ---------------------------

    global g;
    global mass maxStroke;
    global Y w h L kbar kbar1;
    global Y0;
    global mdl;
    
    g = 9.81;
    mass = 15; maxStroke = 0.074;
    Y = 80*10^9; %% young's modulus
    w = 0.03;    %% width of the leaf spring
    h = 0.013;   %% thickness of the leaf spring
    kbar = 2*Y*w*h^3;
    kbar1 = 3.5010*10^3;
    L = 0.558;
    Y0 = 2;
  
    coeff0 = zeros(5,1);
    mdl = 'robot_shin_v2';
    open(mdl);
%------------------- Optimization ---------------------------
% Set options of CMA-ES optimization
    options.LBounds = -1e+04*ones(5,1);  % no bounds
    options.UBounds = 1e+04*ones(5,1);  % no bounds
    options.Restarts = 5;
    options.StopIter = 35000;
    options.TolFun = 1e-6;
    options.SaveVariables = 'final';
    options.SaveFilename = 'final_results.txt';

% Perform optimization
    fprintf('Performing optimization...\n');
    fprintf('   Algorithm: CMA-ES\n');
    tic;
    [results.optAngles, results.fval, counteval, stopflag, out, bestever] = cmaes('criterion',coeff0,[],options);
    results.optimizationTime = toc;
    fprintf('done\n');
    
% %------------------- Forward Kinematics ---------------------------
% % Load robot
%     robot = drc4;
%     
% % Set optimized angles to robot
%     for i = 2:29
%         robot.j(i).angle = results.optAngles(i-1);
%     end
% 
% % Do forward kinematics
%     [results.robot, results.robot_com, results.robot_mass] = drc_forward_kinematics( robot );
% 
% %------------------- Print Results ---------------------------
% % Draw robot and target
%     draw(results.robot,2,[0,0,1])
%     figure(2)
%     hold on;
%     plot3(pos_d(1),pos_d(2),pos_d(3),'go','MarkerFaceColor','g');
%     hold off;
%     
% % Prepare results
%     results.r_wrist_err = norm(results.robot.j(29).position_w-pos_d,2);                        % Right wrist position error
%     results.r_foot_err.pos = norm(results.robot.j(17).position_w-r_foot.pos,2);                % Right foot position change
%     results.r_foot_err.ornt = abs(v_map(results.robot.l(17).orientation*r_foot.orntn'));        % Right foot orientation change
%     results.l_foot_err.pos = norm(results.robot.j(11).position_w-l_foot.pos,2);                % Left foot position change
%     results.l_foot_err.rot = abs(v_map(results.robot.l(11).orientation*l_foot.orntn')); 
%     
% % Print results
%     fprintf('Target position: [%d,%d,%d]\r\n\r\n',pos_d(1),pos_d(2),pos_d(3));
%     
%     fprintf('Optimization method: CMA-ES\r\n\r\n');
%     
%     fprintf('Optimization Performance:\r\n');
%     fprintf('--------------------------\r\n');
%     fprintf('  Objective function value: %d\r\n', results.fval);
%     fprintf('  Right foot position error: %d\r\n',results.r_foot_err.pos);
%     fprintf('  Left foot position error: %d\r\n',results.l_foot_err.pos);
%     fprintf('  Center of mass [x,y,z] location: [%d,%d,%d]\r\n', results.robot_com(1),results.robot_com(2),results.robot_com(3));
%     fprintf('  Run time: %d\r\n\r\n', results.optimizationTime);
% 
%     fprintf('Optimization results:\r\n');
%     fprintf('----------------------------------------------------------\r\n');
%     fprintf('%6s %12s %16s %18s\r\n','Joint','Value','Lower limit','Upper limit');
%     fprintf('%6.0f %12.4f %16.4f %18.4f \r\n',[1:28;results.optAngles';ang_lims.lb;ang_lims.ub]);
end