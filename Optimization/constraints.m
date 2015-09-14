function [ineq_violations, eq_violations ] = constraints(q)

% Last Updated: 7/6/2015

%% Read input

% Query values q
i_coeffs = q(1:6);
h0 = q(7);

I = i_profile(i_coeffs, t);

% Constraint values
maxI = 2;
minI = 2;
hmin = 1; 

%% Implement constraints subject to:
temp_ceq = [];
temp_c = [];

%% Equality constraints

%% Inequality constraints
idx = 0;

% s.t. Damper coefficient limits
% idx = idx + 1;
% temp_c(idx) = q(2) - shin.damper.Kdmax;
% 
% idx = idx + 1;
% temp_c(idx) = shin.damper.Kdmin - q(2);

% s.t. current limits
idx = idx + 1;
temp_c(idx) = I - maxI;

idx = idx + 1;
temp_c(idx) = minI - I;

% s.t. drop height has to be positive and greater than leg length
idx = idx + 1;
temp_c(idx) = hmin - h0;

% Set violations
eq_violations = temp_ceq';
ineq_violations = temp_c';

end

