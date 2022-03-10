function  G = gnssGeomMatrix2DPC(svPos, estPos)
% DESCRIPTION: This function produces the geometry/observation matrix 
% used in the least squares estimation of global position using
% satellite pseudoranges. This geometry matrix assumes a perfect receiver
% clock (PC).
% PARAMS:
%       svPos: nxm matrix of satellite(s) positions
%       estPos: column vector of current estimated user position
% OUTPUT:
%       G: GNSS geometry matrix
% AUTHOR: Tanner Koza, M.E. (Master of Engineering) Candidate


%% Initialization

    % Preallocate Satellite Unit Vectors 
    numMeas = length(svPos);

    uhat_x = zeros(numMeas,1);
    uhat_y = zeros(numMeas,1);

%% Geometry Matrix Population

     % Calculate Satellite Unit Vectors
    for i = 1:numMeas

        r = sqrt( ( svPos(1,i) - estPos(1) )^2 ...
            + ( svPos(2,i) - estPos(2) )^2 );

        uhat_x(i) = ( svPos(1,i) - estPos(1) )/ r;

        uhat_y(i) = ( svPos(2,i) - estPos(2) )/ r;

    end

    G = [-uhat_x -uhat_y];

end