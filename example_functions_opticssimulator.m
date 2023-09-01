% All Tests. To run each test, load testingparameters.mat variables into
% your workspace.

%{
%AlphaError Test
%--------------------------------------------------------
%AlphaError(test_variables,desired_alpha,desired_phirange)
%Output: Graph

xyerror_tests={test0;test2;test4;test6};  
AlphaError(xyerror_tests,30,[0,90])
%}

%{
%AlphaDepth Test
%--------------------------------------------------------
%AlphaDepthTest(depthtestaverages)
%Output: Graph &  Matrix: [alphadegrees,mean(z coords),std(z coords)], where
%#rows corresponds to # of alphas being evaluated

depthtest_averages={avg0;avg1;avg2;avg3;avg4;avg5;avg6;avg7};
AlphaDepthTest(depthtest_averages)
%}

%{
%AverageFocal
%-------------------------------------------------------
%AverageFocal(foc_information,alphaparam,phiparam)
%Output: Matrix: [alpha, x coordinate, y coordinate, z coordinate]

AverageFocal(test1,ex_alpha_param,ex_phi_param);
%}

%{
%DisplayResults
%-------------------------------------------------------
%DisplayResults(focalinfo)
%Output: Graph

DisplayResults(test9)
%}

%{
%FindIntersection
%-------------------------------------------------------
%FindIntersection(rmatrix1,rmatrix2,v_air,d_air,d_glass,d_water,mu_air,mu_glass,mu_water,origin)
%Output: Matrix: [v_water';glass_intersect';water_intersect';fish_intersect';optical_intersect'];

Helper function in GraphRays
%}

%%{ 
%GraphRays
%--------------------------------------------
%GraphRays3 (rotation1,rotation2,thickness,indices,lim,alpha_param,phi_param,focal_length,pixel_pitch,color,label)
%Output: Graph and Matrix: cell matrix, each cell for each ray, contains: [alpha,phi,[virtual camera coordinates],[xy error],x pixel #,y pixel #,magnitude pixel # from center of sensor];

GraphRays3([0.0,0.0],[0,0],[2,11.56,1000],[1,1.495,1.33496],15,[0,20*pi/180,60*pi/180],[pi/2,pi,3*pi/2],4.5,0.0015,'n','n');
%}


%{
%LaserDepthErrorPaper
%--------------------------------------------
%LaserDepthErrorPaper(layer_normal,layer_thickness,layer_indices,waterdepth_param,laserorigin,laserdir)
%Output: Graph

laser_o7=[-0.03142921;-0.02906525;0]*1000;
laser_d7=[0.02814415;0.01302515;0.99951866];
layerthick1=[2,11.56];

LaserDepthErrorPaper(paralplane,layerthick1,indices_largest,[60;60;60],laser_o7,laser_d7)
%}

%{
%LaserDepthError
%------------------------------------------------
%LaserDepthError(layer_normal,layer_thickness,layer_indices,waterdepth_param,laserorigin,laserdir)
%Output: Graph & Matrix: depth_error=[depth,depth error,percent depth
%error,alpha of air ray,phi of air ray]

laser_o7=[-0.03142921;-0.02906525;0]*1000;
laser_d7=[0.02814415;0.01302515;0.99951866];
layerthick1=[2,11.56];

LaserDepthError(paralplane,layerthick1,indices_largest,[500;1000;4500],laser_o7,laser_d7)
%}

%{
%TestAlpha
%--------------------------------------------------
%TestAlpha(avg_variables,desired_alpha)
%Output: Graph & Matrix: averagesmatrix=[virtual cam x, virtual cam y,
%virtual cam z, test #] -> each row is a different test

depthtest_averages={avg0;avg1;avg2;avg3;avg4;avg5;avg6;avg7};
TestAlpha(depthtest_averages,30)
%}

%{
%XYError
%--------------------------------------------------
%XYError(test_variables,desired_alpharange,desired_phirange)
%Output: Graph 

xyerror_tests={test0;test2;test4};
XYError(xyerror_tests,[0,60],[0,30])

%}