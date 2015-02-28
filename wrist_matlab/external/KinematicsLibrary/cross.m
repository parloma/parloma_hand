function c = cross(v,x)

% Uso: c = cross(v,x)
%
% fornisce il prodotto vettoriale di due vettori colonna (3x1) v e x
% usa la matrice antisimmetrica S
% l'uscita e` un vettore colonna c
%
% B Bona, DAUIN, POLITO

v=v(:); x=x(:);
S=antisim(v);
c=S*x;
