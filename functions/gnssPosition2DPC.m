function est = gnssPosition2DPC(rho, svPos, estPos, sigma)
% DESCRIPTION: This function produces a global position estimate using 
% least squares error estimation & the Newton-Raphson provided satellite
% positions and pseudoranges while also assuming 
% a perfect receiver clock (PC). The number of least squares iterations
% used is also provided.
% PARAMS:
%       rho: column vector of pseudoranges
%       svPos: nxm matrix of satellite(s) positions
% OUTPUT:
%       estPos: estimated position solution
%       P: estimated covaraince of our position error (dPos) estimate
%       itr: number of iterations taken to converge
% AUTHOR: Tanner Koza, M.E. (Master of Engineering) Candidate

%% Initialization
    
    % Handle Input Dimensions
    numMeas = length(rho);
    sz_rho = size(rho);
    sz_svPos = size(svPos);

    if sz_rho(1) ~= numMeas

        rho = rho';

    elseif sz_svPos(2) ~= numMeas

        svPos = svPos';

    end


    % Initialize Position & Clock Bias Estimate
%     estPos = [0; 0; 0]; % center of earth (ECEF)
    estX = estPos;

    % Initialize Iteration Count
    itr = 0;

    % Calculate Measurement Variance
    var = sigma^2;
    conv_th = 0.001;

%% Estimation

    % Least Squares & Newton-Raphson
    while true

        y = gnssMeasVector2DPC(rho, svPos, estPos);

        G = gnssGeomMatrix2DPC(svPos, estPos);

        dX = (G' * G)^-1 * G' * y;

        estX = estX + dX;

         estPos = estX;
       
        itr = itr + 1;

        if  norm(dX) <= conv_th
            break
        end

    end  

    % Predicted Error Estimate Covariance Matrix
    P = var * ( G' * G )^-1;
    DOP = ( G' * G )^-1;

    est.pos = estPos;
    est.P = P;
    est.DOP = DOP;
    est.itr = itr;

end

