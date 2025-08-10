% solution of Exercise: Vector Math Operations
% script: expRateEval_3_SCRIPT.m

clear % clean the MATLAB workspace
Tau_days = 1.5;

secPerDay = 60*60*24;
tau = Tau_days * secPerDay;

% let's define the time row array tVec
startT = 0;
endT = 648000; 
Nsamples = 10000;

tVec = linspace(startT, endT, Nsamples);

% evaluate the function using the time row-vector
y_vals = (1-exp(-tVec/tau));
