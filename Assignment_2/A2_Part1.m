clear; close all;

%% Assignment 2 Part 1

A2_model;

%% Problem 1

% Ground speed
V_g = V_a;

%Dutch roll mode
dutch_roll_matrix = [A(1,1) A(1,4); A(4,1) A(4,4)];
eigs(dutch_roll_matrix);

%Spiral-divergence mode
eig_spiral = (A(4,4)*A(3,1)-A(4,1)*A(3,4))/A(3,1);

%Roll mode
eig_roll = A(3,3);

%% Problem 2

%% 2.a) -----------------------------------------------------------

a_phi_1 = -0.65;
a_phi_2 = 2.87;

H_p_delta_a = tf([0 a_phi_1], [1 a_phi_2]);

%% 2.b) -----------------------------------------------------------

delta_a_max = 30;
e_phi_max = 15;
zeta_phi = 0.707;
zeta_chi = 0.9;
d = 1.5;
W_chi = 7;
omega_n_phi = sqrt(abs(a_phi_2) * delta_a_max/e_phi_max);
omega_n_chi = 1/W_chi * omega_n_phi;

% Roll control parameters
k_p_phi = delta_a_max/e_phi_max * sign(a_phi_2);                    
k_i_phi = 0.0;   
k_d_phi = 2 * zeta_phi * omega_n_phi/a_phi_2;

% Course control parameters
k_p_chi = 2 * zeta_chi * omega_n_chi * V_g/g;     
k_i_chi = omega_n_chi^2 * V_g/g;  

H_phi_phic = tf([ k_p_phi*a_phi_2          k_i_phi*a_phi_2 ], ...
                [     1             (a_phi_1 + a_phi_2*k_d_phi) ...
                  k_p_phi*a_phi_2          k_i_phi*a_phi_2 ]);

tf_root_analysis_k_i_phi = tf([ 0                        k_i_phi*a_phi_2 ], ...
                [     1             (a_phi_1 + a_phi_2*k_d_phi) ...
                  k_p_phi*a_phi_2          k_i_phi*a_phi_2 ]);

% Plot rlocus
rlocus(tf_root_analysis_k_i_phi)



%% 2.c) -----------------------------------------------------------


%% 2.d) -----------------------------------------------------------
sim_time = 10;
chi_control = timeseries(ones(sim_time,1));

out = sim('model_autopilot', sim_time);

figure('rend','painters','pos',[10 10 750 400])
hold on;
plot(out.chi)
title("Plot of chi");
xlabel("time[s]");
ylabel("chi[deg]");
grid on;
hold off;

figure('rend','painters','pos',[10 10 750 400])
hold on;
plot(chi_control)
title("Plot of chi control");
xlabel("time[s]");
ylabel("chi control[deg]");
grid on;
hold off;

figure('rend','painters','pos',[10 10 750 400])
hold on;
plot(out.delta_control)
title("Plot of delta control");
xlabel("time[s]");
ylabel("delta control[deg]");
grid on;
hold off;


