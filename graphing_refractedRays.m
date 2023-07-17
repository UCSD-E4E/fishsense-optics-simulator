%Code to graph light rays refracting through glass & water 

%Defining paramters
d0=2; %distance from camera optical center to glass
d1=12.7; %glass thickness in mm
d2=200; %distance from glass/water interfrace to a plane in the water [ARBITRARY]
ng=1.492; %glass refraction index
nw=1.345; %water refraction index

normal=[0;0;1]; %normal orthogonal to refractive layers 
zero = [0;0;0]; %assuming the origin is the camera optical center
%alpha_deg=acos((ray0'*normal)/norm(ray0))*180/3.141592;

%--------------------------------------------------------
% CREATE GRAPH
figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'on');

lim=40; %axis limit 

zlabel({'Y axis'});
ylabel({'Z axis'});
xlabel({'X axis'});
xlim(axes1,[-lim lim]); %X axis
ylim(axes1,[-lim/8 lim]); %Z axis
zlim(axes1,[-lim lim]); %Y axis
view(axes1,[-2.49999966363044 5.57626448632205]);
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
%--------------------------------------------------------------

for alpha = (2*pi/180):(2*pi/180):(pi*1/3) %looping through alphas
    r= d0*tan(alpha); 
    for phi = pi/2:pi:(pi*3/2) %looping  through phis
        ray0_x=r*cos(phi);
        ray0_y=r*sin(phi);
        ray0=[ray0_x;ray0_y;d0];

        %compute ray and graph (output: refPts=[v0;pi;v1;po;v2];)
        raytrace_vec=RayTrace(ray0, normal, ng, nw, d0, d1,zero); 
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

        %Plot
        hold on
        %Trace back water rays
        p_origin=[p2(1),p2(3),p2(2)]; %end of ray in water
        b_dir=[-ray_v2(1),-ray_v2(3),-ray_v2(2)]; %direction of water ray back to origin
        w_scale=10*(d0+d1+d2); %scale for tracing back water ray
        
        quiver3(x_origins,y_origins,z_origins,v_x,v_y,v_z,0,'-*b') %plot refraction rays
        hold on
        quiver3(p_origin(1),p_origin(2),p_origin(3),w_scale*b_dir(1),w_scale*b_dir(2),w_scale*b_dir(3),0,'-*r') %plot backtraced rays
    end
end













