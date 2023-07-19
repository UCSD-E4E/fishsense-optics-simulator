%Code to graph light rays refracting through glass & water 

function GraphRays2 (normal,dist,indices,lim,alpha_param,phi_param,label)

    %Defining paramters
    d_air=dist(1); %distance from camera optical center to glass  
    d_glass=dist(2); %glass thickness in mm
    d_water=dist(3); %distance from glass/water interfrace to a plane in the water 
    mu_air=1;
    mu_glass=indices(1); %glass refraction index
    mu_water=indices(2); %water refraction index

    origin = [0;0;0]; %assuming the origin is the camera optical center
    %alpha_deg=acos((ray0'*normal)/norm(ray0))*180/3.141592;

    % Create Graph
    figure1 = figure;
    axes1 = axes('Parent',figure1);
    hold(axes1,'on');
    zlabel({'Y axis'});
    ylabel({'Z axis'});
    xlabel({'X axis'});
    xlim(axes1,[-lim lim]); %X axis
    ylim(axes1,[-lim/8 lim]); %Z axis
    zlim(axes1,[-lim lim]); %Y axis
    view(axes1,[90 0.77]);
    grid(axes1,'on');
    hold(axes1,'off');
    set(axes1,'ZDir','reverse'); 
    %Graphing note: Y becomes Z axis, Z becomes Y axis (to
    %match diagrams)
    
    %Graphing interface planes
    x_p=-200:200; %200x200 planes
    y_p=-200:200;
    [X_P,Y_P]=meshgrid(x_p,y_p);
    size(X_P);
    hold on
    surf(Y_P,d_air*ones(401,401),X_P) %glass plane
    surf(Y_P,(d_air+d_glass)*ones(401,401),X_P) %water plane
    plot3(0,0,0,'o','MarkerSize',6,'MarkerFaceColor','#000000') %marking origin
    quiver3(0,-50,0,0,100,0,'--ok') %graphing optical axis
    parameters= "d_air"+ d_air + " mm, d_glass=" + d_glass + " mm, d_water="+d_water + " mm, glass IOR=" + mu_glass + ", water IOR=" +mu_water;
    title('Flat Port Underwater Refraction',parameters);
    
    %Setting up color map
    ii=0;
    n=round((((alpha_param(3)-alpha_param(1))/alpha_param(2))+1)*(((phi_param(3)-phi_param(1))/phi_param(2))+1));
    CM=jet(n);
    
    %Calculate & plot rays
    for alpha = alpha_param(1):alpha_param(2):alpha_param(3) %looping through alpha
        r= d_air*tan(alpha); 
        for phi = phi_param(1):phi_param(2):phi_param(3) %looping  through phi
            ray0_x=r*cos(phi);
            ray0_y=r*sin(phi);
            ray0=[ray0_x;ray0_y;d_air];
    
            %compute ray vectors
            [v_glass, v_water, glass_intercept,water_intercept]= pathfinder(origin, ray0,mu_air,d_air,d_glass,mu_glass,mu_water,normal); 
            
            %Find intersection of ray to point in 3D space
            scale_water = d_water / (v_water' * normal);
            fish_intercept = (scale_water*v_water + water_intercept); 
           
            origins=[(origin)';(glass_intercept)';(water_intercept)']; %origin & intersections of rays at each interface
            directions=[(glass_intercept)';((water_intercept-glass_intercept))';((fish_intercept-water_intercept))']; %ray length & direction
    
            x_origins=origins(:,1);
            y_origins=origins(:,3); %switch z to y axis
            z_origins=origins(:,2); %switch y to z axis
            v_x=directions(:,1);
            v_y=directions(:,3);
            v_z=directions(:,2);
            
            ii= ii +1; %for color change 
            
            % Tracing back water rays to optical axis
            fish_origin=[fish_intercept(1),fish_intercept(3),fish_intercept(2)]; %end of ray in water with coordinates switched
            b_dir=[-v_water(1),-v_water(3),-v_water(2)]; %direction of water ray back to origin, switching axis
            b_scale=10*(d_air+d_glass+d_water); %scale for backtraced rays

            %Plot
            if label=='y' %For color matched ray & backtraced rays 
                hold on
                quiver3(x_origins,y_origins,z_origins,v_x,v_y,v_z,0,'color',CM(ii,:),'marker','*') %refraction rays
                hold on
                quiver3(fish_origin(1),fish_origin(2),fish_origin(3),b_scale*b_dir(1),b_scale*b_dir(2),b_scale*b_dir(3),0,'color',CM(ii,:)) %backtraced rays 
            else %Plotting refracted rays blue and backtraced rays red
                hold on
                quiver3(x_origins,y_origins,z_origins,v_x,v_y,v_z,0,'-*b') %refraction rays
                hold on
                quiver3(fish_origin(1),fish_origin(2),fish_origin(3),b_scale*b_dir(1),b_scale*b_dir(2),b_scale*b_dir(3),0,'-*r') %backtraced rays 
            end
        end
    end
end 


