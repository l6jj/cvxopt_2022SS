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
r1     =input.phase.state(:,1);
lamda1 =input.phase.state(:,2);
gamma1 =input.phase.state(:,3);
x1     =input.phase.state(:,4);
y1     =input.phase.state(:,5);

u1     =input.phase.control;

Vm=300;
gammaf=-30*pi/180;
% % path1=dynamic_pressure;
c1=cos(gammaf-lamda1);
c2=cos(gamma1-lamda1);

s1=sin(gammaf-lamda1);
s2=sin(gamma1-lamda1);

rdot1=Vm.*c1-Vm.*c2;
lamdadot1=Vm.*(s1-s2)./r1;
gammadot1=u1./Vm;

cos1=cos(gamma1);
sin1=sin(gamma1);

xdot1=Vm.*cos1;
ydot1=Vm.*sin1;

k=1;
J=1+0.5*k.*u1.^2;
phaseout.dynamics = [rdot1 lamdadot1 gammadot1 xdot1 ydot1];
% phaseout.path=[path1];
  phaseout.integrand = J;



%-------------------------------------------------------------------------%
%--------------------- END Function launchContinuous.m -------------------%
%-------------------------------------------------------------------------%
