clc
clear all
% close all

%% 参数设置
% 辅助参数
auxdata.rad=pi/180;
auxdata.V=5;


% 初始状态
x_0=0;
y_0=0;
theta_0=00*auxdata.rad;
t_0=0;

% 终端状态
x_f=100;
y_f=0;
theta_f=00*auxdata.rad;

%% 初始化
% 上下限
t_fmin=0;                       t_fmax=50;
x_min=-500;                     x_max=500;
y_min=-500;                     y_max=500;
theta_min=-90*auxdata.rad;      theta_max=90*auxdata.rad;
dtheta_min=-20*auxdata.rad;     dtheta_max=20*auxdata.rad;

% 上下限设置
bounds.phase.initialtime.lower=t_0;
bounds.phase.initialtime.upper=t_0;
bounds.phase.finaltime.lower=t_fmin;
bounds.phase.finaltime.upper=t_fmax;
bounds.phase.initialstate.lower=[x_0,y_0,theta_0];
bounds.phase.initialstate.upper=[x_0,y_0,theta_0];
bounds.phase.state.lower=[x_min,y_min,theta_min];
bounds.phase.state.upper=[x_max,y_max,theta_max];
bounds.phase.finalstate.lower=[x_f,y_f,theta_f];
bounds.phase.finalstate.upper=[x_f,y_f,theta_f];
bounds.phase.control.lower=[dtheta_min];
bounds.phase.control.upper=[dtheta_max];
bounds.phase.path.lower=[1,1,1];
bounds.phase.path.upper=[1e6,1e6,1e6];


% 初始猜测
% 猜想1（初末连线）
tGuess=[0;23];
xGuess=[0;100];
yGuess=[0;0];
thetaGuess=[0;0];
dthetaGuess=[0;1];

% % 猜想2（绕下方障碍连线）
% tGuess=[0;10;23];
% xGuess=[0;50;100];
% yGuess=[0;-10;0];
% thetaGuess=[0;-45;0];
% dthetaGuess=[0;1;1];

guess.phase.state=[xGuess,yGuess,thetaGuess];
guess.phase.control=dthetaGuess;
guess.phase.time=tGuess;

N=10;
meshphase.colpoints=4*ones(1,N);
meshphase.fraction=0.1*ones(1,N);

setup.name='UAV';
setup.functions.continuous=@UAVContinue;
setup.functions.endpoint =@UAVEndpoint;
setup.auxdata=auxdata;
ssetup.mesh.phase=meshphase;
setup.bounds=bounds;
setup.guess=guess;
setup.nlp.solver='snopt';
setup.derivatives.supplier='sparseCD';
setup.derivatives.derivativelevel='second';
setup.scales.method='automatic-bounds';
% setup.method='RPMintegration';
setup.mesh.method='hp1';
setup.mesh.tolerance=1e-6;
setup.mesh.colpointsmin=4;
setup.mesh.colpointsmax=16;

output=gpops2(setup);

drawfigure