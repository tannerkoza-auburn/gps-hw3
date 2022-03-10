function y = gnssMeasVector2D(rho, svPos, estPos, estClockBias)
% DESCRIPTION: This function produces the measurement vector used in the
% least squares estimation of global position using satellite pseudoranges.
% This function assumes a perfect receiver clock (PC).
% PARAMS:
%       rho: column vector of pseudoranges
%       svPos: nxm matrix of satellite(s) positions
%       estPos: column vector of current estimated user position
%       estClockBias: scalar clock bias (m)
% OUTPUT:
%       y: GNSS measurement vector
% NOTES: 
%   - estClockBias is range bias that stems from the user's clock
%   bias. ( Ti - Tu ) is the clock offset between the user's and
%   satellite's clocks.
% AUTHOR: Tanner Koza, M.E. (Master of Engineering) Candidate

%% Initialization

    % Preallocate Estimated Pseudorange Vector 
    numMeas = length(rho);
    rhohat = zeros(numMeas,1);

%% Measurement Vector Population

    % Calculate Estimated Pseudorange
    for i = 1:numMeas

        rhohat(i) = sqrt( ( svPos(1,i) - estPos(1) )^2 ...
            + ( svPos(2,i) - estPos(2) )^2 ) + estClockBias;

    end

    y = rho - rhohat;

end