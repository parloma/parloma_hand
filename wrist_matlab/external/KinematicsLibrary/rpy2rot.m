function R = rpy2rot(x)

% Uso:  R = rpy2rot(x)
%
% Calcola la matrice di rotazione R a partire dagli angoli di Roll, Pitch, Yaw
% x(1) = teta_x = Roll, 
% x(2) = teta_y = Pitch
% x(3) = teta_z = Yaw
% gli angoli sono espressi in gradi
%
% B Bona, DAUIN, POLITO

cx = cosd(x(1));
cy = cosd(x(2));
cz = cosd(x(3));

sx = sind(x(1));
sy = sind(x(2));
sz = sind(x(3));

R(1,1) =  cz*cy;     
R(1,2) =  cz*sy*sx-sz*cx;
R(1,3) =  cz*sy*cx+sz*sx;

R(2,1) =  sz*cy;
R(2,2) =  sz*sy*sx+cz*cx;
R(2,3) =  sz*sy*cx-cz*sx;

R(3,1) =  -sy;
R(3,2) =  cy*sx;
R(3,3) =  cy*cx;

