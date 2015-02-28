function T = denhart(d,teta,a,alfa)

% Uso:  T = denhart(d,teta,a,alfa)
%
% Costruisce la matrice omogenea T (4x4) associata alla
% trasformazione da un riferimento a quello contiguo
% secondo le convenzioni di Denavit-Hartenberg
% con parametri d, teta, a, alfa
% Nota: gli angoli alfa, teta sono in gradi, d e a sono in metri
%
% B Bona, DAUIN, POLITO

T = eye(4);

calfa = cosd(alfa);
salfa = sind(alfa);
cteta = cosd(teta);
steta = sind(teta);

T(1,1) = cteta;
T(1,2) = -calfa*steta;
T(1,3) = salfa*steta;
T(1,4) = a*cteta;

T(2,1) = steta;
T(2,2) = calfa*cteta;
T(2,3) = -salfa*cteta;
T(2,4) = a*steta;

T(3,2) = salfa;
T(3,3) = calfa;
T(3,4) = d;