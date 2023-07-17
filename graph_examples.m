%Example graphs utilizing GraphRays function

%FORMAT OF INPUT PARAMETERS
%dist=[d0,d1,d2]
%indices=[ng,nw]
%lim (any number for axis limits)
%alpha_param=[a_start,a_step,a_end]
%phi_param=[p_start,p_step,p_end]

%Alpha: 20 deg , Phi: 180 deg
GraphRays([2,12.7,200],[1.492,1.345],40,[0*pi/180,10*pi/180,pi/3],[pi/2,pi,3*pi/2],'y')
GraphRays([2,12.7,200],[1.492,1.345],40,[0*pi/180,20*pi/180,pi/3],[pi/2,pi,3*pi/2],'n')

%Alpha: 20 deg , Phi: 2 deg
%GraphRays([2,12.7,200],[1.492,1.345],40,[0*pi/180,2*pi/180,pi/3],[pi/2,pi,3*pi/2],'n')

%Alpha: 2 deg, Phi: 2 deg
%GraphRays([2,12.7,200],[1.492,1.345],40,[0*pi/180,10*pi/180,pi/3],[0,10*pi/180,2*pi],'n')