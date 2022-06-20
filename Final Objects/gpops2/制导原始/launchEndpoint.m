%-------------------------------------------------------------------------%
%--------------------- BEGIN Function launchEndpoint.m -------------------%
%-------------------------------------------------------------------------%
function output = launchEndpoint(input)
  mubiao=input.phase.integral;
%     mubiao=input.phase.finaltime;
% P1    =input.phase.control(1);
% Isp = 282.9   ;    
% g  =9.8 ;   
% mdot1=-P1./(g.*Isp);
% q = input.phase.integral;
output.objective = mubiao;


%-------------------------------------------------------------------------%
%--------------------- END Function launchEndpoint.m ---------------------%
%-------------------------------------------------------------------------%
