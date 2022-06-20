 
clear
clc

%-------------------------------------------------------------------------%
%--------------- Provide All Physical Data for Problem -------------------%
%-------------------------------------------------------------------------%
Vm=300;
gammaf=-30*pi/180;
t0=0;
tf=40;

r0=((Vm*tf*cos(gammaf)-10000)^2+(Vm*tf*sin(-gammaf))^2)^0.5;
lamda0=pi-asin(Vm*tf*sin(-gammaf)/r0);
gamma0=0;
x0=0;
y0=0;

%-------------------------------------------------------------------------%
%---------- Provide Bounds and Guess in Each Phase of Problem ------------%
%-------------------------------------------------------------------------%
iphase = 1;
bounds.phase(iphase).initialtime.lower = [t0]; 
bounds.phase(iphase).initialtime.upper = [t0]; 
bounds.phase(iphase).finaltime.lower = [5]; 
bounds.phase(iphase).finaltime.upper = [tf]; 
bounds.phase(iphase).initialstate.lower = [r0 lamda0 gamma0 x0 y0];    
bounds.phase(iphase).initialstate.upper = [r0 lamda0 gamma0 x0 y0];    
bounds.phase(iphase).state.lower = [0 -pi -pi 0      0  ];
bounds.phase(iphase).state.upper = [r0 pi  pi 10000   10000 ];
bounds.phase(iphase).finalstate.lower = [0 0 gammaf 0    0 ]; 
bounds.phase(iphase).finalstate.upper = [0 pi gammaf 10000 10000]; 
bounds.phase(iphase).control.lower = [-200];
bounds.phase(iphase).control.upper = [200];
% bounds.phase(iphase).path.lower  = [0];
% bounds.phase(iphase).path.upper  = [1.25*100000];
bounds.phase.integral.lower = 0;
bounds.phase.integral.upper = 10^6;
guess.phase(iphase).time = [t0; 20];

guess.phase(iphase).state(:,1) = [r0; 0];
guess.phase(iphase).state(:,2) = [lamda0; 0];
guess.phase(iphase).state(:,3) = [gamma0; gammaf];
guess.phase(iphase).state(:,4) = [0; 7000];
guess.phase(iphase).state(:,5) = [0; 2000];

guess.phase(iphase).control(:,1) = [50;-50];

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

