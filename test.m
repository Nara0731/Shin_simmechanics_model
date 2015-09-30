    clear all; clc;
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
    B = 1881.7;         % Damping coefficient [N/(m/s)]
    
    Y0 = 2;         % Initial height [m]
    PE = (mass+10)*g*Y0; % Initial potential energy []
    
    simFileName = 'robot_shin_v3';
    sim(simFileName);
    
    workDone_damper = trapz(stroke.data,abs(Fd.data));
    workDone_spring = trapz(stroke.data,Fs.data);
    workDone_all1 = trapz(Force.time,Force.data);
    workDone_all2 = workDone_damper + workDone_spring;
    maxGRF = max(abs(GRF.data));
    score = (PE - workDone_spring - workDone_damper);
    
    % Plot results
    figure
    subplot(1,2,1)
    plot(Fd.time, Fd.data);
    title('Damper force [N]')
    subplot(1,2,2)
    plot(Fs.time, Fs.data);
    title('Spring force [N]')
    
    figure
    plot(GRF.time,GRF.data);
    title('GRF [N]')
    
    figure
    plot(height.time,height.data);
    title('Height profile [m]')
    
    figure
    plot(stroke.time, stroke.data);
    title('Damper stroke')
    
    figure
    subplot(1,2,1)
    plot(stroke.data,Fs.data)
    xlabel('Stroke [m]')
    ylabel('Spring Froce [N]')
    subplot(1,2,2)
    plot(stroke.data,Fd.data)
    xlabel('Stroke [m]')
    ylabel('Damper Froce [N]')
    
    
    