
%IN a 2D space

syms t s 

%Parameters: 
%IN 2D
%{
l_origin2=[0;-0.0995172;0]*1000;
l_dir2=[0;0.03888114;0.99878215];
l_dir2=l_dir2/norm(l_dir2);

l_origin3=[0; -0.09794052;0]*1000;
l_dir3=[0;0.01835205; 0.9998026 ];
l_dir3=l_dir3/norm(l_dir3);

l_origin4=[0; -0.09819288;0]*1000;
l_dir4=[0; 0.02188467; 0.99963054];
l_dir4=l_dir4/norm(l_dir4);

l_origin5=[0;-0.09813952;0]*1000;
l_dir5=[0;0.02237695;0.99963369];
l_dir5=l_dir5/norm(l_dir5);

l_origin6=[0;-0.09841192;0]*1000;
l_dir6=[0;0.00915088;0.99963614];
l_dir6=l_dir6/norm(l_dir6);

l_origin7=[0;-0.09906525;0]*1000;
l_dir7=[0;0.01302515;0.99951866];
l_dir7=l_dir7/norm(l_dir7);

p_lo=[0;-0.09781963*1000;0];
p_ld=[0; 0.04130509; 0.99910793];
p_ld=p_ld/norm(p_ld);

d_lo=[0;-0.10136059*1000;0];
d_ld=[0;0.02188269;0.99968678];
d_ld=d_ld/norm(d_ld);
%}

%
%IN 3D
l_origin2=[-0.03090316;-0.0995172;0]*1000;
l_dir2=[0.03036567;0.03888114;0.99878215];

l_origin3=[-0.02938965; -0.09794052;0]*1000;
l_dir3=[-0.00760419;0.01835205; 0.9998026 ];

l_origin4=[-0.03088575; -0.09819288;0]*1000;
l_dir4=[0.01611468; 0.02188467; 0.99963054];

l_origin5=[-0.02968504;-0.09813952;0]*1000;
l_dir5=[0.01520644;0.02237695;0.99963369];

l_origin6=[-0.02991985;-0.09841192;0]*1000;
l_dir6=[0.02536296;0.00915088;0.99963614];

l_origin7=[-0.03142921;-0.09906525;0]*1000;
l_dir7=[0.02814415;0.01302515;0.99951866];

p_lo=[-0.02991158*1000;-0.09781963*1000;0];
p_ld=[0.00877752; 0.04130509; 0.99910793];

d_lo=[-0.03163025*1000;-0.10136059*1000;0];
d_ld=[0.01214438;0.02188269;0.99968678];
%}


l_error2=LaserDepthError(paralplane,layerthick1,indices_largest,wat_dp,l_origin2,l_dir2);

l_error3=LaserDepthError(paralplane,layerthick1,indices_largest,wat_dp,l_origin3,l_dir3);
l_error4=LaserDepthError(paralplane,layerthick1,indices_largest,wat_dp,l_origin4,l_dir4);
l_error5=LaserDepthError(paralplane,layerthick1,indices_largest,wat_dp,l_origin5,l_dir5);
l_error6=LaserDepthError(paralplane,layerthick1,indices_largest,wat_dp,l_origin6,l_dir6);
l_error7=LaserDepthError(paralplane,layerthick1,indices_largest,wat_dp,l_origin7,l_dir7);
l_err2=LaserDepthError(paralplane,layerthick1,indices_largest,wat_dp,p_lo,p_ld);
l_err6=LaserDepthError(paralplane,layerthick1,indices_largest,wat_dp,d_lo,d_ld);
 

laser_errtests=[l_error2;l_error3;l_error4;l_error5];
%;l_error4;l_error5;l_error6;l_error7
%laser_errtests=[laser_err2];

laser_originv=[l_origin2,l_origin3,l_origin4,l_origin5];
laser_dirv=[l_dir2,l_dir3,l_dir4,l_dir5];

%{
laser_originv=[l_origin2,l_origin3,l_origin4,l_origin5,l_origin6,l_origin7];
laser_dirv=[l_dir2,l_dir3,l_dir4,l_dir5,l_dir6,l_dir7];
%}

figure
title('% Error in Length & Depth according to laser parameters and depth')
xlabel('Depth (m)')
ylabel('Percent Error')
grid on 
[r,u]=size(laser_errtests);


for i = 1:11:r %for each test, I assume ten depths(?)
    test_lasererror=laser_errtests(i:i+10,1:5);
  
    o_param=(laser_originv(:,((i+10)/11)))';
    d_param=(laser_dirv(:,((i+10)/11)))';

    plot_x=test_lasererror(:,1)/1000;
    plot_y=test_lasererror(:,3);


    %Figure out ideal depth 2D:
    %-----------------------------------------
    %ideal_d=-o_param(2)*(d_param(3)/d_param(2));

    %IDEAL DEPTH 3D
     %Figure out ideal depth 
    %-----------------------------------------
    %Defining a line representing optical axis
    l1=[0;0;t];

    %Defining a line from the intersection of the end of the ray in water back torward the optical axis 
    l2=[o_param(1)+d_param(1)*s;o_param(2)+d_param(2)*s;o_param(3)+d_param(3)*s];

     %Defining line directions 
     d1=[0;0;1];
     d2=d_param';

     %Solve for s and t
     l12=l2-l1; 
     Eq1=l12'*d1;
     Eq2=l12'*d2;
     [tans,sans]=solve([Eq1,Eq2],[t,s]); 
    las= round(tans/1000,1)
     laser_z=o_param(3)+d_param(3)*sans;
     lasz=round(laser_z/1000,2)


     
    %Using least squares method:
    laser_l=o_param';
    laser_lxy=laser_l(1:2);
    laser_alpha=d_param';
    laser_alphaxy=laser_alph(1:2);
    laser_v=[0;0;1];
    laser_vxy=laser_v(1:2);
 
    lam=(-laser_alphaxy'*laser_lxy*laser_alpha'*laser_v+norm(laser_alpha)^2*laser_vxy'*laser_lxy)/((laser_alpha'*laser_v)^2-norm(laser_alpha)^2*norm(laser_v)^2);
   depth_est=-lam*laser_v(3)
%}




    hold on
    
   % scatter(plot_x,plot_y,'filled','DisplayName',' d ideal: ' + string(round(ideal_d/1000,1)))
    scatter(plot_x,plot_y,'filled','DisplayName',' d ideal: ' + string(round(tans/1000,1))+ " " + string(round(depth_est/1000,1)))

    legend

end
%}