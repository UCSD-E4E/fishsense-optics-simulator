
%Test file for LaserDepthError, XYError, AlphaDepthTest, and TestAlpha

%The variables used for this code are found in the testing parameters file. Upload
%this .mat file to your workspace to avoid having to run very time-consuming
%code. 

%Each "test" takes in rotation, index of refraction (IOR), and depth
%parameters, and uses GraphRays to get the virtual camera coordinates and XY error for
%each ray (for each phi and alpha)

%Each "avg" variable takes in a test, and uses the AverageFocal function to
%find the virtual camera coordinates for very alpha, averaging out xyz
%positions over every phi

%Available test functions------------------------------------

%XYError(test_variables,desired_alpharange,desired_phirange)

%TestAlpha(avg_variables,desired_alpha)

%LaserDepthError(layer_normal,layer_thickness,layer_indices,waterdepth_param,laserorigin,laserdir)

%----------------------------------------------------
%{
ALPHA DEPTH TEST: 


1.Plotting how the virtual camera coordinates (specifically, the z
coordinate along the optical axis) changes according to different IOR,
rotations, and depths to which the lighrays are going to

Output Graph Information:
X: Alpha (deg)
Y: Z coordinate of virtual cam
%}

%no rotation, small IOR---------------
%depthtest_averages={avg0;avg2;avg4;avg6}; %very clumped together
%no rotation, large IOR---------------
%depthtest_averages={avg1;avg3;avg5;avg7}; %very clumped together
%no rotation, both IOR---------------------------
%depthtest_averages={avg0;avg1;avg2;avg3;avg4;avg5;avg6;avg7}; %about a 0.15- 0.30 difference (difference gets bigger as alpha increases, no diff at 0 deg), between the small and large IOR.


%1/10 rotation, small IOR -----------------
%depthtest_averages={avg16;avg18;avg20;avg22}
%1/10 rotation, large IOR----------------
%depthtest_averages={avg17;avg19;avg21;avg23}
%1/10th, both IOR------------------------
%depthtest_averages={avg16;avg17;avg18;avg19;avg20;avg21;avg22;avg23}; %about a 0.3 difference between IOR 

%1/10th rotation(both parallel and in opposite directions), along with 0
%rotation, small IOR----------------
%depthtest_averages={avg0;avg2;avg4;avg6;avg16;avg16_1;avg18;avg18_1;avg20;avg20_1;avg22;avg22_1};

%1/10th rotation(both parallel and in opposite directions), along with 0
%rotation, large IOR----------------
%depthtest_averages={avg1;avg3;avg5;avg7;avg17;avg17_1;avg19;avg19_1;avg21;avg21_1;avg23;avg23_1};

%1/10th rotation (both parallel and in opposite directions), both IOR------
%depthtest_averages={avg16;avg16_1;avg17;avg17_1;avg18;avg18_1;avg19;avg19_1;avg20;avg20_1;avg21;avg21_1;avg22;avg22_1;avg23;avg23_1}; %OK rotation rlly doesnt have too much of an impact, rlly its the ior. Even with changes in rotation the zcoordinate is very much abt thes same

%0 and 1/10 rotations and all IOR and depths 
%depthtest_averages={avg0;avg1;avg2;avg3;avg4;avg5;avg6;avg7;avg16;avg16_1;avg17;avg17_1;avg18;avg18_1;avg19;avg19_1;avg20;avg20_1;avg21;avg21_1;avg22;avg22_1;avg23;avg23_1}; %OK rotation rlly doesnt have too much of an impact, rlly its the ior. Even with changes in rotation the zcoordinate is very much abt thes same


%AlphaDepthTest(depthtest_averages)

%----------------------------------------
%{
XY ERROR TEST

1. Plotting how the magnitude of the XY error (at a flat plane at a known depth) changes based on alpha,
depths, IOR, and rotation. 

Output Graph Information:
X: Alpha
Y: Magnitude of error (I assume here that error is the same along all phis.
This is proven true using the commented out section of the XYError
function. However, might not hold for nonparallel planes.Either way, difference 
is assumed to be negligible between phis. Further testing needed to confirm this)

%}

%no rotation, small IOR---------------
%xyerror_tests={test0;test2;test4;test6};  

%no rotation, large IOR---------------
%xyerror_tests={test1;test3;test5;test7}; 

%no rotation, both IOR---------------------------
%xyerror_tests={test0;test1;test2;test3;test4;test5;test6;test7};

%about a 0.15- 0.30 difference (difference gets bigger as alpha increases,
%no diff at 0 deg), between the small and large IOR. Small IOR had smaller
%error. Still not as significant as depth or alpha error changes

%1/10 rotation, small IOR--------------
%xyerror_tests={test16;test18;test20;test22}

%1/10 rotation, large IOR--------------
%xyerror_tests={test17;test19;test21;test23};

%1/10th, both IOR----------
%xyerror_tests={test16;test17;test18;test19;test20;test21;test22;test23};


%Constant depths, different rotations, same IOR (small)

%.5 meters -----------------
%xyerror_tests={test0;test8;test8_1;test16;test16_1}; 
%magnitude increases nonlinearly up to abt 450 mm at 60 deg.
% difference <1 mm for each rotation. Increased rotation=increased error.
% test 3 better than 2 and 5 better than 4. so parallel planes mean less xy
% error. still though, error difference from test0 to test16 less than 3 mm

%2 meters----------------
%xyerror_tests={test4;test12;test12_1;test20;test20_1}; 
%Up to 1776 mm diff at 60 deg, and ~ 6 mm between first and last test at 60 degrees, 
% 2 mm between rotations at 10 degrees. 
%The parallel rotated planes have less error, magnitude of like 2 mm or so
% better than their opposite rotation counterparts. however, to have less 
%rotation is still overall better. 

%5 meters-----------
%xyerror_tests={test6;test14;test14_1;test22;test22_1};
%error of about up to 4.4175e+03 mm 

%.5 meters, no rotation----------
%xyerror_tests={test0;test1}
%error up to 450 mm, error between tests about 8 mm

%Same IOR, No rotation, varying depths----------
%xyerror_tests={test0;test2;test4}
%Demonstrates the nonlinear increase in error as alpha and depth increases.
%Up to 900 mm for test 2, 450 for test 0. Interestingly, for each depth that
%is two times the previous one, the error also about half.
% ex (@ 60 deg): 1771 mm; 891.4; 451.6

%2000 meters, no rotation---------------
%xyerror_tests={test4;test5}

%2000 meters, 1/10th rotation both parallel and nonparallel-------------
%xyerror_tests={test20;test20_1;test21;test21_1}
%about 2 mm diff between 20 and 20_1; bigger seperation between 20_1 and
%21, abt up to 30 mm at 60deg. So IOR seems to impact it more than parallel vs
%non parallel. 

%diff IOR and diff rotation, constant depths

%.5 meters-----------
%xyerror_tests={test0;test1;test8;test8_1;test9;test9_1;test16;test16_1;test17;test17_1}; 
%two clumps: test1,test9_1,test9,test17_1,test17 (LARGE IOR) which has a
%greater error tham the other clump.
%IOR has a greater impact than rotation. About a 6/7mm difference
%between clumps, up to abt 8 at 60 deg

%2 meters-------------
%xyerror_tests={test4;test5;test12;test12_1;test13;test13_1;test20;test20_1;test21;test21_1;}; 
%Difference in IOR clumps at 60 deg goes up to over 30 mm. 

%Test for paper 
xyerror_tests={test4};  

XYError(xyerror_tests,[0,60],[0,30])

%------------------------------------------------------

%{
LASER DEPTH ERROR TEST 

1. Given a laser orientation/direction, plot the actual position of laser
on fish at given depths, and compare to the unrefracted estimated position
of the laser.


Output Graph Information:
Each color of ray corresponds to the unrefracted/estimated and
refracted/actual ray for a given depth. Points marked "REF" represent the
actual location of the laser on a fish at a given depth.

Output matrix information:
Each row is a different depth (in mm) and is formatted as: [depth(mm),
estimated-actual depth, percent depth error].

Note that percent depth error is the same as percent length error due to
proportionality. 
%}

indices_small=[1;1.495;1.33496];
indices_largest=[1;1.495;1.34995]; 

%Uncomment a line to see the graph and corresponding error data. 

%Pool laser----
 % laser_err1=LaserDepthError(paralplane,layerthick1,indices_small,wat_dp,pool_lo,pool_ld);
% laser_err2=LaserDepthError(paralplane,layerthick1,indices_largest,wat_dp,pool_lo,pool_ld);

% laser_err3=LaserDepthError(paralplane,layerthick2,indices_small,wat_dp,pool_lo,pool_ld);
% laser_err4=LaserDepthError(paralplane,layerthick2,indices_largest,wat_dp,pool_lo,pool_ld);

% %Dive laser----
% laser_err5=LaserDepthError(paralplane,layerthick1,indices_small,wat_dp,dive_lo,dive_ld);
% laser_err6=LaserDepthError(paralplane,layerthick1,indices_largest,wat_dp,dive_lo,dive_ld);

% laser_err7=LaserDepthError(paralplane,layerthick2,indices_small,wat_dp,dive_lo,dive_ld);
% laser_err8=LaserDepthError(paralplane,layerthick2,indices_largest,wat_dp,dive_lo,dive_ld);

%Testing with laser directions from cameras 2-7 ( pool test)

laser_origin2=[-0.03090316;-0.0995172;0]*1000;
laser_dir2=[0.03036567;0.03888114;0.99878215];

laser_origin3=[-0.02938965; -0.09794052;0]*1000;
laser_dir3=[-0.00760419;0.01835205; 0.9998026 ];

laser_origin4=[-0.03088575; -0.09819288;0]*1000;
laser_dir4=[0.01611468; 0.02188467; 0.99963054];

laser_origin5=[-0.02968504;-0.09813952;0]*1000;
laser_dir5=[0.01520644;0.02237695;0.99963369];

laser_origin6=[-0.02991985;-0.09841192;0]*1000;
laser_dir6=[0.02536296;0.00915088;0.99963614];

laser_origin7=[-0.03142921;-0.09906525;0]*1000;
laser_dir7=[0.02814415;0.01302515;0.99951866];

pool_lo=[-0.02991158*1000;-0.09781963*1000;0];
pool_ld=[0.00877752; 0.04130509; 0.99910793];

%ANOTHER WAY TO PLOT LASER DEPTH ERROR: 

%Using largest IOR, layerthick1, plotting the varying %errors in length/depth for each camera.
% Uncomment to see test results


laser_error2=LaserDepthError(paralplane,layerthick1,indices_largest,wat_dp,laser_origin2,laser_dir2);
laser_error3=LaserDepthError(paralplane,layerthick1,indices_largest,wat_dp,laser_origin2,laser_dir2);
laser_error4=LaserDepthError(paralplane,layerthick1,indices_largest,wat_dp,laser_origin4,laser_dir4);
laser_error5=LaserDepthError(paralplane,layerthick1,indices_largest,wat_dp,laser_origin5,laser_dir5);
laser_error6=LaserDepthError(paralplane,layerthick1,indices_largest,wat_dp,laser_origin6,laser_dir6);
laser_error7=LaserDepthError(paralplane,layerthick1,indices_largest,wat_dp,laser_origin7,laser_dir7);
laser_err2=LaserDepthError(paralplane,layerthick1,indices_largest,wat_dp,pool_lo,pool_ld);
laser_err6=LaserDepthError(paralplane,layerthick1,indices_largest,wat_dp,dive_lo,dive_ld);

%laser_errtests=[laser_error2;laser_error3;laser_error4;laser_error5;laser_error6;laser_error7;laser_err2;laser_err6];

%Run plot_percenterr to see % error plotted by diff parameters



