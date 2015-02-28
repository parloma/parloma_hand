function x = rotz(c)

% Uso:  R = rotz(c)
%
% Costruisce la matrice R di rotazione elementare 
% intorno all'asse z di un angolo c espresso in gradi
%
% B Bona, DAUIN, POLITO

x = eye(3);

x(2,2) = cosd(c);
x(1,1) = x(2,2);
x(2,1) = sind(c);
x(1,2) = -x(2,1);
