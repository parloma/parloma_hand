function hx = proquatvet(h,x)

% Uso: hx = proquatvet(h,x)
% esegue il prodotto hx fra un quaternione h e un vettore x, 
%  h=[hr, hv'] in riga, con hv vettore colonna (3x1) 
%  x vettore colonna (3x1)
%
% B Bona, DAUIN, POLITO

h_con=quatcon(h); % calcolo del coniugato di h
hx=[0 x'];
h1=proquat(h,hx);
hx=proquat(h1,h_con);
