function x = prorodri(ra,rb)

% Uso: x = prorodri(ra,rb)
% esegue il prodotto x fra due vettori di Rodrigues ra rb (in colonna)
% per la composizione di due rotazioni
%
% B Bona, DAUIN, POLITO

rv = cross(rb,ra);

x = (ra + rb - rv)/(1 - ra'*rb);
