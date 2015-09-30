function [score] = criterion(C)
%CRITERION Set of criterion used to optimize the problem using CMA-Es
% Inputs:
%   - C:           coefficient of polynomial representing damping
%   profile
% Outputs:
%   - score:            objective function score value    
% Author:   Roberto Shu
%-------------------------------------------------------
global g;
global mass maxStroke;
global Y w h L kbar kbar1;
global Y0;
global mdl;

% Read query values
%a0 = C(1); a1 = C(2) ; a2 = C(3); a3 = C(4) ; a4 = C(5);
C_exp = C(1:5);
C_comp = C(6:10);
% Simulate drop with query coefficients
options = simset('SrcWorkspace','current');  % Set the simmechanics simulation workspace to be the functions workspace
try
    sim(mdl,[],options);

w = [1 1]; % cost function term weights
finalVel = 0.4429;
minStroke = 0;
maxGRF = 0;

% calculate bounce height
[~, bounce_height] = peakfinder(height.data);
if(length(bounce_height) < 2)
    maxBounce_height = 0;
else
    maxBounce_height = bounce_height(2);
end

% Score parameters
score = w(1)*(1/max(stroke.data))^2 ...       % Reward large stroke 
        + w(2)*(maxBounce_height)^2 ... % Penalize large bounce height
        + penalty(max(stroke.data), maxStroke) + penalty(min(stroke.data), minStroke) ...  % Constraint on stroke size
        + penalty(vel.data(end),finalVel);% ...
        %+ penalty(max(GRF), maxGRF);    % maximum ground reaction force constrain
catch err
    score = 1e99;
    display(err);
end


end

function [val] = penalty(x,x_d)
%PENALTY calculate penalty for being close to the boundary through barrier
%function

val = -log(x_d-x)*abs((x-x_d));

end
