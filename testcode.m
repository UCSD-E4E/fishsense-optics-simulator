
%Examples of functions
%--------Example Parameters 

%Parallel planes perpendicular to optical axis
ex_rotation1=[0*pi/180,0*pi/180]; %air/glass
ex_rotation2=[0*pi/180,0*pi/180]; %glass/water

%Non parallel planes not perpendicular to optical axis. Rotation defined as
%[rotation about y, rotation about x]
ex_rotation3=[-.1*pi/180,.1*pi/180]; %air/glass
ex_rotation4=[.3*pi/180,-.1*pi/180]; %glass/water

%[air thickness, glass thickness, distance from glass to a point in the
%water] Measured along the optical axis, its intersection with the center of each refractive plane
ex_thickness=[2,12.7,1000];

%[air,glass,water]
ex_indices=[1,1.52,1.33];

%For viewing graphs
ex_lim=30;

%Angle from optical axis outwards
ex_alpha_param=[0*pi/180,10*pi/180,60*pi/180];

%Angle about the optical axis 
ex_phi_param=[0*pi/2,2*pi/6,4*pi/2];

%Label options
ex_color='n';
ex_label='n';

%Laser angle options (work in progress)
laser_alpha=[((28+1.8)*pi/180),(0.02*pi/180),(29.2*pi/180)];
laser_phi=[(-106.5*pi/180),-0.01*pi/180,(-106.6*pi/180)];

%Laser direction and origin
laserdir=[0.01199697; 0.04052028 ; 0.99910662];
laserorigin=[-0.03083158; -0.09916128;  0]*1000;

%---Uncomment any of the below examples to see their graph/results

%Example of graphing rays with parallel refractive planes perpendicular to the optical axis
%GraphRays3(ex_rotation1,ex_rotation2,ex_thickness,ex_indices,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);


%Example of graphing rays with refractive planes not perpendicular to the optical axis nor parallel 
%GraphRays3(ex_rotation3,ex_rotation4,ex_thickness,ex_indices,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);


%Example of plotting the closest points of backtraced rays (red rays in the above example) from optical axis 
%Note: black dot represents the origin. Angles for each point's corresponding ray are labeled [Alpha, Phi]
%test_displayresults=GraphRays3(ex_rotation3,ex_rotation4,ex_thickness,ex_indices,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
%DisplayResults(test_displayresults)


%Plotting corresponding unrefracted and refracted vectors from origin to laser intersection
%FindLaserDepthError(ex_rotation1,ex_rotation2,ex_thickness,ex_indices,laserorigin,laserdir)





