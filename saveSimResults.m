
% Save simulation results

Leg.Kp = Kp;
Leg.Kd = Kd;
Leg.K = K;
Leg.B = B;
Leg.M = mass;
Leg.maxStroke = maxStroke;

save('data_3.mat','Leg','Fd','Fs','Force','tauK','GRF','height','hip_pos','stroke')