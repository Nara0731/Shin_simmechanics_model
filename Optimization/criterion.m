function [ score ] = criterion(q)


% Query values 
i_coeffs = q(1:6);
Y0 = q(7);

% Run Simulation 
sim('robot_shin_test','i_coeffs',i_coeffs,'Y0',Y0);
  
%% Cost function
score = 0;      % Reset score

% Penalize for bounce height
score = score + (max_bounce_height*10^3)^2

% Penalize high ground reaction force
score = score + max_GRF^2

end

