function r = rot2rod(R)

% Uso: r = rot2rod(R)
%
% costruisce il vettore di Rodrigues r a partire dalla matrice di rotazione R
%
% B Bona, DAUIN, POLITO

if isrot(R) == 0

% passo alla rappresentazione asse u + angolo teta

	[u,teta]=rot2uth(R);

% passo alla rappresentazione parametri di Eulero s + quaternione h

	if abs(teta-180) < eps
		disp('Rodrigues vector is undefined: teta = 180')
		r=NaN
	else
		s=Eulero(u,teta);
		r=[s(1) s(2) s(3)]/s(4);
		r=r';
	end
else
    	disp('Error in input matrix')
    	r='ERROR'
end
