function [score] = criterion(angles)
%CRITERION Set of criterion used to optimize the problem using CMA-Es
% Inputs:
%   - angles:           set of angles to evaluate objective function
% Outputs:
%   - score:            objective function score value    
% Author:   Roberto Shu
%-------------------------------------------------------

 global pos_d rot_d;
 global com_lims ang_lims;
 global r_foot l_foot;


% Generate robot 
robot = drc4;

% Set joint angle 
for i = 2:29 
    robot.j(i).angle = angles(i-1);
end

% Do forward kinematics
[robot2 robot2_com robot2_mass] = drc_forward_kinematics( robot );

% Calculate right wrist orientat error
ornt_err = abs(v_map(robot.l(29).orientation*rot_d'));        % Vector with [dX, dY, dZ];
l_foot_ornt_err = abs(v_map(robot.l(11).orientation*l_foot.orntn'));
r_foot_ornt_err = abs(v_map(robot.l(17).orientation*r_foot.orntn'));

% Score parameters
    score = norm(robot2.j(29).position_w-pos_d,2)...                                            % Target position
            +ornt_err(1)+ornt_err(2)+ornt_err(3)...
            +(robot2_com(1)-com_lims(1))+(-robot2_com(1)-com_lims(1))...
            +(robot2_com(2)-com_lims(2))+(-robot2_com(2)-com_lims(2))...
            +penalty(robot2_com(1),com_lims(1)) + penalty(robot2_com(2),com_lims(2))...
            +norm(robot2.j(11).position_w-l_foot.pos,2)...
            +norm(robot2.j(17).position_w-r_foot.pos,2)...
            +l_foot_ornt_err(1)+l_foot_ornt_err(2)+l_foot_ornt_err(3)...
            +r_foot_ornt_err(1)+r_foot_ornt_err(2)+r_foot_ornt_err(3);
        
end

function A = hat_map(t)
    A = [0 -t(3) t(2) ; t(3) 0 -t(1) ; -t(2) t(1) 0] ;
end

function V = v_map(t)
    V = [t(8) t(3) t(4)] ;
end
