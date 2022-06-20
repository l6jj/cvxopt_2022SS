function phaseout=UAVContinue(input)

state=input.phase.state;
col=input.phase.control;
para=input.auxdata;

x=state(:,1);
y=state(:,2);
theta=state(:,3);

utheta=col(:,1);

V=para.V;
x_ob(1)=20;
y_ob(1)=5;
a_ob(1)=10;
b_ob(1)=10;
x_ob(2)=50;
y_ob(2)=-5;
a_ob(2)=15;
b_ob(2)=10;
x_ob(3)=80;
y_ob(3)=5;
a_ob(3)=10;
b_ob(3)=10;

r(:,1)=(x-x_ob(1)).^2/a_ob(1)^2+(y-y_ob(1)).^2/b_ob(1)^2;
r(:,2)=(x-x_ob(2)).^2/a_ob(2)^2+(y-y_ob(2)).^2/b_ob(2)^2;
r(:,3)=(x-x_ob(3)).^2/a_ob(3)^2+(y-y_ob(3)).^2/b_ob(3)^2;


dx=V.*cos(theta);
dy=V.*sin(theta);
dtheta=utheta;

phaseout.dynamics = [dx,dy,dtheta];
phaseout.path=r;