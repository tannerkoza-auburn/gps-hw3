%% Fundamentals of GPS - HW 3 - Problem 8 

clear
clc

codeL = 1023;

CA4 = genCA(4, codeL);
CA7 = genCA(7, codeL);

idx4 = find(CA4 == 0);
idx7 = find(CA7 == 0);

CA4(idx4) = -1;
CA7(idx7) = -1;

CA4 = reshape(repmat(CA4',10*1540,1),1,[]);
CA7 = reshape(repmat(CA7',10*1540,1),1,[]);

fL1 = 1575.42e6; % L1 frequency (Hz)

fs = fL1*10;

dt = 1/fs;

t = dt:dt:0.001;

L1car = sin((fL1*2*pi).*t);

L1sig4 = L1car .* CA4;

L1sig7 = L1car .* CA7;

% TODO: PLOT & ADJUST XLIM 