 
clear all; clc

%-------------------------------------------------------------------------%
%--------------- Provide All Physical Data for Problem -------------------%
%-------------------------------------------------------------------------%
Vm=300;
gammaf=-30*pi/180;
t0=0;
tf=40;
gammaM0=0;
gamma0=gammaM0-gammaf;

x0=Vm*tf*cos(gammaf)-1000*10;
y0=Vm*tf*sin(gammaf);

%-------------------------------------------------------------------------%
%---------- Provide Bounds and Guess in Each Phase of Problem ------------%
%-------------------------------------------------------------------------%
iphase = 1;
bounds.phase(iphase).initialtime.lower = [t0]; 
bounds.phase(iphase).initialtime.upper = [t0]; 
bounds.phase(iphase).finaltime.lower = [5]; 
bounds.phase(iphase).finaltime.upper = [tf]; 
bounds.phase(iphase).initialstate.lower = [x0 y0 gamma0];    
bounds.phase(iphase).initialstate.upper = [x0 y0 gamma0];    
bounds.phase(iphase).state.lower = [-x0 y0 -pi/2];
bounds.phase(iphase).state.upper = [x0  0   2*pi];
bounds.phase(iphase).finalstate.lower = [0 0 0]; 
bounds.phase(iphase).finalstate.upper = [0 0 0]; 
bounds.phase(iphase).control.lower = [-100];
bounds.phase(iphase).control.upper = [100];
% bounds.phase(iphase).path.lower  = [0];
% bounds.phase(iphase).path.upper  = [1.25*100000];
bounds.phase.integral.lower = 0;
bounds.phase.integral.upper = 10^7;
guess.phase(iphase).time = [t0; tf];
guess.phase(iphase).state(:,1) = [x0; 0];
guess.phase(iphase).state(:,2) = [y0; 0];
guess.phase(iphase).state(:,3) = [gamma0; 0];
guess.phase(iphase).control(:,1) = [100;0];
guess.phase.integral = 0;
% iphase = 1;
% bounds.phase(iphase).initialtime.lower = [t0]; 
% bounds.phase(iphase).initialtime.upper = [t0]; 
% bounds.phase(iphase).finaltime.lower = [t1min]; 
% bounds.phase(iphase).finaltime.upper = [t1max]; 
% bounds.phase(iphase).initialstate.lower = [v0 theta0 X0 Y0 m0];    
% bounds.phase(iphase).initialstate.upper = [v0 theta0 X0 Y0 m0];    
% bounds.phase(iphase).state.lower = [vmin thetamin Xmin Ymin mf];
% bounds.phase(iphase).state.upper = [vmax thetamax Xmax Ymax m0];
% bounds.phase(iphase).finalstate.lower = [vmin thetamin Xmin Ymin m1fmin]; 
% bounds.phase(iphase).finalstate.upper = [vmax thetamax Xmax Ymax m1fmax]; 
% bounds.phase(iphase).control.lower = [0 alphamin];
% bounds.phase(iphase).control.upper = [0 alphamax];
% % bounds.phase(iphase).path.lower  = 1;
% % bounds.phase(iphase).path.upper  = 1;
% guess.phase(iphase).time = [t0; t1max];
% guess.phase(iphase).state(:,1) = [v0; v0];
% guess.phase(iphase).state(:,2) = [theta0; theta0];
% guess.phase(iphase).state(:,3) = [X0; X0];
% guess.phase(iphase).state(:,4) = [Y0; Y0];
% guess.phase(iphase).state(:,5) = [m0; m0];
% guess.phase(iphase).control(:,1) = [0; 0];
% guess.phase(iphase).control(:,2) = [0; 0];
% 
% 
% iphase = 2;
% bounds.phase(iphase).initialtime.lower = [t1min]; 
% bounds.phase(iphase).initialtime.upper = [t1max]; 
% bounds.phase(iphase).finaltime.lower = [tfmin]; 
% bounds.phase(iphase).finaltime.upper = [tfmax]; 
% bounds.phase(iphase).initialstate.lower = [vmin thetamin Xmin Ymin mf];
% bounds.phase(iphase).initialstate.upper = [vmax thetamax Xmax Ymax m0];
% bounds.phase(iphase).state.lower = [vmin thetamin Xmin Ymin mf];
% bounds.phase(iphase).state.upper = [vmax thetamax Xmax Ymax m0];
% bounds.phase(iphase).finalstate.lower = [vf thetaf Xf Yf mf]; 
% bounds.phase(iphase).finalstate.upper = [vf thetaf Xf Yf m0]; 
% bounds.phase(iphase).control.lower = [Pconst alphamin];
% bounds.phase(iphase).control.upper = [Pconst alphamax];
% % bounds.phase(iphase).path.lower  = 1;
% % bounds.phase(iphase).path.upper  = 1;
% guess.phase(iphase).time = [t1min; tfmax];
% guess.phase(iphase).state(:,1) = [v0; v0];
% guess.phase(iphase).state(:,2) = [theta0; theta0];
% guess.phase(iphase).state(:,3) = [X0; X0];
% guess.phase(iphase).state(:,4) = [Y0; Y0];
% guess.phase(iphase).state(:,5) = [m0; m0];
% guess.phase(iphase).control(:,1) = [Pconst;Pconst];
% guess.phase(iphase).control(:,2) = [0; 0];
% 
% %-------------------------------------------------------------------------%
% %------------- Set up Event Constraints That Link Phases -----------------%
% %-------------------------------------------------------------------------%
% bounds.eventgroup(1).lower = [zeros(1,5),  0];
% bounds.eventgroup(1).upper = [zeros(1,5),   0];
% %-------------------------------------------------------------------------%
% %----------- Set up Event Constraints That Define Final Orbit ------------%
% %-------------------------------------------------------------------------%
% bounds.eventgroup(2).lower = [vf, thetaf, Xf, Yf, mf];
% bounds.eventgroup(2).upper = [vf, thetaf, Xf, Yf, m0];
% 
% %-------------------------------------------------------------------------%
% %-------------- Provide an Initial Mesh in Each Phase --------------------%
% %-------------------------------------------------------------------------%
% for i=1:2
%   meshphase(i).colpoints = 4*ones(1,10);
%   meshphase(i).fraction = 0.1*ones(1,10);
% end
 meshphase.colpoints = 4*ones(1,10);
 meshphase.fraction = 0.1*ones(1,10);
%-------------------------------------------------------------------------%
%----------- Assemble All Information into Setup Structure ---------------%
%-------------------------------------------------------------------------%
setup.name = 'Problem';
setup.functions.continuous = @launchContinuous;
setup.functions.endpoint = @launchEndpoint;
setup.mesh.phase = meshphase;
setup.nlp.solver = 'snopt';
setup.bounds = bounds;
setup.guess = guess;
% setup.auxdata = auxdata;
setup.derivatives.supplier = 'sparseFD';
setup.derivatives.derivativelevel = 'second';
setup.derivatives.dependencies = 'sparseNaN';
setup.scales.method = 'automatic-bounds';
setup.mesh.method = 'hp1';
setup.mesh.tolerance = 1e-1;
% setup.method = 'RPMintegration';

%-------------------------------------------------------------------------%
%---------------------- Solve Problem using GPOPS2 -----------------------%
%-------------------------------------------------------------------------%
totaltime = tic;
output = gpops2(setup);
totaltime = toc(totaltime);

