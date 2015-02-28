function uvu = quatvecrot2(u,v)

% Uso: uvu = quatvecrot2(u,v)
%
% esegue la rotazione del vettore v (in forma quaternionica) 
% usando il quaternione unitario u (in forma quaternionica)
% facendo il prodotto tra i quaternioni u^* v u 
% il risultato è in forma quaternionica
%
% B Bona, DAUIN, POLITO

ucon=quatcon(u);
a=proquat(v,u);
b=proquat(ucon,a);

uvur=b(1);
uvuv=[b(2) b(3) b(4)]';

uvu =[uvur uvuv'];
