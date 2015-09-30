workDone_damper = trapz(Fd.time,Fd.data);
workDone_spring = trapz(Fs.time,Fs.data);
workDone_all1 = trapz(Force.time,Force.data);
workDone_all2 = workDone_damper + workDone_spring;