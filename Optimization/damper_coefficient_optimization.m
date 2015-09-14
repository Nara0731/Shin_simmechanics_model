% Optimization of MR Damper damping coefficient for compression and
% expansion phases.


addpath(genpath('../Images'))
addpath(genpath('../stl'))

% Set simulation parameters
%Y0 = 3;         % Initial heigh [m]
K = 2500;       % Spring constant [N/m]
c = 75;         % Damping coefficient [N/(m/s)]
D_max = 0.074;  % Damper maximum stroke size [m]
mass = 20;      % Dead mass at the top [kg]

%% -------  Avinash's model ------------

% Spring properties
Y = 80*10^9; %% young's modulus
w = 0.03;    %% width of the leaf spring
h = 0.013;   %% thickness of the leaf spring
kbar = 2*Y*w*h^3;
L = 0.6;     %% free length of the spring 

% MR Damper Props 
alf0 = -23.1;
alf1 = 1215.2;
beta0 = 36.5;
gam0 = 1.6;
del0 = 1297;
eta0 = 1202.7;
kap0 = 0;
i = 0;

%mdl = 'robot_shin_test';
%open(mdl);

%% ---------- Optimization ---------------
% we want to optimize the damping force post-impact. Hence, we need to
% optimize the current input to the MR damper post impact. This
% optimization will switch damper settings when changing from compression
% to expansion 

% Optimization parameters
i_coeffs0 = [1 2 3 4 5 6];       % Current profile spline coefficients
h0 = 5;                         % Drop height

% Parameters to optimize
q0 = [i_coeffs0, h0];

%sim_drop( shin, p0);

fprintf('Perfoming optimization...');
[p_opt,fval,exitflag,output] = fmincon(@(q)criterion(q),q0,[],[],[],[],[],[],@(q)constraints(q));
fprintf('Done\n');

% show results of simulation