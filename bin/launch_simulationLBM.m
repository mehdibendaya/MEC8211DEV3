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

seed=0;
deltaP= 0.1 ; % pressure drop in Pa
N= 100 ;
mean_fiber_d= 12.5 ; % in microns
std_d= 2.85 ; % in microns
dx_ini= 2e-6 ; % grid size in m
filename= 'fiber_mat.tiff' ;
D=N*dx_ini;
NX=200;
dx=D/NX;
perm=[];
nbiter=100;
for i=1:nbiter
poro= normrnd(0.9,7.5e-3) ;
% generation of the fiber structure
[d_equivalent]=Generate_sample(seed,filename,mean_fiber_d,std_d,poro,NX,dx);
% calculation of the flow field and the permeability from Darcy Law
perm=LBM(filename,NX,deltaP,dx,d_equivalent);
save('Monte_Carlo.txt','perm','-ascii','-append')
end
