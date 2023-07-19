%Example graphs utilizing the GraphRays2 function

% GraphRays2(normal,dist,indices,lim,alpha_param,phi_param,label)

%Alpha: 20 deg , Phi: 180 deg (slice along the Z axis, X=0)
GraphRays2([0;0;1],[2,12.7,200],[1.492,1.345],40,[0*pi/180,20*pi/180,pi/3],[pi/2,pi,3*pi/2],'n')
GraphRays2([0;0;1],[2,12.7,200],[1.492,1.345],40,[0*pi/180,20*pi/180,pi/3],[pi/2,pi,3*pi/2],'y')

%Alpha: 20 deg , Phi: 20 deg
%GraphRays2([0;0;1],[2,12.7,200],[1.492,1.345],40,[0*pi/180,20*pi/180,pi/3],[0,pi*20/180,2*pi],'n')
