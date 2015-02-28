function x = rotzSYM(c)

% Uso:  R = rotz(c)
%
% Costruisce la matrice R di rotazione elementare 
% intorno all'asse z di un angolo c espresso simbolico
%
% B Bona, DAUIN, POLITO

x = eye(3);

x = sym(x);

x(2,2) = cos(c);
x(1,1) = x(2,2);
x(2,1) = sin(c);
x(1,2) = -x(2,1);