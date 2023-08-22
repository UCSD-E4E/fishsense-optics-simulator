%Function to calculate the intersection point of a ray with 2 refraction planes.
%Plane 1 refers to the air/glass interface and plane 2 refers to the 
%glass/water interface

function [intersections]= FindIntersection(rmatrix1,rmatrix2,v_air,d_air,d_glass,d_water,mu_air,mu_glass,mu_water,origin)
    
    syms t1 t2 t7 t s

    % Ensure input vector is a unit vector 
    v_air = v_air / norm(v_air);

    %Defining arbitrary points on pre-translated/rotated plane
    arb_pt1=[1;0;0]; 
    arb_pt2=[0;1;0];

    %Rotating arbitrary points for Plane 1
    rotated_arbpt1=(rmatrix1*arb_pt1)';
    rotated_arbpt11=(rmatrix1*arb_pt2)';

    %Rotating arbitrary points for plane 2
    rotated_arbpt2=(rmatrix2*arb_pt1)';
    rotated_arbpt22=(rmatrix2*arb_pt2)';

    %Finding the normals of each refractive plane (points in +Z direction)
    normal1=cross(rotated_arbpt1,rotated_arbpt11);
    normal1=(normal1/norm(normal1))';

    normal2=cross(rotated_arbpt2,rotated_arbpt22);
    normal2=(normal2/norm(normal2))';
    
    %Defining set points on translated/rotated plane
    planepoint1=[0;0;d_air]; 
    planepoint2=[0;0;d_air+d_glass];
    planepoint3=[0;0;d_air+d_glass+d_water];
    
    %Parametrize air ray 
    x1=origin(1)+ t1*v_air(1);
    y2=origin(2)+ t1*v_air(2);
    z2=origin(3)+ t1*v_air(3);
    
    %Define plane 1 equation
    plane1=normal1(1)*(x1-planepoint1(1))+normal1(2)*(y2-planepoint1(2))+normal1(3)*(z2-planepoint1(3)); 

    %Solve intersection point for plane 1
    t_ans1= simplify(vpasolve(plane1,t1)); 
    glass_intersect=[simplify(origin(1)+t_ans1*v_air(1));simplify(origin(2)+t_ans1*v_air(2));simplify(origin(3)+t_ans1*v_air(3))];
    
    % Use Snell's law to get direction of ray in glass [1]
    normal1=-normal1; 
    a_glass = mu_air/mu_glass; 
    b_glass = -mu_air*v_air'*normal1;
    b_glass = b_glass - sqrt(mu_air^2*(v_air'*normal1)^2 - (mu_air^2-mu_glass^2)*(v_air'*v_air));
    b_glass = b_glass/mu_glass; 

    v_glass = a_glass * v_air + b_glass * normal1;

    %Parametrize glass ray 
    x2=glass_intersect(1)+ t2*v_glass(1);
    y2=glass_intersect(2)+ t2*v_glass(2);
    z2=glass_intersect(3)+ t2*v_glass(3);
   
    %Define equations of planes
    plane2=normal2(1)*(x2-planepoint2(1))+normal2(2)*(y2-planepoint2(2))+normal2(3)*(z2-planepoint2(3));

    %Solve for glass/water intersection
    t_ans2= simplify(vpasolve(plane2,t2));
    water_intersect=[simplify(glass_intersect(1)+t_ans2*v_glass(1));simplify(glass_intersect(2)+t_ans2*v_glass(2));simplify(glass_intersect(3)+t_ans2*v_glass(3))];
   
    % Use Snell's law to get v_water [1]
    normal2=-normal2; 
    a_water = mu_glass/mu_water;
    b_water = -mu_glass*v_glass'*normal2;
    b_water = b_water - sqrt(mu_glass^2*(v_glass'*normal2)^2 - (mu_glass^2-mu_water^2)*(v_glass'*v_glass)); 
    b_water = b_water/mu_water; 
    
    v_water = a_water * v_glass + b_water * normal2;

    
    %Find intersection of rays to a given depth 

    %Parametrize glass ray 
    x3=water_intersect(1)+ t7*v_water(1);
    y3=water_intersect(2)+ t7*v_water(2);
    z3=water_intersect(3)+ t7*v_water(3);
   
    %Define equations of planes

    plane3=1*(z3-planepoint3(3));

    %Solve for glass/water intersection
    t_ans7= simplify(vpasolve(plane3,t7));
    fish_intersect=[simplify(water_intersect(1)+t_ans7*v_water(1));simplify(water_intersect(2)+t_ans7*v_water(2));simplify(water_intersect(3)+t_ans7*v_water(3))];
   

    %Find shortest distance of the rays to optical axis, and location

    t3=water_intersect(1)/v_water(1);
    t4=water_intersect(2)/v_water(2);

    if round(t3,8)==round(t4,8) %If rays intersect optical axis. Rounding to 8 decimals. 
        x_intersect=0;
        y_intersect=0;
        z_intersect=simplify(water_intersect(3)-v_water(3)*t3);

    elseif (cross(v_water',[0,0,1])==0) %if there's no refraction 
        x_intersect=0;
        y_intersect=0;
        z_intersect=0;

    else%If rays do not intersect optical axis 

        %Defining a line representing optical axis
        l1=[0;0;-1000+t];

        %Defining a line from the intersection of the end of the ray in water back torward the optical axis 
        l2=[water_intersect(1)-v_water(1)*s;water_intersect(2)-v_water(2)*s;water_intersect(3)-v_water(3)*s];

        %Defining line directions
        d1=[0;0;1];
        d2=-v_water;

        %Solve for s and t
        l12=l2-l1;
        Eq1=l12'*d1;
        Eq2=l12'*d2;
        [tans,sans]=solve([Eq1,Eq2],[t,s]); 
        
        %Finding closest point on backtraced ray to optical axis
        Q=[water_intersect(1)-v_water(1)*sans;water_intersect(2)-v_water(2)*sans;water_intersect(3)-v_water(3)*sans];

        x_intersect=double(Q(1));
        y_intersect=double(Q(2));
        z_intersect=double(Q(3));
    end
    optical_intersect=[x_intersect;y_intersect;z_intersect];
    intersections=[v_water';glass_intersect';water_intersect';fish_intersect';optical_intersect'];
end


