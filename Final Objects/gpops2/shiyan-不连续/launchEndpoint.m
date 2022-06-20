%-------------------------------------------------------------------------%
%--------------------- BEGIN Function launchEndpoint.m -------------------%
%-------------------------------------------------------------------------%
function output = launchEndpoint(input)

% Variables at Start and Terminus of Phase 1
t0{1} = input.phase(1).initialtime;
tf{1} = input.phase(1).finaltime;
x0{1} = input.phase(1).initialstate;
xf{1} = input.phase(1).finalstate;
% Variables at Start and Terminus of Phase 2
t0{2} = input.phase(2).initialtime;
tf{2} = input.phase(2).finaltime;
x0{2} = input.phase(2).initialstate;
xf{2} = input.phase(2).finalstate;


% Event Group 1:  Linkage Constraints Between Phases 1 and 2
output.eventgroup(1).event = [x0{2}-xf{1}, t0{2}-tf{1}];
% Event Group 2:  Constraints on Terminal Orbit
%  output.eventgroup(2).event = [0 0 0 0 0];
output.objective = -xf{2}(5);

%-------------------------------------------------------------------------%
%--------------------- END Function launchEndpoint.m ---------------------%
%-------------------------------------------------------------------------%
