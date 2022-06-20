%-------------------------------------------------------------------------%
%------------------- BEGIN Function launchContinuous.m -------------------%
%-------------------------------------------------------------------------%
function phaseout = launchContinuous(input)

%---------------------%
% Dynamics in Phase 1 %
%---------------------%
% t1 = input.phase(1).time;
% x1 = input.phase(1).state;
% u1 = input.phase(1).control;
% r1 = x1(:,1:3);
% v1 = x1(:,4:6);
% m1 = x1(:,7);
% 
% rad1 = sqrt(sum(r1.*r1,2));
% omegaMatrix = input.auxdata.omegaMatrix;
% omegacrossr = r1*omegaMatrix.';
% vrel1 = v1-omegacrossr;
% speedrel1 = sqrt(sum(vrel1.*vrel1,2));
% h1 = rad1-input.auxdata.Re;
% rho1 = input.auxdata.rho0*exp(-h1/input.auxdata.H);
% bc1  = (rho1./(2*m1)).*input.auxdata.sa*input.auxdata.cd;
% bcspeed1 = bc1.*speedrel1;
% bcspeedmat1 = repmat(bcspeed1,1,3);
% Drag1 = -bcspeedmat1.*vrel1;
% muoverradcubed1 = input.auxdata.mu./rad1.^3;
% muoverradcubedmat1 = [muoverradcubed1 muoverradcubed1 muoverradcubed1];
% grav1 = -muoverradcubedmat1.*r1;
% 
% TSrb1   = 6*input.auxdata.thrustSrb*ones(size(t1));
% TFirst1 = input.auxdata.thrustFirst*ones(size(t1));
% TTot1   = TSrb1+TFirst1;
% m1dot1  = -TSrb1./(input.auxdata.g0*input.auxdata.ispSrb);
% m2dot1  = -TFirst1./(input.auxdata.g0*input.auxdata.ispFirst);
% mdot1   = m1dot1+m2dot1;
% 
% path1 = [sum(u1.*u1,2)];
% Toverm1 = TTot1./m1;
% Tovermmat1 = [Toverm1 Toverm1 Toverm1];
% thrust1 = Tovermmat1.*u1;
% rdot1 = v1;
% vdot1 = thrust1+Drag1+grav1;
% phaseout(1).dynamics = [rdot1 vdot1 mdot1];
% phaseout(1).path = path1;
v1    =input.phase.state(:,1);
theta1=input.phase.state(:,2);
X1    =input.phase.state(:,3);
Y1    =input.phase.state(:,4);
m1    =input.phase.state(:,5);
P1    =input.phase.control(:,1);
alpha1=input.phase.control(:,2);

auxdata.Isp        = 282.9;
auxdata.g          = 9.8;
auxdata.S          = 5;
auxdata.H          = 23800*0.3028;
auxdata.rho0       = 0.002378*14.5939029/0.3028^3;
Isp = auxdata.Isp   ;    
g  =auxdata.g  ;        
S = input.auxdata.S;
S=250;
H = input.auxdata.H;
rho0=auxdata.rho0;
rho = rho0*exp(-Y1./H);
dynamic_pressure = 0.5*rho.*v1.^2;

CD=0.2;%chazhi_x(alpha1.*180/pi,v1./320.7);
CL=0.3;%chazhi_cl(alpha1.*180/pi,v1./320.7);
D = dynamic_pressure.*S.*CD;
L = dynamic_pressure.*S.*CL;

sin1=sin(theta1);
cos1=cos(theta1);

cosa1=cos(alpha1);
sina1=sin(alpha1);
path1=dynamic_pressure;
% path2=(-P1.*sina1+L)/(g.*cos1);
vdot1=-(P1.*cosa1+D)./m1-g.*sin1;
thetadot1=(-P1.*sina1+L)./(m1.*v1)-g.*cos1./v1;
Xdot1=v1.*cos1;
Ydot1=v1.*sin1;
mdot1=-P1./(g.*Isp);

phaseout.dynamics = [vdot1 thetadot1 Xdot1 Ydot1 mdot1];
phaseout.path=[path1];
phaseout.integrand = -mdot1;



%-------------------------------------------------------------------------%
%--------------------- END Function launchContinuous.m -------------------%
%-------------------------------------------------------------------------%
