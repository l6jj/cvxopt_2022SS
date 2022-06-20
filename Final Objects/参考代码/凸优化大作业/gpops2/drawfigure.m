solution = output.result.solution;
rad=pi/180;

time=solution.phase(1).time;
x=solution.phase(1).state(:,1);
y=solution.phase(1).state(:,2);
theta=solution.phase(1).state(:,3);

figure(1)
hold on
plot(x,y)
hold on

figure(2)
plot(time,theta*rad)