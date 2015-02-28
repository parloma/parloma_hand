function R = randrot

% Uso:  R = randrot
%
% Calcola una matrice di rotazione random
%
% B Bona, DAUIN, POLITO

a=-1;b=1;
u=a + (b-a).*rand(3,1);
unorm=norm(u);
un=u/unorm
teta=a + (b-a).*rand(1,1)*180

R=uth2rot(u,teta);
