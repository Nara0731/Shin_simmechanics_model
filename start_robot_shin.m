

addpath(genpath('Images'))
addpath(genpath('stl'))

% Constants
g = 9.81;  % Gravity acceleration [m/s^2]
% Ground Model
Kg = 10^4;  % Ground stiffness coefficient [N/m]
Cg = 75;    % Ground damping coefficient [N-s/m]

% Set simulation parameters
Y0 = 2;         % Initial heigh [m]
K = 7500;       % Spring constant [N/m]
C = 75;         % Damping coefficient [N/(m/s)]
D_max = 0.074;  % Damper maximum stroke size [m]
mass = 20;      % Dead mass at the top [kg]


% Calculate Initial potential energy
PE = mass*g*Y0;

% -------  Avinash's model ------------

% Spring properties

Y = 80*10^9; %% young's modulus
w = 0.03;    %% width of the leaf spring
h = 0.013;   %% thickness of the leaf spring
kbar = 2*Y*w*h^3;
L = 0.6;     %% free length of the spring 


% Damper properties
c = 250;  %% passive damper

%% MR Damper Props 
alf0 = -23.1;
alf1 = 1215.2;
beta0 = 36.5;
gam0 = 1.6;
del0 = 1297;
eta0 = 1202.7;
kap0 = 0;
i = 0;
i_comp = 0;
i_exp = 1;
damp_satur = 5000;

i_coeffs = [1, 2, 3, 4, 5, 6]; 
mdl = 'robot_shin_test';
%open(mdl);
sim(mdl);