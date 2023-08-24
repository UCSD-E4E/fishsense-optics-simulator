%Function that plots a laser (given a direction and origin), and, at given depths, plots
%refracted and unrefracted lightrays. Assumes planes are parallel and
%perpendicular to optical axis


function [depth_error]=LaserDepthError(layer_normal,layer_thickness,layer_indices,waterdepth_param,laserorigin,laserdir)

    syms var_camray var_laser

    %Extract layer thicknesses from vector
    a_thickness=layer_thickness(1);
    g_thickness=layer_thickness(2);

    %Define parallel, unrotated glass planes
    rotation_matrixparallel=[1,0,0;0,1,0;0,0,1];
    totrotation_matrixparallel=rotation_matrixparallel*rotation_matrixparallel;

    %{
    %Create Graph
    figure1=figure;
    % Create axes
    axes1 = axes('Parent',figure1);
    hold(axes1,'on');
    % Create zlabel
    zlabel({'Y Axis (mm)',''});
    % Create ylabel
    ylabel({'Z axis',''});
    % Create xlabel
    xlabel('X axis (mm)');
    grid(axes1,'on');
    hold(axes1,'off');
    % Set the remaining axes properties
    set(axes1,'ZDir','reverse');
    %}

    %Setting up color map to match rays corresponding to each depth 
    num_w=round((waterdepth_param(3)-waterdepth_param(1))/waterdepth_param(2)+1);
    CM=jet(num_w);
    xx=0; 
    
    %Setting up output matrix: shows depth, error in depth, and percent error in depth/length 
    depth_error=zeros(num_w,5);

    %Setting up interface planes
    plane_size=2000;
    x_oords1=[-plane_size;-plane_size;plane_size;plane_size];
    y_oords1=[plane_size;-plane_size;-plane_size;plane_size];
    z_oords1=[a_thickness;a_thickness;a_thickness;a_thickness]; 
    z_oords2=[a_thickness+g_thickness;a_thickness+g_thickness;a_thickness+g_thickness;a_thickness+g_thickness]; 
    %{
    %Graph interface planes, origin, optical axis and laser
    patch(x_oords1,z_oords1,y_oords1,[0.3010 0.7450 0.9330])
    hold on
    patch(x_oords1,z_oords2,y_oords1,[0 0.5470 0.5410])
    hold on
    plot3(0,0,0,'o','MarkerSize',5,'MarkerFaceColor','#000000');
    hold on
    quiver3(0,-50,0,0,100,0,'--ok') 
    hold on
    quiver3(laserorigin(1),laserorigin(3),laserorigin(2),6000*laserdir(1),6000*laserdir(3),6000*laserdir(2),0,'-*r')
    %}


    %For loop for each depth 
    for w=waterdepth_param(1):waterdepth_param(2):waterdepth_param(3)
       %Keeping track of each iteration
       xx=xx+1;

       %Calculate XYZ coordinates of laser on fish
       scaling_laser=(w-laserorigin(3))/laserdir(3);
       laser_posfish=laserorigin+ scaling_laser*laserdir;
        
       %SolveForwardProjection to find air/glass intersection of light ray coming back from fish 
       glassintersection=SolveForwardProjectionCase3(a_thickness,(a_thickness+g_thickness),layer_normal,layer_indices(2:3),laser_posfish);
       vair=glassintersection/norm(glassintersection);

       %Find intersection points of the refracted ray
       rayintersections= FindIntersection(totrotation_matrixparallel,totrotation_matrixparallel,vair,a_thickness,g_thickness,w,layer_indices(1),layer_indices(2),layer_indices(3),[0;0;0]);

       ag_intersect=rayintersections(2,:);
       gw_intersect=rayintersections(3,:);

       planeorigins=[0,ag_intersect(1),gw_intersect(1);0,ag_intersect(2),gw_intersect(2);0,ag_intersect(3),gw_intersect(3)];
       laser_refractedray_dir=[[ag_intersect(1),(gw_intersect(1)-ag_intersect(1)),(laser_posfish(1)-gw_intersect(1))];[ag_intersect(2),(gw_intersect(2)-ag_intersect(2)),(laser_posfish(2)-gw_intersect(2))];[ag_intersect(3),(gw_intersect(3)-ag_intersect(3)),(laser_posfish(3)-gw_intersect(3))]]; 
       
       %plot refrfacted (actual) and unrefracted (estimated) light rays 
       %{
       hold on 
       quiver3(planeorigins(1,:),planeorigins(3,:),planeorigins(2,:),laser_refractedray_dir(1,:),laser_refractedray_dir(3,:),laser_refractedray_dir(2,:),0,'color',CM(xx,:))
       scatter3(laser_posfish(1),laser_posfish(3),laser_posfish(2),'filled')
       text(laser_posfish(1),laser_posfish(3),laser_posfish(2),"Ref")
       hold on 
       
       %plot estimated, unrefracted light rays. Extend out by arbitrary 6000 mm
       %scale
       quiver3([0],[0],[0],vair(1)*6000,vair(3)*6000,vair(2)*6000,0,'color',CM(xx,:))
       %}
       %Find estimated error between refracted and unrefracted laser
       %positions
%}

       %define EQ
       Eq_y=(laserorigin(2)+var_laser*laserdir(2))-(var_camray*vair(2));
       Eq_z=(laserorigin(3)+var_laser*laserdir(3))-(var_camray*vair(3));

       %Find intersection with line 
       [varcam,varlaser]=vpasolve([Eq_y,Eq_z],[var_camray,var_laser]);
        
       %Find difference in depth
       estimation_posfish=simplify(varcam*vair);

       %angle of vair
       a_vair=acos((vair'*[0;0;1])/norm(vair))*180/pi;
       p_vair=acos((vair'*[1;0;0])/norm(vair))*180/pi;

       error_indepth=estimation_posfish(3)-laser_posfish(3);
       percent_depth_error= (error_indepth/laser_posfish(3))*100;
       depth_error(xx,:)=[w,error_indepth,percent_depth_error,a_vair,p_vair];
    end
end 