

addpath(genpath('Images'))
addpath(genpath('stl'))

% Set simulation parameters
Y0 = 1;     % Initial heigh [m]
K = 2500;   % Spring constant [N/m]
C = 75;     % Damping coefficient [N/(m/s)]

%K = 0;
%C = 0;
% -------  Avinash's model ------------

% Spring properties

Y = 80*10^9; %% young's modulus
w = 0.03;    %% width of the leaf spring
h = 0.013;   %% thickness of the leaf spring
kbar = 2*Y*w*h^3;
L = 0.6;     %% free length of the spring 

% Damper properties
c = 17.5;
c = 75;


mdl = 'robot_shin_test';
open(mdl);
sim(mdl);