%Code to graph light rays refracting through glass & water 

%rotation1 contains [rot_y1,rot_x1] for plane 1, rotation2 contains
% [rot_y2,rot_x2] for plane 2

%Equations marked by [1] are taken from [1]

% [1] A. Agrawal, S. Ramalingam, Y. Taguchi and V. Chari, "A theory of multi-layer flat refractive geometry," 
% 2012 IEEE Conference on Computer Vision and Pattern Recognition, 
% Providence, RI, USA, 2012, pp. 3346-3353, doi: 10.1109/CVPR.2012.6248073.

function focal_information= GraphRays3 (rotation1,rotation2,thickness,indices,lim,alpha_param,phi_param,focal_length,pixel_pitch,color,label)

    %Thickness of layers, measured from previous plane to the intersection of the optical axis to the plane 
    t_air=thickness(1); 
    t_glass=thickness(2); 
    t_water=thickness(3); 
    dist_water=t_air+t_glass;
    b_scale=5*(t_air+t_glass+t_water); %arbitrary scale for tracing rays back 

    %Indices of refraction
    i_air=indices(1); 
    i_glass=indices(2);
    i_water=indices(3); 

    %Defining origin and optical axis
    origin = [0;0;0]; 
    optical_axis = [0;0;1];
   
    %Setting up color map/matrix indices
    ii=0;
    i_=0;
    n=round((((alpha_param(3)-alpha_param(1))/alpha_param(2))+1)*(((phi_param(3)-phi_param(1))/phi_param(2))+1));
    CM=jet(n);
    
    %Finding parameters for forloop
    num_alpha=floor((alpha_param(3)-alpha_param(1))/alpha_param(2))+1;
    num_phi=floor((phi_param(3)-phi_param(1))/phi_param(2))+1;

    %Setting up empty cells for focal information of each backtraced ray
    focal_information=cell(num_alpha,num_phi);

    
    %Create figure
    figure

    %graphing optical axis and origin
    quiver3(0,-50,0,0,100,0,'--ok') 
    plot3(0,0,0,'o','MarkerSize',5,'MarkerFaceColor','#000000') 
    %}

    %{
    %UNCOMMENT TO SHOW LASER POSITION & DIRECTION ON GRAPH
    laser_dir=[0.01199697; 0.04052028 ; 0.99910662]; 
    laser_origin=[-0.03083158; -0.09916128;  0]*1000;
    laser_scaleout= t_water/laser_dir(3);
    laser_fishpos=laser_dir*laser_scaleout;

    %Plotting laser
    hold on 
    quiver3(laser_origin(1),laser_origin(3),laser_origin(2),laser_fishpos(1),laser_fishpos(3),laser_fishpos(2),0,'-k');
    %}

    %Graphing note: Y becomes Z axis, Z becomes Y axis (to match convention)
    ax= gca;
    ax.ZDir='reverse';
    grid on 

    %Defining Rotation Matrices
    R_x1=[1,0,0;0,cos(rotation1(2)),-sin(rotation1(2));0,sin(rotation1(2)),cos(rotation1(2))];
    R_y1=[cos(rotation1(1)),0,sin(rotation1(1));0,1,0;-sin(rotation1(1)),0,cos(rotation1(1))];
    rotation_matrix1=R_x1*R_y1;

    R_x2=[[1,0,0];[0,cos(rotation2(1)),-sin(rotation2(1))];[0,sin(rotation2(1)),cos(rotation2(1))]];
    R_y2=[[cos(rotation2(2)),0,sin(rotation2(2))];[0,1,0];[-sin(rotation2(2)),0,cos(rotation2(2))]];
    rotation_matrix2=R_x2*R_y2;

    %Defining pre-translation rotated interface planes (corner coordinates)
    plane_size=2000; %2 m by 2 m plane representing refractive planes

    top_left=rotation_matrix1*[-plane_size;-plane_size;0];
    top_right=rotation_matrix1*[plane_size;-plane_size;0];
    bottom_left=rotation_matrix1*[-plane_size;plane_size;0];
    bottom_right=rotation_matrix1*[plane_size;plane_size;0];

    top_left2=rotation_matrix2*[-plane_size;-plane_size;0];
    top_right2=rotation_matrix2*[plane_size;-plane_size;0];
    bottom_left2=rotation_matrix2*[-plane_size;plane_size;0];
    bottom_right2=rotation_matrix2*[plane_size;plane_size;0];

    %translating z coordinates to actual interface depths 
    x_coords1=[bottom_left(1);top_left(1);top_right(1);bottom_right(1)];
    y_coords1=[bottom_left(2);top_left(2);top_right(2);bottom_right(2)];
    z_coords1=[(bottom_left(3)+t_air);(top_left(3)+t_air);(top_right(3)+t_air);(bottom_right(3)+t_air)]; 

    x_coords2=[bottom_left2(1);top_left2(1);top_right2(1);bottom_right2(1)]; 
    y_coords2=[bottom_left2(2);top_left2(2);top_right2(2);bottom_right2(2)];
    z_coords2=[(bottom_left2(3)+dist_water);(top_left2(3)+dist_water);(top_right2(3)+dist_water);(bottom_right2(3)+dist_water)]; 

    %Graphing interface planes
    patch(x_coords1,z_coords1,y_coords1,[0.3010 0.7450 0.9330])
    hold on
    patch(x_coords2,z_coords2,y_coords2,[0 0.5470 0.5410])
    hold on
    parameters= "depths(mm): air:"+ t_air + ", glass:" + t_glass + ", water:"+t_water + ", IOR: glass:" + i_glass + ", water:" +i_water;
    title('Flat Port Underwater Refraction',parameters);
    xlabel('X Axis (mm)')
    ylabel('Z Axis (mm)')
    zlabel('Y Axis (mm)')
    xlim([-lim lim]);
    ylim([-lim/4 lim]);
    zlim([-lim lim]);
    view(gca,[90 0.77])
     
    %{ 
    %UNCOMMENT TO DISPLAY ROTATION PARAMETERS
    text(0,-4,4,"Plane 1 Rotation: [" + string(rotation1(1)*180/pi) + " about Y, " + string(rotation1(2)*180/pi) + " about X] degrees");
    text(0,-4,2,"Plane 2 Rotation: [" + string(rotation2(1)*180/pi) + " about Y, " + string(rotation2(2)*180/pi) + " about X] degrees");
    %}

   %Calculate & plot rays
    for alpha = alpha_param(1):alpha_param(2):alpha_param(3)

        i_=i_+1;
        r= t_air*tan(alpha); 
        j_=0;

        for phi = phi_param(1):phi_param(2):phi_param(3)

            initialray_x=r*cos(phi);
            initialray_y=r*sin(phi);
            initialray=[initialray_x;initialray_y;t_air];
    
            %Compute Ray Vectors
            ray_information= FindIntersection(rotation_matrix1,rotation_matrix2,initialray,t_air,t_glass,t_water,i_air,i_glass,i_water,origin);
                                             
            %Ray Data
            vwater=ray_information(1,:);
            intersect_glass=ray_information(2,:);
            intersect_water=ray_information(3,:);
            intersect_fish=ray_information(4,:);
            opticalintersect=ray_information(5,:);

            %Find origins and directions of each refracted section of the
            %ray
            origins=[(origin)';(intersect_glass);(intersect_water)]; 
            directions=[(intersect_glass);((intersect_water-intersect_glass));((intersect_fish-intersect_water))];
    
            x_origins=origins(:,1);
            y_origins=origins(:,3); %switch z to y axis
            z_origins=origins(:,2); %switch y to z axis
            v_x=directions(:,1);
            v_y=directions(:,3);
            v_z=directions(:,2);
            
            %Tracing back water rays to optical axis
            fish_origin=[intersect_fish(1),intersect_fish(3),intersect_fish(2)];
            b_dir=[-vwater(1),-vwater(3),-vwater(2)];

            %Find xy positional error 
            norm_initial=initialray/norm(initialray); %unit vector in air 
            scaling_fish=(t_air+t_glass+t_water)/norm_initial(3); %because you want the z direction to  be all in one depth 
            estim_fishintercept=scaling_fish*norm_initial;
            xy_error=estim_fishintercept'-intersect_fish;

            %Find intersection of ray with image sensor
            focal_scale=focal_length/norm_initial(3);
            sensor_coord=(focal_scale/pixel_pitch)*[-norm_initial(1);-norm_initial(2)];
            x_pixel=floor(sensor_coord(1));
            y_pixel=floor(sensor_coord(2));
            
            mag_pixel=floor(norm(sensor_coord));

            %For color change ('y' color label option)
            ii= ii +1; 
            j_= j_ +1;
            
            %each row is a different alpha, column a different phi         
            focal_information{i_,j_}=[double(round(alpha*180/pi)),double(round(phi*180/pi)),double(real(opticalintersect)),double(xy_error),x_pixel,y_pixel,mag_pixel];
            
            
            %Plotting ray with chosen labeling option
            if color=='y' 
                hold on
                quiver3(x_origins,y_origins,z_origins,v_x,v_y,v_z,0,'color',CM(ii,:),'marker','-*') %refracted rays
                hold on
                quiver3(fish_origin(1),fish_origin(2),fish_origin(3),b_scale*b_dir(1),b_scale*b_dir(2),b_scale*b_dir(3),'color',CM(ii,:)) %backtraced rays 
            else 
                hold on
                quiver3(x_origins,y_origins,z_origins,v_x,v_y,v_z,0,'-*b') %refracted rays
                hold on
                quiver3(fish_origin(1),fish_origin(2),fish_origin(3),b_scale*b_dir(1),b_scale*b_dir(2),b_scale*b_dir(3),'-*r') %backtraced rays
                hold on
                quiver3(0,0,0,estim_fishintercept(1),estim_fishintercept(3),estim_fishintercept(2),0,'-pentagramk') %estimated rays

                if label =='y' %labeling each ray with its alpha angle 
                    label_coords=[intersect_glass(1)*2/3,intersect_glass(2)*2/3,intersect_glass(3)*2/3];
                    label_alpha=string(round(alpha*180/pi));
                    text(label_coords(1),label_coords(3),label_coords(2),string(label_alpha),'FontSize',8,'Color',[0 .3 .7])
                end
            end 
        end       
    end
end 



