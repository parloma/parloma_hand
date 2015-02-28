function R = uth2rot(u,teta)

% Uso: R = uth2rot(u,teta)
%
% calcola la matrice R 
% a partire da asse u ed angolo di rotazione teta (in gradi)
%
% B Bona, DAUIN, POLITO

S=antisim(u);
t=grad2rad(teta);
 
n=norm(u);

R = eye(3) + sin(t)/n*S + (1-cos(t))/n^2*S^2;

