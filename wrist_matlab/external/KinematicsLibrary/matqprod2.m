function F = matqprod2(g)

% calcola la matrice F(g) che serve ad effettuare il prodotto tra quaternioni
% h*g = F(g)*h
%
% B Bona, DAUIN, POLITO

F=[g(1) -g(2) -g(3) -g(4) ; ...
   g(2)  g(1)  g(4) -g(3) ; ...
   g(3) -g(4)  g(1)  g(2) ; ...
   g(4)  g(3) -g(2)  g(1) ];
