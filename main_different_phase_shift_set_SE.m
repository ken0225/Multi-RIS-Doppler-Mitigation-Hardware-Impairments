% Author: Ke(Ken)WANG from Macao Polytechnic University
% Email: ke.wang@mpu.edu.mo, kewang0225@gmail.com
% Update infomation: v0.8(2022/June/25)

% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.


%% Clean All & Timer
close all;
clear;

%% Timer begins
tic;


%% System Parameters Initialization

global c0 fc speed total_elements_number total_time; % Global parameters

% -------- Changeable parameters begin -------- 
% You CAN change the parameters below to obtain different figures
% In this simulation we IGNORE the phase drifts

kappa_t = 0.03^2; % Transceiver HWI (Transmitter side)

kappa_r = kappa_t; % Transceiver HWI (Receiver side)

a_HWI = pi/4; % RIS HWI, from 0 to pi/2

Realization_HWI = 1; % The number of realizations, normally it is set to 1 but you can try another value say 10^3

K = 8;

MN = 32^2;

spacing = 50;

%  -------- Changeable parameters end -------- 

%  -------- Unchangeable parameters begin -------- 

total_elements_number = K*MN; 

c0 = physconst('LightSpeed'); % Light speed

fc= 2.4e9; % Carrier frequency is 2.4 GHz

disp(['Step 1: Parameter Initialization begin.']);

dx = (c0/fc)/(2*sqrt(pi)); dy = dx; % dxdy=\lambda^2/(4\pi), this means the element gain is 1. 

h_IRS = 15; % Height of the IRS

h_V = 2; % Height of the vehicle

h_BS = 20; % Height of the BS

speed = 20; % Speed of vehicle

total_time = 50; % Total time for one vehicle pass

Pt = 0.1; % Transmit power is 0.1W = 20dBm

N0 = 10e-12; % N0 = -80dBm

% The coordinate of the vehicle, i.e., the receiver
x_Vehicle_start = -500;
y_Vehicle = 0+h_V;
z_Vehicle = 100; 

% The coordinate of the Base Station, i.e., the transmitter
x_BS = 0;
y_BS = 0+h_BS;
z_BS = 200; 

%  -------- Unchangeable parameters end -------- 

%% Compute the trajectory for one vehicle pass

disp(['Step 2: Compute the trajectory for one vehicle pass. The speed is ' num2str(speed) ' m/s.']);

p_BS = [x_BS, y_BS, z_BS];

p_vehicle_start = [x_Vehicle_start, y_Vehicle, z_Vehicle];

% Total trajectory = starting point + moving trajectory per second (we start from 1s rather than 0s)
p_vehicle_trajectory = [];

% The vehicle starts at p_vehicle_start, and travels at the speed during total_time period
for aa = 1 : total_time
    
    temp_p_vehicle_trajectory =  p_vehicle_start+function_vehicle_moving_xdir(speed, aa);
    
    p_vehicle_trajectory = [p_vehicle_trajectory; temp_p_vehicle_trajectory];
    
end

% 'A_0' is the gain for the direct path. It is a theoretical result.
[A_0] = function_A0(p_BS, p_vehicle_trajectory);

% 'SE_no_IRS' is the SE for the direct path. It is a simulated result.
[SE_no_IRS]=function_compute_SE(A_0, Pt, N0, kappa_t, kappa_r);

%% Compute the gain when the IRS is without HWI using simulations
disp('Step 3: Compute the gain when the IRS is without HWI using simulations.');

% Compute the position for K RISs
[centers_IRS_K_RISs]=function_centers_multi_IRS(total_elements_number, dx, dy, K, spacing, h_IRS);

% Compute the delays
[tau_0, tau_mn] = function_time_delay(centers_IRS_K_RISs, p_BS, p_vehicle_trajectory); 

% % Optimal phase shift
k_imin = ceil(-(fc*(tau_0-tau_mn))); 

%k_imin = ceil(-(fc * (tau_0 - tau_mn))) + 1; % with error 
%k_imin = ceil(-(fc * (tau_0 - tau_mn))) + 0.2; % with error 

% Final phase shift after optimized
phi_optimal = 2*pi*(fc*(tau_0-tau_mn)+k_imin);

% Final phase part after optimized
exp_phi_optimal = exp(-1i*2*pi*fc.*tau_mn-1i.*phi_optimal);

% 'signal_IRS_without_HWI' is the gain for the cascaded link, and it is a simulated result.
[signal_IRS_wo_HWI] = function_Smn(p_BS, centers_IRS_K_RISs, p_vehicle_trajectory, total_time, dx, dy, exp_phi_optimal);

% 'signal_direct_without_HWI' is the gain for the direct link, and it is a simulated result.
[signal_direct_wo_HWI]=function_S0(A_0, tau_0);

% Total simulated gain 
signal_proposed = signal_IRS_wo_HWI+signal_direct_wo_HWI;

% 'SE_IRS_wo_HWI_Simulated' is the SE for the total link. It is a simulated result.
[SE_IRS_wo_HWI_Simulated]=function_compute_SE(signal_proposed, Pt, N0, 0, 0);

%% Step 4: Compute the gain when the IRS is without HWI analytically

disp('Step 4: Compute the gain when the IRS is without HWI analytically.');

% 'A_mn' is the gain for the cascaded link, and it is an analytical result.
[A_mn_wo_HWI, A_mn_matrix_wo_HWI] = function_Amn(p_BS, centers_IRS_K_RISs, p_vehicle_trajectory, total_time, dx, dy);

% 'A_mn_total' is total gain, it is a theoretical result, which means it cannot be achieved
A_mn_total_wo_HWI = A_mn_wo_HWI.' + A_0;

%% Compute the gain when the IRS is with HWI
disp(['Step 5: Compute the gain when the IRS is with HWI. Note that a_HWI =', num2str(a_HWI), ...
    ' and kappa_t=kappa_r=',num2str(kappa_t),'.']);

% Initialization 
signal_HWI_total_sum = zeros(1, total_time);

% for-loop for realizations of HWI
for aa = 1 : Realization_HWI

disp(['           =============This is the ',num2str(aa), '-th realiztion=============']);

% Generate Theta_IRS_HWI
theta_IRS_HWI = random('Uniform', -a_HWI, a_HWI, total_elements_number, total_time);
disp(['           =====The Theta_IRS_HWI of the (1, 1)-th element is ',num2str(theta_IRS_HWI(1,1)), '=====']);

% Final phase part
exp_phi_IRS_HWI = exp(-1i*2*pi*fc*tau_mn - 1i*(phi_optimal+theta_IRS_HWI));

% 'signal_IRS_HWI' is the gain with HWI for cascaded link, it is a simulated result
[signal_IRS_HWI] = function_Smn(p_BS, centers_IRS_K_RISs, p_vehicle_trajectory, total_time, dx, dy, exp_phi_IRS_HWI);

% 'signal_direct_HWI' is the gain with HWI for direct link, it is a simulated result
[signal_direct_HWI]=function_S0(A_0, tau_0);

% signal_HWI_total, it is a simulated result
signal_HWI_total = signal_IRS_HWI + signal_direct_HWI;

signal_HWI_total_all_Realization(aa, :) = signal_HWI_total;

end

% 'SE_IRS_w_HWI_Simulated' is the SE for the total link with HWI. It is a simulated result.
[SE_IRS_w_HWI_Simulated]=function_compute_SE(signal_HWI_total_all_Realization, Pt, N0, kappa_t, kappa_r);

%% Compute the  Gain/SE Approximation
disp('Step 4: Compute the gain when the IRS is with HWI analytically.');

A_star = [];
Q = [];

% Compute the A*
for bb = 1 : total_time
    
    temp_A_star=function_Astar(A_mn_matrix_wo_HWI(bb,:));
    A_star = [A_star; temp_A_star];
    
end

% Compute the Q
for cc = 1 : total_time
    
    temp_Q = function_Q(A_0(:,cc), A_star(cc,:), A_mn_matrix_wo_HWI(cc,:), a_HWI);
    Q = [Q; temp_Q];
    
end

Q = Pt*Q;

% Compute the SNR approximation
SNR_IRS_w_HWI_Analytical = (Q ./ ((kappa_t+kappa_r)*Q + N0))'; 

% Compute the SE approximation
SE_IRS_w_HWI_Analytical = log2(1+SNR_IRS_w_HWI_Analytical);


%% Plot the simulation results
close all;

disp('Step 6: Plot the simulation results.');

figure(1); hold on; box on; grid on;

moving_distance = linspace(1,total_time,total_time) .* speed; 

p1 = plot(moving_distance, SE_no_IRS, 'k:', 'LineWidth', 4);
p2 = plot(moving_distance, SE_IRS_wo_HWI_Simulated, 'b-<', 'LineWidth', 2, 'MarkerSize', 12);
p3 = plot(moving_distance, SE_IRS_w_HWI_Simulated, 'g-s', 'LineWidth', 2, 'MarkerSize', 12);
p4 = plot(moving_distance, SE_IRS_w_HWI_Analytical, 'k+', 'LineWidth', 2, 'MarkerSize', 14);

xlabel('Moving Distance (m)','Interpreter','LaTex');
ylabel('Spectral Efficiency (bit/s/Hz)','Interpreter','LaTex');

legend([p1(1),p2(1),p3(1),p4(1)],...
    'w/o RIS w/ Transceiver HWI','w/ RIS w/o HWI Simulated',...
    'w/ RIS w/ HWI Simulated','w/ RIS w/ HWI Analytical','Interpreter','LaTex','Location','SouthEast');

axis([380,620,5.5,7.5]);

%% Timer ends
toc;
