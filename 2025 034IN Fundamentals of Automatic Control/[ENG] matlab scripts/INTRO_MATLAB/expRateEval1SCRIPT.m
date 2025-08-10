% solution of Exercise: Scalars and Maths Operations
% script expRateEval1SCRIPT.m

Tau_days = 1.5;

secPerDay = 60*60*24;
tau = Tau_days * secPerDay;

% inefficient solution
t1 = 0;
y1 = (1-exp(-t1/tau));

t2 = 1/10;
y2 = (1-exp(-t2/tau));

t3 = 120;
y3 = (1-exp(-t3/tau));

t4 = 2400;
y4 = (1-exp(-t4/tau));