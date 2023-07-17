%Code to graph light rays refracting through glass & water 

function GraphRays (dist,indices,lim,alpha_param,phi_param,label)

    %Defining paramters
    d0=dist(1); %distance from camera optical center to glass  
    d1=dist(2); %glass thickness in mm
    d2=dist(3); %distance from glass/water interfrace to a plane in the water 
    ng=indices(1); %glass refraction index
    nw=indices(2); %water refraction index

    normal=[0;0;1]; %normal orthogonal to refractive layers 
    zero = [0;0;0]; %assuming the origin is the camera optical center
    %alpha_deg=acos((ray0'*normal)/norm(ray0))*180/3.141592;

    % CREATE GRAPH
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
    surf(Y_P,d0*ones(401,401),X_P) %glass_plane
    surf(Y_P,(d0+d1)*ones(401,401),X_P) %water plane
    plot3(0,0,0,'o','MarkerSize',6,'MarkerFaceColor','#000000') %marking origin
    quiver3(0,-50,0,0,100,0,'--ok') %graphing optical axis
    
    %Setting up color map
    ii=0;
    n=round((((alpha_param(3)-alpha_param(1))/alpha_param(2))+1)*(((phi_param(3)-phi_param(1))/phi_param(2))+1));
    CM=jet(n);
    
    %Calculate & plot rays
    for alpha = alpha_param(1):alpha_param(2):alpha_param(3) %looping through alpha
        r= d0*tan(alpha); 
        for phi = phi_param(1):phi_param(2):phi_param(3) %looping  through phi
            ray0_x=r*cos(phi);
            ray0_y=r*sin(phi);
            ray0=[ray0_x;ray0_y;d0];
    
            %compute ray and graph (output: refPts=[v0;pi;v1;po;v2];)
            raytrace_out=RayTrace(ray0, normal, ng, nw, d0, d1,zero); 
            raytrace_vec=[raytrace_out(1:3)';raytrace_out(4:6)';raytrace_out(7:9)';raytrace_out(10:12)';raytrace_out(13:15)'];

            ray_pi=raytrace_vec(2,:);
            ray_po=raytrace_vec(4,:);
            ray_v2=raytrace_vec(5,:);
    
            p2= ray_po + d2*ray_v2/(ray_v2*normal);%Find p2
            z_scale=norm((p2-ray_po)); %Find the z scale for final water ray
           
            origins=[zero';ray_pi;ray_po]; %origins of vectors
            directions=[ray_pi;(ray_po-ray_pi);z_scale*ray_v2]; %ray length & direction
    
            x_origins=origins(:,1)';
            y_origins=origins(:,3)'; %switch z to y axis
            z_origins=origins(:,2)'; %switch y to z axis
            v_x=directions(:,1)';
            v_y=directions(:,3)';
            v_z=directions(:,2)';
            
            ii= ii +1;
 
            %Trace back water rays
            p_origin=[p2(1),p2(3),p2(2)]; %end of ray in water
            b_dir=[-ray_v2(1),-ray_v2(3),-ray_v2(2)]; %direction of water ray back to origin
            w_scale=10*(d0+d1+d2); %scale for tracing back water ray
            
            %Plot
            if label=='y'
                hold on
                quiver3(x_origins,y_origins,z_origins,v_x,v_y,v_z,0,'color',CM(ii,:),'marker','*') %plot refraction rays
                hold on
                quiver3(p_origin(1),p_origin(2),p_origin(3),w_scale*b_dir(1),w_scale*b_dir(2),w_scale*b_dir(3),0,'color',CM(ii,:)) %plot backtraced rays 
            else
                hold on
                quiver3(x_origins,y_origins,z_origins,v_x,v_y,v_z,0,'-*b') %plot refraction rays
                hold on
                quiver3(p_origin(1),p_origin(2),p_origin(3),w_scale*b_dir(1),w_scale*b_dir(2),w_scale*b_dir(3),0,'-*r') %plot backtraced rays 
            end
        end
    end
end 


