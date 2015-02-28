function x = rot2rpy (R)

% Uso:  x = rot2rpy(R)
%
% Calcola gli angoli di roll, pitch, yaw a partire dalla matrice di
% rotazione R, con R=Rz*Ry*Rx (quella convenzionale)
% x(1) = teta_x, x(2) = teta_y, x(3) = teta_z
% gli angoli vanno espressi in gradi
%
% B Bona, DAUIN, POLITO

if isrot(R) == 0

   x(1) = atan2(R(3,2),R(3,3));
   cx = cos(x(1));
   sx = sin(x(1));
   x(3) = atan2( -cx*R(1,2)+sx*R(1,3), cx*R(2,2)-sx*R(2,3) );
   x(2) = atan2( -R(3,1), sx*R(3,2)+cx*R(3,3) );
   x = rad2grad(x);

else

   disp ('Error in input matrix')
   x='ERROR';

end
