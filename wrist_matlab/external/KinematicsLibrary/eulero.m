function [s,h] = eulero(u,teta)

% Uso [s,h] = eulero(u,teta)
%
% calcola i parametri di Eulero s e il quaternione h
% a partire da asse u e angolo di rotazione teta espresso in gradi
%
% B Bona, DAUIN, POLITO

s=[u(1)*sind(teta/2) u(2)*sind(teta/2) u(3)*sind(teta/2) cosd(teta/2)]';

h(1)=s(4);
h(2)=s(1);
h(3)=s(2);
h(4)=s(3);

