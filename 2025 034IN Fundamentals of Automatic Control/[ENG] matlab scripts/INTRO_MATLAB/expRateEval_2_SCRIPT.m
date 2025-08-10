% solution of Exercise: Maths and Vector Operations
% script: expRateEval_2_SCRIPT.m

Tau_days = 1.5;

secPerDay = 60*60*24;
tau = Tau_days * secPerDay;

% let's define the time row array
t = [ 0, 1/10, 120, 2400];

% evaluate the function using the time row-vector
y_vals = (1-exp(-t/tau));

