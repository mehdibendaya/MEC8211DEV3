% MATLAB script to launch a fiber structure generation and the corresponding LBM simulation
%
%INPUT VARIABLES:
%
% SEED: integer representing the seed for initializing the random
% generator. If seed=0, automatic seed generation. If you want to reproduce
% the same fiber structure, use the same seed (fibers will be located at the same place). 
%
% MEAN_D: contains the mean fiber to be used
%
% STD_D: contains the standard deviation of the fiber diameters
%
% PORO: estimated porosity of the fiber structure to be generated
% 
% NX: domain lateral size in grid cell

seed=101;
deltaP= 0.1 ; % pressure drop in Pa
NX= 100 ;
poro= 0.9 ;
mean_fiber_d= 12.5 ; % in microns
std_d= 2.85 ; % in microns
dx= 2e-6 ; % grid size in m
filename= 'fiber_mat.tiff' ;
D=NX*dx;
Npts=[600,300,150,75];
dx_liste=[D/600,D/300,D/150,D/75];
for i=1:length(Npts)
% generation of the fiber structure

    [d_equivalent]=Generate_sample(seed,filename,mean_fiber_d,std_d,poro,Npts(i),dx_liste(i));

% calculation of the flow field and the permeability from Darcy Law
    LBM(filename,Npts(i),deltaP,dx_liste(i),d_equivalent);
end
