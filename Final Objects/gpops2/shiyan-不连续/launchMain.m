
clear all; clc

%-------------------------------------------------------------------------%
%--------------- Provide All Physical Data for Problem -------------------%
%-------------------------------------------------------------------------%

auxdata.Isp        = 282.9;
auxdata.g          = 9.8;
auxdata.S          = 5;
auxdata.H          = 7206.64;
auxdata.rho0       = 1.25;


v0               = 457.3;         
theta0           =0;
X0               =0;                   
Y0               =120*1000;
m0               =41700;

vf               =0;         
thetaf           =-pi/2;
Xf               =40*1000;                   
Yf               =0;
mf=10000;
vmin=0;vmax=2000;
thetamin=-pi;thetamax=pi;
Xmin=0;Xmax=40*1000;
Ymin=0;Ymax=120*1000;


alphamin=-20*pi/180;alphamax=20*pi/180;
t0=0;
t1=90;
% t1min=0;t1max=500;
 tfmin=0;tfmax=200;

Pconst=845.3*1000;
%-------------------------------------------------------------------------%
%---------- Provide Bounds and Guess in Each Phase of Problem ------------%
%-------------------------------------------------------------------------%
iphase = 1;
bounds.phase(iphase).initialtime.lower = [t0]; 
bounds.phase(iphase).initialtime.upper = [t0]; 
bounds.phase(iphase).finaltime.lower = [t1]; 
bounds.phase(iphase).finaltime.upper = [t1]; 
bounds.phase(iphase).initialstate.lower = [v0 theta0 X0 Y0 m0];    
bounds.phase(iphase).initialstate.upper = [v0 theta0 X0 Y0 m0];    
bounds.phase(iphase).state.lower = [vmin thetamin Xmin Ymin m0];
bounds.phase(iphase).state.upper = [vmax thetamax Xmax Ymax m0];
bounds.phase(iphase).finalstate.lower = [vmin thetamin Xmin Ymin m0]; 
bounds.phase(iphase).finalstate.upper = [vmax thetamax Xmax Ymax m0]; 
bounds.phase(iphase).control.lower = [0 alphamin];
bounds.phase(iphase).control.upper = [0 alphamax];
% bounds.phase(iphase).path.lower  = 1;
% bounds.phase(iphase).path.upper  = 1;
guess.phase(iphase).time = [t0;t1];
guess.phase(iphase).state(:,1) = [v0; v0];
guess.phase(iphase).state(:,2) = [theta0; theta0];
guess.phase(iphase).state(:,3) = [X0; X0];
guess.phase(iphase).state(:,4) = [Y0; Y0];
guess.phase(iphase).state(:,5) = [m0; m0];
guess.phase(iphase).control(:,1) = [0; 0];
guess.phase(iphase).control(:,2) = [0; 0];


iphase = 2;
bounds.phase(iphase).initialtime.lower = [t1]; 
bounds.phase(iphase).initialtime.upper = [t1]; 
bounds.phase(iphase).finaltime.lower = [tfmin]; 
bounds.phase(iphase).finaltime.upper = [tfmax]; 
bounds.phase(iphase).initialstate.lower = [vmin thetamin Xmin Ymin m0];
bounds.phase(iphase).initialstate.upper = [vmax thetamax Xmax Ymax m0];
bounds.phase(iphase).state.lower = [vmin thetamin Xmin Ymin mf];
bounds.phase(iphase).state.upper = [vmax thetamax Xmax Ymax m0];
bounds.phase(iphase).finalstate.lower = [vf thetaf Xf Yf mf]; 
bounds.phase(iphase).finalstate.upper = [vf thetaf Xf Yf m0]; 
bounds.phase(iphase).control.lower = [Pconst alphamin];
bounds.phase(iphase).control.upper = [Pconst alphamax];
% bounds.phase(iphase).path.lower  = 1;
% bounds.phase(iphase).path.upper  = 1;
guess.phase(iphase).time = [t1; tfmax];
guess.phase(iphase).state(:,1) = [v0; vf];
guess.phase(iphase).state(:,2) = [theta0; thetaf];
guess.phase(iphase).state(:,3) = [X0; Xf];
guess.phase(iphase).state(:,4) = [Y0; Yf];
guess.phase(iphase).state(:,5) = [m0; mf];
guess.phase(iphase).control(:,1) = [Pconst;Pconst];
guess.phase(iphase).control(:,2) = [0; 0];

%-------------------------------------------------------------------------%
%------------- Set up Event Constraints That Link Phases -----------------%
%-------------------------------------------------------------------------%
bounds.eventgroup(1).lower = [zeros(1,5),  0];
bounds.eventgroup(1).upper = [zeros(1,5),   0];
%-------------------------------------------------------------------------%
%----------- Set up Event Constraints That Define Final Orbit ------------%
%-------------------------------------------------------------------------%
% bounds.eventgroup(2).lower = [vf, thetaf, Xf, Yf, mf];
% bounds.eventgroup(2).upper = [vf, thetaf, Xf, Yf, m0];

%-------------------------------------------------------------------------%
%-------------- Provide an Initial Mesh in Each Phase --------------------%
%-------------------------------------------------------------------------%
for i=1:2
  meshphase(i).colpoints = 4*ones(1,10);
  meshphase(i).fraction = 0.1*ones(1,10);
end

%-------------------------------------------------------------------------%
%----------- Assemble All Information into Setup Structure ---------------%
%-------------------------------------------------------------------------%
setup.name = 'Launch-Vehicle-Ascent-Problem';
setup.functions.continuous = @launchContinuous;
setup.functions.endpoint = @launchEndpoint;
setup.mesh.phase = meshphase;
setup.nlp.solver = 'snopt';
setup.bounds = bounds;
setup.guess = guess;
setup.auxdata = auxdata;
setup.derivatives.supplier = 'sparseFD';
setup.derivatives.derivativelevel = 'second';
setup.derivatives.dependencies = 'sparseNaN';
setup.scales.method = 'automatic-bounds';
setup.mesh.method = 'hp1';
setup.mesh.tolerance = 1e-6;
setup.method = 'RPMintegration';

%-------------------------------------------------------------------------%
%---------------------- Solve Problem using GPOPS2 -----------------------%
%-------------------------------------------------------------------------%
totaltime = tic;
output = gpops2(setup);
totaltime = toc(totaltime);

