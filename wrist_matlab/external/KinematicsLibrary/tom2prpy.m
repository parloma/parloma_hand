function p = tom2prpy(T)

% Uso:  p = tom2prpy(T)
%
% Calcola il vettore di coordinate omogenee p (6x1)
% con gli angoli espressi come angoli di RPY in gradi
% a partire dalla matrice di trasformazione omogenea T
%
% B Bona, DAUIN, POLITO

[R,d] = tom2rd(T);
	
p(1) = d(1);
p(2) = d(2);
p(3) = d(3);
	
alfa = rot2rpy(R);

p(4) = alfa(1);
p(5) = alfa(2);
p(6) = alfa(3);

p=p(:);
	
	
	
