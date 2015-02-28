function R = uth2rotCS(u,teta)

% Uso: R = uth2rotCS(u,teta)
%
% calcola la matrice R 
% a partire da asse u ed angolo di rotazione teta (in gradi)
% usando la formula data da Chiaverini e Siciliano
%
% B Bona, DAUIN, POLITO

n=norm(u);
r=u/n;
S=antisim(r);

R = eye(3)*cosd(teta) + (1-cosd(teta))*r*r' - sind(teta)*S;