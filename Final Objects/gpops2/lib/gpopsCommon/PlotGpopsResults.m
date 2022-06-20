%%
%  使用伪谱法求解最优控制问题的结果画图
%%
%-----------------------------------------------------------|
% function PlotGpopsResults(output)
%-----------------------------------------------------------|
%
% INPUT:
% solutionPlot
%
% OUTPUT:
%
% ABSTRACT:
%  建立3种不同的图形来查看最优控制问题的结果
%
% DESCRIPTION:
% Creates the following plots
%   1.) all states vs. time
%   2.) all costates vs. time
%   3.) all controls vs. time
%   4.) first three states in a 3D plot
%   5.) sparse pattern
% REFERENCES:
%
% COPYRIGHT 2011 
%
% 
%---------------------------------------------------------------------%
%% ------- Final Modified  2013-03-21 ----  wuxuzhong  ----------------%
function PlotGpopsResults(output)
%% VARIABLE REASSIGNMENT                                2011-12-07 Xuzhong Wu
%  reassigns the variables for better readability
cpt = 'bgrcmyk';                                       %cpt ----- color pre set
[~,nop] = size(output.result.solution.phase);          %nop ----- number of phase

for inp = 1:nop
    time{inp}    = output.result.solution.phase(inp).time;
    timeC{inp}   = output.result.solution.phase(inp).time;
    % t0      = output.solution.time(1);
    % tf      = output.solution.time(end);
    state{inp}   = output.result.solution.phase(inp).state;
    costate{inp} = output.result.solution.phase(inp).costate;
    control{inp} = output.result.solution.phase(inp).control;
    % sparsity_all=output.sparsity_all;
end

[~,nt]     = size(time{1});                              %nt ----- nomber of time
[~,nx]  = size(state{1});                                %nx ----- nomber of state
[~,nu]   = size(control{1});                             %nu ----- nomber of control

%% STANDARD PLOT OPTIONS                                2011-12-07 Xuzhong Wu
% SetStandardPlotOptions;


%% STATES AND COSTATES VS. TIME                         2013-03-21 Xuzhong Wu
for idx = 1:nx
    
    figure('Name',['State(', num2str(idx), ') and Costate(', num2str(idx), ') vs. time'], 'NumberTitle','off');
    
    subplot(2,1,1)                                  % plot states
    title(['State(',num2str(idx),')']);
    for j = 1:nop 
        hold on
        plot(time{j},state{j}(:,idx),'-ob','color',cpt(j));
    end
    xlabel('t [s]');
    
    subplot(2,1,2)                                  % plot costates
    title(['Costate(',num2str(idx),')']);
    hold on
    for j = 1:nop    
        plot(time{j},costate{j}(:,idx),'-ob','color',cpt(j));
    end
    xlabel('t [s]');
    
end



% %% STATES VS. TIME                                      2011-12-07 Xuzhong Wu
% %  plots the states vs. time
% figure('Name','States vs. time', 'NumberTitle','off');
% for idx = 1:1:nx;
%     subplot(nx,1,idx);
%     plot(time,state(:,idx),'-ob');
% end
% xlabel('t [s]');
% 
% %% COSTATES VS. TIME                                    2011-12-09 Xuzhong Wu
% %  plots the costates vs. time
% figure('Name','Costates vs. time', 'NumberTitle','off');
% for idx = 1:1:nx;
%     subplot(nx,1,idx);
%     plot(time,costate(:,idx),'-ob');
% end
% xlabel('t [s]');

%% CONTROL VS. TIME                                     2011-12-07 Xuzhong Wu
%  plots the control vs. time
figure('Name','Control vs. time', 'NumberTitle','off');
for idx = 1:1:nu;
    subplot(nu,1,idx);
    for j = 1:nop
        hold on
        plot(timeC{j},control{j}(:,idx),'xb','color',cpt(j));
        plot(time{j},control{j}(:,idx),'color',cpt(j));
    end
end
xlabel('t [s]');


% %% TRAJECTORY                                           2011-12-07 Xuzhong Wu
% %  plots the first three states in a 3D plot as the first three states 
% % normally are the position
% if nx>=3
%     figure('Name','Trajectory', 'NumberTitle','off'); 
%     hold on;
%     plot3(state(:,1), state(:,2), state(:,3));
%     title('Trajectory'); xlabel(1);
%     ylabel(2); zlabel(3);
% end
% 

% %% sparsity_all                                         2011-12-09 Xuzhong Wu
% % plot sparse pattern
% figure
% spy(sparsity_all);

end

%---EOF---
