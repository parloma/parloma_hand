function x = rot2eul (R)

% Uso:  x = rot2eul(R)
%
% Calcola gli angoli di eulero a partire dalla matrice di rotazione R
% x(1) = Phi, x(2) = Theta, x(3) = Psi
% gli angoli sono espressi in gradi
%
% B Bona, DAUIN, POLITO

if isrot(R) == 0

   x(1) = atan2(R(1,3),-R(2,3));
   cf   = cos(x(1));
   sf   = sin(x(1));
   x(2) = atan2(sf*R(1,3)-cf*R(2,3),R(3,3));
   x(3) = atan2(-cf*R(1,2)-sf*R(2,2),cf*R(1,1)+sf*R(2,1));
   x    = rad2grad(x);

else

   disp ('Error in input matrix')
   x='ERROR';

end