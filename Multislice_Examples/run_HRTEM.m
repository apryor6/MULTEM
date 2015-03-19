clear all; clc;

global TEM;
DefaultValues;% Load default values;

TEM.gpu = 0;                % Gpu card
TEM.SimType = 32;           % 11: STEM, 12: ISTEM, 21: CBED, 22: CBEI, 31: ED, 32: HRTEM, 41: PED, 42: HCI, ... 51: EW Fourier, 52: EW real
TEM.nConfFP = 0;           % Number of frozen phonon configurations
TEM.DimFP = 110;            % Dimensions phonon configurations
TEM.SeedFP = 1983;          % Frozen phonon random seed
TEM.PotPar = 6;             % Parameterization of the potential 1: Doyle(0-4), 2: Peng(0-4), 3: peng(0-12), 4: Kirkland(0-12), 5:Weickenmeier(0-12) adn 6: Lobato(0-12)
TEM.MEffect = 1;            % 1: Exit wave Partial coherente mode, 2: Transmission cross coefficient
TEM.STEffect = 2;           % 1: Spatial and temporal, 2: Temporal, 3: Spatial
TEM.ZeroDefTyp = 3;         % 1: First atom, 2: middle point, 3: last atom, 4: Fix Plane
TEM.ZeroDefPlane = 0;       % Zero defocus plane
TEM.ApproxModel = 2;        % 1: MS, 2: PA, 3:POA, 4:WPOA
TEM.BWL = 1;                % 1: true, 2: false
TEM.FastCal = 1;            % 1: normal mode(low memory consumption), 2: fast calculation(high memory consumption)
TEM.ThkTyp = 1;             % 1: Whole specimen, 2: Throught thickness, 3: Through planes
TEM.Thk = (0:1:8)*4;        % Array of thicknesses
TEM.Psi0Typ = 1;            % 1: Automatic, 2: User define
TEM.Psi0 = 0;               % Input wave
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TEM.E0 = 200;
TEM.theta = 0.0; TEM.phi = 0; % Till ilumination (degrees)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TEM.MC.m = 0;       % mm
TEM.MC.Cs3 = 1.0;	% mm
TEM.MC.Cs5 = 0.00;	% mm
TEM.MC.mfa2 = 0.0; TEM.MC.afa2 = 0.0; %(Angs, degrees)
TEM.MC.mfa3 = 0.0; TEM.MC.afa3 = 0.0; %(Angs, degrees)
TEM.MC.aobjl = 0.0; TEM.MC.aobju = 1000000; %(mrad, mrad)
TEM.MC.sf = 88; TEM.MC.nsf = 1024; % (Angs, number of steps)ne
TEM.MC.beta = 0.0; TEM.MC.nbeta = 10; %(mrad, half number of steps)
TEM.MC.f = +100;  % Angs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TEM.nx = 1024; TEM.ny = 1024; nxh = TEM.nx/2; nyh = TEM.ny/2;
na = 7; nb = 5; nc = 2; ncu = 4; sigma = 0.076;
[TEM.Atoms, TEM.lx, TEM.ly, lz, a, b, c, TEM.dz] = Si110Crystal(na, nb, nc, ncu, sigma);
TEM.Psi0 = complex(ones(TEM.ny, TEM.nx));             % Input wave
figure(1);
TEM.MEffect = 1;            % 1: Exit wave Partial coherente mode, 2: Transmission cross coefficient
TEM.STEffect = 1;           % 1: Spatial and temporal, 2: Temporal, 3: Spatial
tic;
clear MULTEMMat;
[aPsi, M2aPsi, aM2Psi0] = MULTEM_GPU(TEM);
toc;
subplot(2, 2, 1);
imagesc(abs(aPsi).^2);
colormap gray;
axis image;
subplot(2, 2, 2);
imagesc(aM2Psi0);
colormap gray;
axis image;

TEM.MEffect = 1;            % 1: Exit wave Partial coherente mode, 2: Transmission cross coefficient
TEM.STEffect = 2;           % 1: Spatial and temporal, 2: Temporal, 3: Spatial
tic;
clear MULTEMMat;
[aPsi, M2aPsi, aM2Psi] = MULTEMMat(TEM);
toc;
subplot(2, 2, 3);
imagesc(abs(aPsi).^2);
colormap gray;
axis image;
subplot(2, 2, 4);
imagesc(aM2Psi);
colormap gray;
axis image;
sum(abs(aM2Psi(:)-aM2Psi0(:)))