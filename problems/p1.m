%% Fundamentals of GPS - HW 3 - Problem 1

clear
clc

%% Part A

numMeas = 1;
numSims = 1000;

var_a = 10;
var_b = 25;

sigma_a = sqrt(var_a);
sigma_b = sqrt(var_b);
sigma_y = sqrt( (9 * var_a) + (16 * var_b) );

ysum = zeros(numSims, 1); % preallocation
ydiff = zeros(numSims, 1);

for j = 1:numSims
    a = sigma_a * randn(numMeas, 1);
    b = sigma_b * randn(numMeas, 1);
    
    ysum(j) = ( 3 .* a ) + ( 4 .* b );

    ydiff(j) = ( 3 .* a ) - ( 4 .* b );
end

mean_ysum = mean(ysum);
mean_ydiff = mean(ydiff);

sigma_ysum = std(ysum);
sigma_ydiff = std(ydiff);

clearvars

%% Part B

numSims = 1000;

dt = 0.1; 
t_end = 6000; % end time (s)
t = 0:dt:t_end;
Ts = length(t);

sigma1 = 0.1;
sigma2 = 0.01;

wn1 = 0;
wn2 = 0;

int_wn1 = zeros(Ts, numSims); % preallocation
int_wn2 = zeros(Ts, numSims);

m_int_wn1 = zeros(numSims, 1);
m_int_wn2 = zeros(numSims, 1);

for i = 1:numSims
    
    noise1 = sigma1 * randn(Ts,1); % unit/s
    noise2 = sigma2 * randn(Ts,1); % unit/s
    
    for j = 1:Ts
        wn1 = wn1 + noise1(j)  * dt;
        wn2 = wn2 +  noise2(j)  * dt;
        
        int_wn1(j,i) = wn1;
        int_wn2(j,i) = wn2;
    end
    wn1 = 0;
    wn2 = 0;
end

mean_wn1 = mean(int_wn1,2);
mean_wn2 = mean(int_wn2,2);

std_wn1 = std(int_wn1, 0, 2);
std_wn2 = std(int_wn2, 0, 2);

an_std_wn1 = sigma1 .* sqrt(dt .* t);
an_std_wn2 = sigma2 .* sqrt(dt .* t);

figure
plot(t,an_std_wn1)
hold on
plot(t,std_wn1)
title('Random Walk Standard Deviation (\sigma_w = 0.1)')
xlabel('Time (s)')
ylabel('Standard Deviation')
legend('Analytical','Monte Carlo','Location','best')

figure
plot(t,int_wn1)
title('Random Walk: 1000 Simulations (\sigma_w = 0.1)')
xlabel('Time (s)')
ylabel('Integrated Noise Value')

figure
plot(t,an_std_wn2)
hold on
plot(t,std_wn2)
title('Random Walk Standard Deviation (\sigma = 0.01)')
xlabel('Time (s)')
ylabel('Standard Deviation')
legend('Analytical','Monte Carlo','Location','best')

figure
plot(t,int_wn2)
title('Random Walk: 1000 Simulations (\sigma = 0.01)')
xlabel('Time (s)')
ylabel('Integrated Noise Value')

clearvars

%% Part C

numSims = 1000;

sigma1 = 0.1;
sigma2 = 0.01;

dt = 0.1;
t_end = 6000;
t = 0:dt:t_end;
Ts = length(t);
tau1 = 1;
tau2 = 100;

A1 = 1 - (dt/tau1);
A2 = 1 - (dt/tau2);

sigma_x1 = sigma1 * dt * sqrt( (A1.^(2*t) - 1) ./ (A1.^2 - 1) );
sigma_x2 = sigma1 * dt * sqrt( (A2.^(2*t) - 1) ./ (A2.^2 - 1) );
sigma_x3 = sigma2 * dt * sqrt( (A1.^(2*t) - 1) ./ (A1.^2 - 1) );
sigma_x4 = sigma2 * dt * sqrt( (A2.^(2*t) - 1) ./ (A2.^2 - 1) );

x1 = 0;
x2 = 0;
x3 = 0;
x4 = 0;

x1_log = zeros(Ts, numSims);
x2_log = zeros(Ts, numSims);
x3_log = zeros(Ts, numSims);
x4_log = zeros(Ts, numSims);

for i = 1:numSims

    noise1 = sigma1 * randn(Ts,1); % unit/s
    noise2 = sigma2 * randn(Ts,1); % unit/s

    for j = 1:Ts
        
        x_dot1 = -(1/tau1) * x1 + noise1(j);
        x1 = x1 + x_dot1 * dt;
    
        x_dot2 = -(1/tau2) * x2 + noise1(j);
        x2 = x2 + x_dot2 * dt;

        x_dot3 = -(1/tau1) * x1 + noise2(j);
        x3 = x3 + x_dot3 * dt;
    
        x_dot4 = -(1/tau2) * x2 + noise2(j);
        x4 = x4 + x_dot4 * dt;

        x1_log(j,i) = x1;
        x2_log(j,i) = x2;
        x3_log(j,i) = x3;
        x4_log(j,i) = x4;
        
    end

    x1 = 0;
    x2 = 0;
    x3 = 0;
    x4 = 0;

end


% figure
% plot(t,an_std_wn1)
% hold on
% plot(t,std_wn1)
% title('Random Walk Standard Deviation (\sigma_w = 0.1)')
% xlabel('Time (s)')
% ylabel('Standard Deviation')
% legend('Analytical','Monte Carlo','Location','best')

clearvars