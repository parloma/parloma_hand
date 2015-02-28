function R = rod2rot(r)

% Uso: R = rod2rot(r)
%
% costruisce la matrice di rotazione R
% a partire dal vettore di Rodrigues r
%
% B Bona, DAUIN, POLITO

s(1)=r(1);
s(2)=r(2);
s(3)=r(3);
s(4)=   1;

R(1,1)=s(1)^2-s(2)^2-s(3)^2+s(4)^2;
R(1,2)=2*(s(1)*s(2)-s(3)*s(4));
R(1,3)=2*(s(1)*s(3)+s(2)*s(4));

R(2,1)=2*(s(1)*s(2)+s(3)*s(4));
R(2,2)=-s(1)^2+s(2)^2-s(3)^2+s(4)^2;
R(2,3)=2*(s(2)*s(3)-s(1)*s(4));

R(3,1)=2*(s(1)*s(3)-s(2)*s(4));
R(3,2)=2*(s(2)*s(3)+s(1)*s(4));
R(3,3)=-s(1)^2-s(2)^2+s(3)^2+s(4)^2;

R=1/(1+r(1)^2+r(2)^2+r(3)^2) * R;
