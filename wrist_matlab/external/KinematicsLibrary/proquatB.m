function [hg,F] = proquatB(h,g)

% alternativa B al prodotto di quaternioni
% Uso: hg = proquatB(h,g)
% esegue il prodotto hg fra due quaternioni h e g, 
% definiti in riga come h=[hr, hv'] con hv vettore colonna (3x1)
%                       g=[gr, gv'] con gv vettore colonna (3x1)
%
% B Bona, DAUIN, POLITO

F=qprodmat2(g);
hg=F*h(:);
