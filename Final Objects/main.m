clc
close all
clear all

o(1) = Obstacle(18, 5, 12);
o(2) = Obstacle(50, 0, 17, 8, -45);
o(3) = Obstacle(75, -25, 15);
o(4) = Obstacle(30, -18, 13, 8, -45);
o(5) = Obstacle(90, 0, 20, 13, -45);
o(6) = Obstacle(35, 30, 10, 10, -30);
o(7) = Obstacle(65, 30, 15, 20, -30);
% assert(0);

cnt = 0;

% Task 3
tic
for i = 1 : 3
    for j = 1 : 2
        cnt = cnt + 1;
        fprintf('Situation #%d...\n', cnt);
        res{cnt} = misocp(0, 0, 80 - 40 * i, 110, 0, -80 + 40 * i, [], ...
            Method=['algo' num2str(j)], IterRes='on', Solver='Mosek');
    end
end
for i = 1 : 2
    for j = 1 : 2
        cnt = cnt + 1;
        fprintf('Situation #%d...\n', cnt);
        res{cnt} = misocp(0, 0, 0, 90, 60 - 40 * i, -120 + 80 * i, [], ...
            Method=['algo' num2str(j)], IterRes='on', Solver='Mosek');
    end
end
toc
plotit(res, OmegaLegend='on');


% Task 4
% plotobstacles(o);
% tic
% cnt = 0;
% for i = 1 : 3
%     for j = 1 : 2
%         cnt = cnt + 1;
%         fprintf('Situation #%d...\n', cnt);
%         res4{cnt} = misocp(0, 0, 80 - 40 * i, 110, 0, -80 + 40 * i, o, ...
%             Method=['algo' num2str(j)], IterRes='on', Solver='Mosek');
%     end
% end
% toc

% plotit(res4, ThetaLegend='on');