function x = proseu(sa,sb)

% Uso: x = proseu(sa,sb)
%
% esegue il "prodotto" fra due vettori sa sb 
% di parametri di Eulero (in colonna) per determinare la rotazione composta
%
% B Bona, DAUIN, POLITO

F(1,1) =  sa(4);
F(1,2) = -sa(3);
F(1,3) =  sa(2);
F(1,4) =  sa(1);

F(2,1) =  sa(3);
F(2,2) =  sa(4);
F(2,3) = -sa(1);
F(2,4) =  sa(2);

F(3,1) = -sa(2);
F(3,2) =  sa(1);
F(3,3) =  sa(4);
F(3,4) =  sa(3);

F(4,1) = -sa(1);
F(4,2) = -sa(2);
F(4,3) = -sa(3);
F(4,4) =  sa(4);

x = F * sb;
