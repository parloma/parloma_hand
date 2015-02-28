function Tinv = tominv(T)

% Uso:  Tinv = tominv(T)
%
% Calcola l'inversa della matrice di trasformazione omogenea T
%
% B Bona, DAUIN, POLITO

[R,d] = tom2rd(T);
Tinv = rd2tom(R',-R'*d);
	
