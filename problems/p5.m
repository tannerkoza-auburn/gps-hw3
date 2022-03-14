%% Fundamentals of GPS - HW 3 - Problem 5 

clear
clc

%% Part A

load('satDataP2.mat')
user = svData;

rcvr = gnssReceiver;

userPsr = user{1}.psr;
userDopp = user{1}.dopp;
svPos = user{1}.pos;
svVel = user{1}.vel;
svClockCorr = user{1}.clkCorr;
band = 1;

est4 = rcvr.p3DPC(userPsr(1:4), svPos);

est4.PDOP = sqrt( est4.DOP(1,1)^2 + est4.DOP(2,2)^2 + est4.DOP(3,3)^2 )

est8 = rcvr.p3DPC(userPsr, svPos);
est8.PDOP = sqrt( est8.DOP(1,1)^2 + est8.DOP(2,2)^2 + est8.DOP(3,3)^2 )

clearvars
%% Part B

load('satData.mat')
base = svData;

load('satDataP2.mat')
user = svData;

rcvr = gnssReceiver;
basePos = [423203.359; -5361678.541; 3417280.681];

userPsr = user{1}.psr;
userDopp = user{1}.dopp;
svPos = user{1}.pos;
svVel = user{1}.vel;
svClockCorr = user{1}.clkCorr;
band = 1;

est4 = rcvr.pv3D(userPsr(1:4), userDopp(1:4), svPos, svVel, svClockCorr, band);
est4.PDOP = sqrt( est4.DOP(1,1)^2 + est4.DOP(2,2)^2 + est4.DOP(3,3)^2 )

est8 = rcvr.pv3D(userPsr, userDopp, svPos, svVel, svClockCorr, band);
est8.PDOP = sqrt( est8.DOP(1,1)^2 + est8.DOP(2,2)^2 + est8.DOP(3,3)^2 )

clearvars

%% Part C

load('satData.mat')
base = svData;

load('satDataP2.mat')
user = svData;

rcvr = gnssReceiver;
basePos = [423203.359; -5361678.541; 3417280.681];

userPsr = user{1}.psr;

basePsr = base{89}.psr;
baseDopp = base{89}.dopp;
basePsr(5) = [];
baseDopp(5) = [];
svPos = user{1}.pos;
svVel = user{1}.vel;
svClockCorr = user{1}.clkCorr;
band = 1;

est4 = rcvr.sdp3D(userPsr(1:4), basePsr(1:4), svPos, basePos);
est4.PDOP = sqrt( est4.DOP(1,1)^2 + est4.DOP(2,2)^2 + est4.DOP(3,3)^2 )

est8 = rcvr.sdp3D(userPsr, basePsr, svPos, basePos);;
est8.PDOP = sqrt( est8.DOP(1,1)^2 + est8.DOP(2,2)^2 + est8.DOP(3,3)^2 )

clearvars

%% Part D

load('satData.mat')
base = svData;

load('satDataP2.mat')
user = svData;

rcvr = gnssReceiver;
basePos = [423203.359; -5361678.541; 3417280.681];

userPsr = user{1}.psr;

basePsr = base{89}.psr;
baseDopp = base{89}.dopp;
basePsr(5) = [];
baseDopp(5) = [];
svPos = user{1}.pos;
svVel = user{1}.vel;
svClockCorr = user{1}.clkCorr;
band = 1;

est4 = rcvr.ddp3D(userPsr(1:4), basePsr(1:4), svPos, basePos);
est4.PDOP = sqrt( est4.DOP(1,1)^2 + est4.DOP(2,2)^2 + est4.DOP(3,3)^2 )

est8 = rcvr.ddp3D(userPsr, basePsr, svPos, basePos);;
est8.PDOP = sqrt( est8.DOP(1,1)^2 + est8.DOP(2,2)^2 + est8.DOP(3,3)^2 )