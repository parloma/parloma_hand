function T = prpy2tom(p)

% Uso:  T = prpy2tom(p)
%
% Calcola la matrice di trasformazione omogenea T
% a partire dal vettore di coordinate omogenee p (6x1)
% con gli angoli espressi come angoli di RPY in gradi
%
% B Bona, DAUIN, POLITO

	d(1) = p(1);
	d(2) = p(2);
	d(3) = p(3);
	
	R = rpy2rot([p(4) p(5) p(6)]);
	
	T = rd2tom(R,d);
