function x = rot2quatCS (R)

% Uso:  Angles = rot2quatCS(R)
%
% Calcola il quaternione corrispondente a partire dalla matrice di rotazione R
% secondo la formula data nell'articolo Siciliano Chiaverini(SC)
%
% B Bona, DAUIN, POLITO

if isrot(R) == 0
    
    s(4) = .5 * sqrt( 1 + R(1,1) + R(2,2) + R(3,3) );
    s(1) = 0.5*sign(R(3,2) - R(2,3))*sqrt(+R(1,1) - R(2,2) - R(3,3) + 1);
    s(2) = 0.5*sign(R(1,3) - R(3,1))*sqrt(-R(1,1) + R(2,2) - R(3,3) + 1);
    s(3) = 0.5*sign(R(2,1) - R(1,2))*sqrt(-R(1,1) - R(2,2) + R(3,3) + 1);

    x(1) = s(4);
    x(2) = s(1);
    x(3) = s(2);
    x(4) = s(3);
else
    disp ('Error in input matrix')
	x='ERROR';
end
