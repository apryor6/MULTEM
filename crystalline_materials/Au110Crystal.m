function [Crys3D, lx, ly, lz, a, b, c, dz] = Au110Crystal(na, nb, nc, ncu, rms3d)
CrysPar.na = na;
CrysPar.nb = nb;
CrysPar.nc = nc;
a = 4.0780/sqrt(2); 
b = 4.0780; 
c = 4.0780/sqrt(2);
CrysPar.a = a;
CrysPar.b = b;
CrysPar.c = c;
CrysPar.nuLayer = 2;
occ = 1;
region = 0;
charge = 0;
% Au = 79
% Z charge x y z rms3d occupancy region charge
CrysPar.uLayer(1).atoms = [79, 0.00, 0.00, 0.00, rms3d, 1.0];
CrysPar.uLayer(2).atoms = [79, 0.50, 0.50, 0.50, rms3d, 1.0];
Crys3D = il_crystal_by_lays(CrysPar);

dz = CrysPar.c/ncu;
lx = na*CrysPar.a; ly = nb*CrysPar.b; lz = nc*CrysPar.c;