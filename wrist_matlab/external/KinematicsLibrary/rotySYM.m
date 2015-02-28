function x = rotySYM(b)

% Uso:  R = roty(b)
%
% Costruisce la matrice R di rotazione elementare 
% intorno all'asse y di un angolo b espresso in gradi
%
% B Bona, DAUIN, POLITO
 
x = eye(3);

x = sym(x);

x(1,1) = cos(b);
x(3,3) = x(1,1);
x(1,3) = sin(b);
x(3,1) = -x(1,3);
