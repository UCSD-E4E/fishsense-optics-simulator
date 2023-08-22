%Testing different parameters (combinations are in google sheet). Sets up variables in the workspace for
%plottingtestresults.m 

%DO NOT RUN-- instead, upload "testingparameters.mat" to your workspace.

%Rotation parameters

%Parallel Planes
r1_0=[0,0];
r2_0=[0,0]; 

%1/20th degree rotations
r1_1= [(pi/180)*1/20, (pi/180)*1/20]; 
r2_1=[(pi/180)*-1/20,(pi/180)*-1/20];

r1_12=[(pi/180)*1/20, (pi/180)*1/20]; 
r2_12=[(pi/180)*1/20,(pi/180)*1/20] ;

%1/10th degree rotations
r1_2= [(pi/180)*1/10, (pi/180)*1/10]; 
r2_2=[(pi/180)*-1/10,(pi/180)*-1/10];

r1_22=[(pi/180)*1/10, (pi/180)*1/10]; 
r2_22=[(pi/180)*1/10,(pi/180)*1/10];

%1/5th degree rotations
r1_3= [(pi/180)*1/5, (pi/180)*1/5]; 
r2_3=[(pi/180)*-1/5,(pi/180)*-1/5];

r1_32=[(pi/180)*1/5, (pi/180)*1/5]; 
r2_32=[(pi/180)*-1/5,(pi/180)*-1/5];

%thicknesses
dist1=[2,11.56,500];
dist2=[2,11.56,1000];
dist3=[2,11.56,2000];
dist4=[2,11.56,3000];
dist5=[2,11.56,4000];
dist6=[2,11.56,5000];

%indices (currently testing only smallest and largest values)
%s=33, T=18, L=400
indices1=[1,1.495,1.34976]; 
%s=33, T=18, L=700
indices2=[1,1.495,1.33628];
%s=33, T=30, L=400
indices3=[1,1.495,1.34837];
%s=33, T=18, L=700
indices_small=[1,1.495,1.33496]; %SMALLEST 

%s=34, T=18, L=400
indices_largest=[1,1.495,1.34995]; %LARGEST 
%s=34, T=18, L=700
indices6=[1,1.495,1.33646];
%s=34, T=30, L=400
indices7=[1,1.495,1.34856];
%s=34, T=18, L=700
indices8=[1,1.495,1.33514];


%For viewing graphs
ex_lim=30;

%Angle from optical axis outwards
ex_alpha_param=[0,10*pi/180,60*pi/180];

%Angle about the optical axis 
ex_phi_param=[0,10*pi/180,350*pi/180];

%Label options
ex_color='n';
ex_label='n';

%Water depth parameters
wat_dp=[500;500;5500];

%Normal of perfectly parallel glass planes
paralplane=[0;0;-1];

%example of variation in air/glass thickness
layerthick1=[2,11.56];
layerthick2=[1.5,12];

%Laser origins and directions
pool_lo=[-0.02991158*1000;-0.09781963*1000;0];
pool_ld=[0.00877752; 0.04130509; 0.99910793];

dive_lo=[-0.03163025*1000;-0.10136059*1000;0];
dive_ld=[0.01214438;0.02188269;0.99968678];

%{
%------------------------------------------------------------
%ROTATION 1

%Test 0
test0=GraphRays3(r1_0,r2_0,dist1,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg0=AverageFocal(test0,ex_alpha_param,ex_phi_param);
%writecell(test0,'optics_simulator_testing.xlsx','Sheet',1)
%DisplayResults(test0)

%Test 1 
test1=GraphRays3(r1_0,r2_0,dist1,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg1=AverageFocal(test1,ex_alpha_param,ex_phi_param);
%writecell(test1,'optics_simulator_testing.xlsx','Sheet',2)

%Test 2 
test2=GraphRays3(r1_0,r2_0,dist2,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg2=AverageFocal(test2,ex_alpha_param,ex_phi_param);
%writecell(test2,'optics_simulator_testing.xlsx','Sheet',3)
%DisplayResults(test2)

%Test 3
test3=GraphRays3(r1_0,r2_0,dist2,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg3=AverageFocal(test3,ex_alpha_param,ex_phi_param);
%writecell(test3,'optics_simulator_testing.xlsx','Sheet',4)
%DisplayResults(test3)

%Test 4
test4=GraphRays3(r1_0,r2_0,dist3,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg4=AverageFocal(test4,ex_alpha_param,ex_phi_param);

%Test 5
test5=GraphRays3(r1_0,r2_0,dist3,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg5=AverageFocal(test5,ex_alpha_param,ex_phi_param);

%Test 6
test6=GraphRays3(r1_0,r2_0,dist6,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
%writecell(test6,'optics_simulator_testing.xlsx','Sheet',5)
avg6=AverageFocal(test6,ex_alpha_param,ex_phi_param);

%Test 7
test7=GraphRays3(r1_0,r2_0,dist6,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg7=AverageFocal(test7,ex_alpha_param,ex_phi_param);
%DisplayResults(test7)
%writecell(test7,'optics_simulator_testing.xlsx','Sheet',6)



%{
%ROTATION 2----------------------------------------
%Test 8

test8=GraphRays3(r1_1,r2_1,dist1,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);

avg8=AverageFocal(test8,ex_alpha_param,ex_phi_param);
%DisplayResults(test8)
%writecell(test8,'optics_simulator_testing.xlsx','Sheet',7)

test8_1=GraphRays3(r1_12,r2_12,dist1,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);

avg8_1=AverageFocal(test8_1,ex_alpha_param,ex_phi_param);


%Test 9 
test9=GraphRays3(r1_1,r2_1,dist1,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg9=AverageFocal(test9,ex_alpha_param,ex_phi_param);

%DisplayResults(test9)
%writecell(test9,'optics_simulator_testing.xlsx','Sheet',8)

test9_1=GraphRays3(r1_12,r2_12,dist1,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg9_1=AverageFocal(test9_1,ex_alpha_param,ex_phi_param);

%Test 10
test10=GraphRays3(r1_1,r2_1,dist2,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg10=AverageFocal(test10,ex_alpha_param,ex_phi_param);
%DisplayResults(test10)
%writecell(test10,'optics_simulator_testing.xlsx','Sheet',9)

test10_1=GraphRays3(r1_12,r2_12,dist2,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg10_1=AverageFocal(test10_1,ex_alpha_param,ex_phi_param);

%Test 11
test11=GraphRays3(r1_1,r2_1,dist2,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg11=AverageFocal(test11,ex_alpha_param,ex_phi_param);
%DisplayResults(test11)
%writecell(test11,'optics_simulator_testing.xlsx','Sheet',10)

test11_1=GraphRays3(r1_12,r2_12,dist2,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg11_1=AverageFocal(test11_1,ex_alpha_param,ex_phi_param);


%Test 12
test12=GraphRays3(r1_1,r2_1,dist3,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg12=AverageFocal(test12,ex_alpha_param,ex_phi_param);

test12_1=GraphRays3(r1_12,r2_12,dist3,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg12_1=AverageFocal(test12_1,ex_alpha_param,ex_phi_param);

%Test 13
test13=GraphRays3(r1_1,r2_1,dist3,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg13=AverageFocal(test13,ex_alpha_param,ex_phi_param);

test13_1=GraphRays3(r1_12,r2_12,dist3,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg13_1=AverageFocal(test13_1,ex_alpha_param,ex_phi_param);



%Test 14
test14=GraphRays3(r1_1,r2_1,dist6,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
%DisplayResults(test14)
%writecell(test14,'optics_simulator_testing.xlsx','Sheet',11)
avg14=AverageFocal(test14,ex_alpha_param,ex_phi_param);

test14_1=GraphRays3(r1_12,r2_12,dist6,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg14_1=AverageFocal(test14_1,ex_alpha_param,ex_phi_param);

%Test 15
test15=GraphRays3(r1_1,r2_1,dist6,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
%DisplayResults(test15)
%writecell(test15,'optics_simulator_testing.xlsx','Sheet',12)
avg15=AverageFocal(test15,ex_alpha_param,ex_phi_param);

test15_1=GraphRays3(r1_12,r2_12,dist6,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg15_1=AverageFocal(test15_1,ex_alpha_param,ex_phi_param);


%ROTATION 3---------------------------------
%Test 16
test16=GraphRays3(r1_2,r2_2,dist1,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
%DisplayResults(test8)
%writecell(test16,'optics_simulator_testing.xlsx','Sheet',13)
avg16=AverageFocal(test16,ex_alpha_param,ex_phi_param);

test16_1=GraphRays3(r1_22,r2_22,dist1,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg16_1=AverageFocal(test16_1,ex_alpha_param,ex_phi_param);

%Test 17 
test17=GraphRays3(r1_2,r2_2,dist1,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
%DisplayResults(test17)
avg17=AverageFocal(test17,ex_alpha_param,ex_phi_param);
%DisplayResults(test9)

%writecell(test17,'optics_simulator_testing.xlsx','Sheet',14)
test17_1=GraphRays3(r1_22,r2_22,dist1,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg17_1=AverageFocal(test17_1,ex_alpha_param,ex_phi_param);

%Test 18
test18=GraphRays3(r1_2,r2_2,dist2,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg18=AverageFocal(test18,ex_alpha_param,ex_phi_param);

%DisplayResults(test10)
%writecell(test18,'optics_simulator_testing.xlsx','Sheet',15)
test18_1=GraphRays3(r1_22,r2_22,dist2,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg18_1=AverageFocal(test18_1,ex_alpha_param,ex_phi_param);

%Test 19
test19=GraphRays3(r1_2,r2_2,dist2,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg19=AverageFocal(test19,ex_alpha_param,ex_phi_param);
%DisplayResults(test11)
%writecell(test19,'optics_simulator_testing.xlsx','Sheet',16)

test19_1=GraphRays3(r1_22,r2_22,dist2,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg19_1=AverageFocal(test19_1,ex_alpha_param,ex_phi_param);

%Test 20
test20=GraphRays3(r1_2,r2_2,dist3,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg20=AverageFocal(test20,ex_alpha_param,ex_phi_param);
%}

test20_1=GraphRays3(r1_22,r2_22,dist3,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg20_1=AverageFocal(test20_1,ex_alpha_param,ex_phi_param);

%Test 21
test21=GraphRays3(r1_2,r2_2,dist3,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg21=AverageFocal(test21,ex_alpha_param,ex_phi_param);

test21_1=GraphRays3(r1_22,r2_22,dist3,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg21_1=AverageFocal(test21_1,ex_alpha_param,ex_phi_param);


%Test 22
test22=GraphRays3(r1_2,r2_2,dist6,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
%writecell(test22,'optics_simulator_testing.xlsx','Sheet',17)
avg22=AverageFocal(test22,ex_alpha_param,ex_phi_param);

test22_1=GraphRays3(r1_22,r2_22,dist6,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg22_1=AverageFocal(test22_1,ex_alpha_param,ex_phi_param);

%Test 23
test23=GraphRays3(r1_2,r2_2,dist6,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
%DisplayResults(test15)
avg23=AverageFocal(test23,ex_alpha_param,ex_phi_param);
%writecell(test23,'optics_simulator_testing.xlsx','Sheet',18)

test23_1=GraphRays3(r1_22,r2_22,dist6,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg23_1=AverageFocal(test23_1,ex_alpha_param,ex_phi_param);




%ROTATION 4---------------------

%Test 24
test24=GraphRays3(r1_3,r2_3,dist1,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg24=AverageFocal(test24,ex_alpha_param,ex_phi_param);
%DisplayResults(test8)
%writecell(test24,'optics_simulator_testing.xlsx','Sheet',19)

%Test 25
test25=GraphRays3(r1_3,r2_3,dist1,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg25=AverageFocal(test25,ex_alpha_param,ex_phi_param);
%DisplayResults(test9)
%writecell(test25,'optics_simulator_testing.xlsx','Sheet',20)

%Test 26
test26=GraphRays3(r1_3,r2_3,dist2,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
avg26=AverageFocal(test26,ex_alpha_param,ex_phi_param);
%DisplayResults(test10)
%writecell(test26,'optics_simulator_testing.xlsx','Sheet',21)

%Test 27
test27=GraphRays3(r1_3,r2_3,dist2,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
%DisplayResults(test11)
%writecell(test27,'optics_simulator_testing.xlsx','Sheet',22)

%Test 30
test30=GraphRays3(r1_3,r2_3,dist6,indices_small,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
%DisplayResults(test14)
%writecell(test30,'optics_simulator_testing.xlsx','Sheet',23)

%Test 31
test31=GraphRays3(r1_3,r2_3,dist6,indices_largest,ex_lim,ex_alpha_param,ex_phi_param,ex_color,ex_label);
%DisplayResults(test15)
%writecell(test31,'optics_simulator_testing.xlsx','Sheet',24)

%}
%}
%}

