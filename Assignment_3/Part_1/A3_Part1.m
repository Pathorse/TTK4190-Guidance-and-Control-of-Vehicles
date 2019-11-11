%% Assignment 3 - Part 1

% Add handoutfiles to path
addpath('/Users/paalthorseth/Documents/Git/TTK4190/Assignment_3/Handouts/Matlab');
addpath('/Users/paalthorseth/Documents/Git/TTK4190/MSS-master');

%% Task 1.2

% Not needed for this task
K_p = 0;
K_d = 0;
K_i = 0;

% Rudder reference
delta_c = -5*pi/180;

% Simulate system
run;

% Heading rate, r(t)
fun     = @(x,xdata)(r0*exp(-xdata/x(1)) + (1 - exp(-xdata/x(1)))*x(2)*delta_c);

% Defining data
x0      = [50,0.1]';
xdata   = t;
ydata   = r*180/pi; % Heading rate in deg/s

% Nonlinear curve fitting using least squares
x       = lsqcurvefit(fun, x0, xdata, ydata);

% Plotting solution
times = linspace(xdata(1),xdata(end));
plot(xdata, ydata,'ko',times,fun(x,times),'b-');
title('Nonlinear least-squares fit of MS Fart�ystyring model for \delta = 5 (deg)')
xlabel('time (s)')
legend('Nonlinear model','Estimated 1st-order Nomoto model')

% Model parameters
T       = x(1);
K       = x(2);

%% Task 1.3



%% Task 1.4

% Heading control parameters
zeta    = 1;        % Damping ratio
omega_n = 10*0.004; % Natural frequency

K_p     = T/K * omega_n^2; 
K_i     = omega_n/10 * K_p;
K_d     = 1/K * (2*zeta*omega_n*T - 1);


%% Run simulation

% run;