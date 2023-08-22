%Given a determined distance, plot unrefracted and refracted rays. Blue
%dotted lines are refracted rays, black line unrefracted, and red is the
%laser

function FindLaserDepthError(rot1,rot2,layer_thickness,layer_indices,laser_origin,laser_dir)
    syms tp td

    %Defining layer thicknesses
    air_dist=layer_thickness(1);
    glass_dist=layer_thickness(2);
    dist_water=air_dist+glass_dist;
    dwat=layer_thickness(3);

    %Defining indices of refraction
    air_mu=layer_indices(1);
    glass_mu=layer_indices(2);
    water_mu=layer_indices(3);

    %Defining laser direction
    normlaser_dir=laser_dir/norm(laser_dir);

    %Defining Rotation Matrices
    Rx_1=[1,0,0;0,cos(rot1(2)),-sin(rot1(2));0,sin(rot1(2)),cos(rot1(2))];
    Ry_1=[cos(rot1(1)),0,sin(rot1(1));0,1,0;-sin(rot1(1)),0,cos(rot1(1))];
    rotationmatrix_1=Rx_1*Ry_1;

    Rx_2=[[1,0,0];[0,cos(rot2(1)),-sin(rot2(1))];[0,sin(rot2(1)),cos(rot2(1))]];
    Ry_2=[[cos(rot2(2)),0,sin(rot2(2))];[0,1,0];[-sin(rot2(2)),0,cos(rot2(2))]];
    rotationmatrix_2=Rx_2*Ry_2;

    %Defining pre-translation interface planes (corner coordinates)
    plane_size=2000;

    top_left=rotationmatrix_1*[-plane_size;-plane_size;0];
    top_right=rotationmatrix_1*[plane_size;-plane_size;0];
    bottom_left=rotationmatrix_1*[-plane_size;plane_size;0];
    bottom_right=rotationmatrix_1*[plane_size;plane_size;0];

    top_left2=rotationmatrix_2*[-plane_size;-plane_size;0];
    top_right2=rotationmatrix_2*[plane_size;-plane_size;0];
    bottom_left2=rotationmatrix_2*[-plane_size;plane_size;0];
    bottom_right2=rotationmatrix_2*[plane_size;plane_size;0];

    x_coords1=[bottom_left(1);top_left(1);top_right(1);bottom_right(1)];
    y_coords1=[bottom_left(2);top_left(2);top_right(2);bottom_right(2)];
    z_coords1=[(bottom_left(3)+air_dist);(top_left(3)+air_dist);(top_right(3)+air_dist);(bottom_right(3)+air_dist)]; 

    x_coords2=[bottom_left2(1);top_left2(1);top_right2(1);bottom_right2(1)]; 
    y_coords2=[bottom_left2(2);top_left2(2);top_right2(2);bottom_right2(2)];
    z_coords2=[(bottom_left2(3)+dist_water);(top_left2(3)+dist_water);(top_right2(3)+dist_water);(bottom_right2(3)+dist_water)]; %translating y coordinates
   
    z_coords3=[(bottom_left(3)+dist_water+dwat);(top_left(3)+dist_water+dwat);(top_right(3)+dist_water+dwat);(bottom_right(3)+dist_water+dwat)]; %translating y coordinates

    figure
    %Graph interface planes
    patch(x_coords1,z_coords1,y_coords1,[0.3010 0.7450 0.9330])
    hold on
    patch(x_coords2,z_coords2,y_coords2,[0 0.5470 0.5410])
    hold on
    patch(x_coords1,z_coords3,y_coords1,[0.3010 0.7450 0.9330]) %fish plane 
 
   
    lim=100;
    xlabel('X Axis (mm)')
    ylabel('Z Axis (mm)')
    zlabel('Y Axis (mm)')
    xlim([-lim lim]);
    ylim([-lim/4 lim]);
    zlim([-lim lim]);
    view(gca,[90 0.77])

    plot3(0,0,0,'o','MarkerSize',5,'MarkerFaceColor','#000000');

    ax= gca;
    ax.ZDir='reverse';


%Code below used to find error/distance between dive and pool rays.
%Uncomment to see plot of the two different lasers. This assumes laser
%origin/laser direction inputs of the function are the pool parameters. The
%dive parameters are hard coded below. 


    %Define dive directions
    diveorigin=[-0.03163025; -0.10136059; 0]*1000;
    divedir=[0.01214438; 0.02188269;0.99968678];

    %Parametrize pool laser 
    zpray=laser_origin(3)+ tp*normlaser_dir(3);
   
    %Define equations of planes
    planefishp=1*(zpray-(dist_water+dwat));

    %Solve for poolray/fishplane intersection
    tp_ans= simplify(vpasolve(planefishp,tp));
    poolfish_intersect=[simplify(laser_origin(1)+tp_ans*normlaser_dir(1));simplify(laser_origin(2)+tp_ans*normlaser_dir(2));simplify(laser_origin(3)+tp_ans*normlaser_dir(3))];

    %solve for dive laser fish intersect
    %Parametrize dive laser 
    zdray=diveorigin(3)+ td*divedir(3);
   
    %Define equations of planes
    planefishd=1*(zdray-(dist_water+dwat));

    %Solve for poolray/fishplane intersection
    td_ans= simplify(vpasolve(planefishd,td));
    divefish_intersect=[simplify(diveorigin(1)+td_ans*divedir(1));simplify(diveorigin(2)+td_ans*divedir(2));simplify(diveorigin(3)+td_ans*divedir(3))];

    hold on
    quiver3(laser_origin(1),laser_origin(3),laser_origin(2),(poolfish_intersect(1)-laser_origin(1)),(poolfish_intersect(3)-laser_origin(3)),(poolfish_intersect(2)-laser_origin(2)),0,'-or');
    hold on 
    %plot dive direction
    quiver3(diveorigin(1),diveorigin(3),diveorigin(2),(divefish_intersect(1)-diveorigin(1)),(divefish_intersect(3)-diveorigin(3)),(divefish_intersect(2)-diveorigin(2)),0,'-ok');
    laser_diff=divefish_intersect-poolfish_intersect
    magnitude_diff=norm(laser_diff)
    %anglediff=arccos((laser_dir'*divedir)/(norm(laser_dir)*norm(divedir));


    %Code below will plot unrefracted and refracted depths. Comment out
    %above code, and uncomment below code to see this
%{
    %Looping through different estimated depths 
    for d=1000:100:2000

        zscale=d/normlaser_dir(3);
        laser_vec=zscale*normlaser_dir; %Vector describing length from laser origin to given depth

        laserfish=laser_origin+laser_vec; %position of laser dot on fish
        estimated_laser=laserfish/norm(laserfish); %defining the unit vector from origin to intersection of laser with given depth 
        find_laserintersect=FindIntersection(rotationmatrix_1,rotationmatrix_2,estimated_laser,air_dist,glass_dist,dwat,air_mu,glass_mu,water_mu,[0;0;0]); %find refractive intersection points

    
        laserinwater_vec=(find_laserintersect(1,:))';
        laser_glasswater_pos=(find_laserintersect(3,:))';
        laser_airglass_pos=find_laserintersect(2,:)';
        
        inglass_directions=laser_glasswater_pos-laser_airglass_pos; %vector describing length and direction of ray in the glass
        
        %Plotting the estimated vector 
        hold on
        quiver3(0,0,0,laserfish(1),laserfish(3),laserfish(2),0,'-*k')
       
        %Plotting the refracted vector 
        hold on
        quiver3([0,laser_airglass_pos(1),laser_glasswater_pos(1)],[0,laser_airglass_pos(3),laser_glasswater_pos(3)],[0,laser_airglass_pos(2),laser_glasswater_pos(2)],[laser_airglass_pos(1),inglass_directions(1),3000*laserinwater_vec(1)],[laser_airglass_pos(3),inglass_directions(3),3000*laserinwater_vec(3)],[laser_airglass_pos(2),inglass_directions(2),3000*laserinwater_vec(2)],0,'--*b')
        
    end 
%}


end