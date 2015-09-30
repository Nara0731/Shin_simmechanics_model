function [score] = criterionV2(B)
%CRITERION Set of criterion used to optimize the problem using CMA-Es
% Inputs:
%   - C:           coefficient of polynomial representing damping
%   profile
% Outputs:
%   - score:            objective function score value    
% Author:   Roberto Shu
%-------------------------------------------------------
global g Kg Bg;         % Environment constant
global mass maxStroke;  % Shin properties
global K;             % Spring damper properties
global Y0 PE;           % Initial conditions
global simFileName;     % Simulation file name   

% Simulate drop with query coefficients
optionSim = simset('SrcWorkspace','current');  % Set the simmechanics simulation workspace to be the functions workspace
try
    % run simMechanics simulation
    sim(simFileName,[],optionSim);
    
    % Calculate system energy 
    workDone_damper = trapz(stroke.data,abs(Fd.data));      % Damper energy
    workDone_spring = trapz(stroke.data,abs(Fs.data));      % Spring energy
    workDone_all1 = trapz(stroke.data,Force.data);       % System energy method 1
    workDone_all2 = workDone_damper + workDone_spring;  % System energy method 2
    maxGRF = max(abs(GRF.data));
    % Score parameters
    score = (PE - workDone_spring - workDone_damper)^2;
    fprintf('Query value: %d | Score: %d | WrkDamper: %d | WrkSpring: %d  \n',B, score, workDone_damper, workDone_spring );
catch err
    score = 1e99;
    %display(err);
end


end
