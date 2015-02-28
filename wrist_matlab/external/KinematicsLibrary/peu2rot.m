function R = peu2rot(s)

% Uso:  R = Ppeu2rot(s)
%
% costruisce la matrice di rotazione R
% a partire dal vettore s dei parametri di Eulero 
%
% B Bona, DAUIN, POLITO

R(1,1)=s(1)^2-s(2)^2-s(3)^2+s(4)^2;
R(1,2)=2*(s(1)*s(2)-s(3)*s(4));
R(1,3)=2*(s(1)*s(3)+s(2)*s(4));

R(2,1)=2*(s(1)*s(2)+s(3)*s(4));
R(2,2)=-s(1)^2+s(2)^2-s(3)^2+s(4)^2;
R(2,3)=2*(s(2)*s(3)-s(1)*s(4));

R(3,1)=2*(s(1)*s(3)-s(2)*s(4));
R(3,2)=2*(s(2)*s(3)+s(1)*s(4));
R(3,3)=-s(1)^2-s(2)^2+s(3)^2+s(4)^2;
