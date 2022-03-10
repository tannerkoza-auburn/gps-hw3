%% Fundamentals of GPS - HW 3 - Problem 4

clear
clc
close all

%% Part A-D

svPos = [0 300;
        100 400;
        700 400;
        800 300];

base = [400 0];

user = [401 0];

rcvrSigma = 0.5;
rcvr = gnssReceiver(rcvrSigma);

rho_user = sqrt( (svPos(:,1) - user(1)).^2 +  (svPos(:,2) - user(2)).^2 );
rho_base = sqrt( (svPos(:,1) - base(1)).^2 +  (svPos(:,2) - base(2)).^2 );

% Part A
pc2 = rcvr.p2DPC(rho_user(1:2,:), svPos(1:2,:)');
pc4 = rcvr.p2DPC(rho_user, svPos');

pc2.PDOP = sqrt( pc2.DOP(1,1)^2 + pc2.DOP(2,2)^2 );
pc4.PDOP = sqrt( pc4.DOP(1,1)^2 + pc4.DOP(2,2)^2 );
disp(pc2.PDOP)
disp(pc4.PDOP)

% Part B
cb = rcvr.p2D(rho_user, svPos');

cb.PDOP = sqrt( cb.DOP(1,1)^2 + cb.DOP(2,2)^2 );
disp(cb.PDOP)

% Part C
sd = rcvr.sdp2D(rho_user, rho_base, svPos', base);

sd.PDOP = sqrt( sd.DOP(1,1)^2 + sd.DOP(2,2)^2 );
disp(sd.PDOP)

% Part D
dd = rcvr.ddp2D(rho_user, rho_base, svPos', base);

dd.PDOP = sqrt( dd.DOP(1,1)^2 + dd.DOP(2,2)^2 );
disp(dd.PDOP)

figure
plot(base(1), base(2), 'g*')
hold on
plot(user(1), user(2), '*')
plot(pc2.pos(1), pc2.pos(2), '*')
plot(pc4.pos(1), pc4.pos(2), '*')
title('2D Position Estimate (Perfect Clock)')
legend('Base Station','User','2 SV User Est.','4 SV User Est.','Location','best')
axis padded
grid on

figure
plot(base(1), base(2), 'g*')
hold on
plot(user(1), user(2), '*')
plot(cb.pos(1), cb.pos(2), '*')
title('2D Position Estimate (Clock Bias)')
legend('Base Station','User','4 SV User Est.','Location','best')
axis padded
grid on

figure
plot(base(1), base(2), 'g*')
hold on
plot(user(1), user(2), '*')
plot(sd.pos(1), sd.pos(2), '*')
title('Single Difference 2D Position Estimate (Clock Bias)')
legend('Base Station','User','4 SV User Est.','Location','best')
axis padded
grid on

figure
plot(base(1), base(2), 'g*')
hold on
plot(user(1), user(2), '*')
plot(dd.pos(1), dd.pos(2), '*')
title('Double Difference 2D Position Estimate (Clock Bias)')
legend('Base Station','User','4 SV User Est.','Location','best')
axis padded
grid on

clearvars

%% Part E

svPos = [0 300;
        100 400;
        700 400;
        800 300];

base = [400 0];

user = [401 0];

rcvrSigma = 0.5;
rcvr = gnssReceiver(rcvrSigma);

rho_user = sqrt( (svPos(:,1) - user(1)).^2 +  (svPos(:,2) - user(2)).^2 ) + randn;
rho_base = sqrt( (svPos(:,1) - base(1)).^2 +  (svPos(:,2) - base(2)).^2 ) + randn;

% Part A
pc2 = rcvr.p2DPC(rho_user(1:2,:), svPos(1:2,:)');
pc4 = rcvr.p2DPC(rho_user, svPos');

pc2.PDOP = sqrt( pc2.DOP(1,1)^2 + pc2.DOP(2,2)^2 );
pc4.PDOP = sqrt( pc4.DOP(1,1)^2 + pc4.DOP(2,2)^2 );
disp(pc2.PDOP)
disp(pc4.PDOP)

% Part B
cb = rcvr.p2D(rho_user, svPos');

cb.PDOP = sqrt( cb.DOP(1,1)^2 + cb.DOP(2,2)^2 );
disp(cb.PDOP)

% Part C
sd = rcvr.sdp2D(rho_user, rho_base, svPos', base);

sd.PDOP = sqrt( sd.DOP(1,1)^2 + sd.DOP(2,2)^2 );
disp(sd.PDOP)

% Part D
dd = rcvr.ddp2D(rho_user, rho_base, svPos', base);

dd.PDOP = sqrt( dd.DOP(1,1)^2 + dd.DOP(2,2)^2 );
disp(dd.PDOP)

figure
plot(base(1), base(2), 'g*')
hold on
plot(user(1), user(2), '*')
plot(pc2.pos(1), pc2.pos(2), '*')
plot(pc4.pos(1), pc4.pos(2), '*')
title('2D Position Estimate (Perfect Clock)')
legend('Base Station','User','2 SV User Est.','4 SV User Est.','Location','best')
axis padded
grid on

figure
plot(base(1), base(2), 'g*')
hold on
plot(user(1), user(2), '*')
plot(cb.pos(1), cb.pos(2), '*')
title('2D Position Estimate (Clock Bias)')
legend('Base Station','User','4 SV User Est.','Location','best')
axis padded
grid on

figure
plot(base(1), base(2), 'g*')
hold on
plot(user(1), user(2), '*')
plot(sd.pos(1), sd.pos(2), '*')
title('Single Difference 2D Position Estimate (Clock Bias)')
legend('Base Station','User','4 SV User Est.','Location','best')
axis padded
grid on

figure
plot(base(1), base(2), 'g*')
hold on
plot(user(1), user(2), '*')
plot(dd.pos(1), dd.pos(2), '*')
title('Double Difference 2D Position Estimate (Clock Bias)')
legend('Base Station','User','4 SV User Est.','Location','best')
axis padded
grid on

clearvars