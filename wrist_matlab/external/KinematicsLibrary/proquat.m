function hg = proquat(h,g)

% Uso: hg = proquat(h,g)
% esegue il prodotto hg fra due quaternioni h e g, 
% definiti in riga come h=[hr, hv'] con hv vettore colonna (3x1)
%                       g=[gr, gv'] con gv vettore colonna (3x1)
%
% B Bona, DAUIN, POLITO

hr=h(1);
hv=[h(2) h(3) h(4)]';

gr=g(1);
gv=[g(2) g(3) g(4)]';

hgr=hr*gr - hv'*gv;
hgcr=cross(hv,gv);
hgv=hr*gv + gr*hv + hgcr;
hg=[hgr hgv'];
