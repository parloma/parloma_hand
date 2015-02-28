function T = peul2tom(p)

% Uso:  T = peul2tom(p)
%
% Calcola la matrice di trasformazione omogenea T
% a partire dal vettore di coordinate omogenee p (6x1)
% con gli angoli espressi come angoli di Eulero in gradi
%
% B Bona, DAUIN, POLITO


	d(1) = p(1);
	d(2) = p(2);
	d(3) = p(3);
	
	R = eul2rot([p(4) p(5) p(6)]);
	
	T = rd2tom(R,d);
