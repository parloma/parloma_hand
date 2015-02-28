function F = matqprod1(h)

% calcola la matrice F(h) che serve ad effettuare il prodotto tra quaternioni
% h*g = F(h)*g
%
% B Bona, DAUIN, POLITO

F=[h(1) -h(2) -h(3) -h(4) ; ...
   h(2)  h(1) -h(4)  h(3) ; ...
   h(3)  h(4)  h(1) -h(2) ; ...
   h(4) -h(3)  h(2)  h(1) ];
