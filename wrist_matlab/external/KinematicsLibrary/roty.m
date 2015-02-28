function x = roty(b)

% Uso:  R = roty(b)
%
% Costruisce la matrice R di rotazione elementare 
% intorno all'asse y di un angolo b espresso in gradi
%
% B Bona, DAUIN, POLITO
 
x = eye(3);

x(1,1) = cosd(b);
x(3,3) = x(1,1);
x(1,3) = sind(b);
x(3,1) = -x(1,3);

