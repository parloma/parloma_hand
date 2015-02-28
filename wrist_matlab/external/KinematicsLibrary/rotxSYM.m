function x = rotxSYM(a)

% Uso:  R = rotx(a)
%
% Costruisce la matrice R di rotazione elementare
% intorno all'asse x di un angolo a espresso in gradi
%
% B Bona, DAUIN, POLITO
 
x = eye(3);

x = sym(x);

x(2,2) = cos(a);
x(3,3) = x(2,2);
x(3,2) = sin(a);
x(2,3) = -x(3,2);