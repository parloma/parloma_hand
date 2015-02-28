function x = rot2rpy2 (R)

% Uso:  x = rot2rpy2(R)
%
% Calcola gli angoli di roll, pitch, yaw a partire dalla matrice di
% rotazione R, con R=Rx*Ry*Rz (quella alternativa)
% x(1) = teta_x, x(2) = teta_y, x(3) = teta_z
% gli angoli vanno espressi in gradi
%
% B Bona, DAUIN, POLITO

if isrot(R) == 0

   x(3) = atan2(-R(1,2),R(1,1));
   cz = cos(x(3));
   sz = sin(x(3));
   
   sx = R(3,1)*sz+R(3,2)*cz;
   cx = R(2,1)*sz+R(2,2)*cz;
   x(1) = atan2(sx,cx);
   
   x(2) = atan2( R(1,3), -sx*R(2,3)+cx*R(3,3) );
   x = rad2grad(x);

else

   disp ('Error in input matrix')
   x='ERROR';

end
