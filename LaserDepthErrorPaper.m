function LaserDepthErrorPaper(layer_normal,layer_thickness,layer_indices,waterdepth_param,laserorigin,laserdir)

    syms var_camray var_laser

    %Extract layer thicknesses from vector
    a_thickness=layer_thickness(1);
    g_thickness=layer_thickness(2);

    %Define parallel, unrotated glass planes
    rotation_matrixparallel=[1,0,0;0,1,0;0,0,1];
    totrotation_matrixparallel=rotation_matrixparallel*rotation_matrixparallel;
    
    %Create Graph
    figure1=figure;
    % Create axes
    axes1 = axes('Parent',figure1);
    hold(axes1,'on');
    grid(axes1,'on');
    hold(axes1,'off');
    view([90 0])
    % Set the remaining axes properties
    set(axes1,'ZDir','reverse');
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    set(gca,'ZTick',[])
    
    zlim(axes1,[-35 5])
    ylim(axes1,[-10 70])
    set(gcf, 'PaperUnits', 'normalized')
    set(gcf, 'PaperPosition', [0 0 1 1])
  
    %Graph interface planes, origin, optical axis and laser
    hold on
    plot3(0,0,0,'o','MarkerSize',5,'MarkerFaceColor','#FF00FF','DisplayName','focal point');
    hold on
    quiver3(0,-50,0,0,1000,0,'--ok','DisplayName','optical axis') 
    hold on
    quiver3(laserorigin(1),laserorigin(3),laserorigin(2),6000*laserdir(1),6000*laserdir(3),6000*laserdir(2),0,'-*r','DisplayName','laser')
    legend('Interpreter','latex')

    %Plotting interfaces
    hold on
    quiver3(0,2,100,0,0,-200,'Color',[0.3010 0.7450 0.9330],'DisplayName','air/acrylic interface')
    hold on
    quiver3(0,11.56,100,0,0,-200,'Color',[0 0.5470 0.5410],'DisplayName','acrylic/water interface')
      
    %For loop for each depth 
    for w=waterdepth_param(1):waterdepth_param(2):waterdepth_param(3)
     
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
       
       %Find estimated error between refracted and unrefracted rays

       %define EQ
       Eq_y=(laserorigin(2)+var_laser*laserdir(2))-(var_camray*vair(2));
       Eq_z=(laserorigin(3)+var_laser*laserdir(3))-(var_camray*vair(3));

       %Find intersection with line 
       [varcam,varlaser]=vpasolve([Eq_y,Eq_z],[var_camray,var_laser]);
        
       %Find difference in depth
       estimation_posfish=simplify(varcam*vair);

       %plot estimated, unrefracted light rays.
       quiver3([0],[0],[0],estimation_posfish(1),estimation_posfish(3),estimation_posfish(2),0,'-k','ShowArrowHead', 'off','DisplayName','estimated ray')
       scatter3(estimation_posfish(1),estimation_posfish(3),estimation_posfish(2),'filled', 'k','DisplayName','$\hat{p}$')
        
       %plot refrfacted (actual) and unrefracted (estimated) light rays 
       hold on 
       quiver3(planeorigins(1,:),planeorigins(3,:),planeorigins(2,:),laser_refractedray_dir(1,:),laser_refractedray_dir(3,:),laser_refractedray_dir(2,:),0,'-b','ShowArrowHead', 'off','DisplayName','actual ray')
       scatter3(laser_posfish(1),laser_posfish(3),laser_posfish(2),'filled','b','DisplayName','$p$')
       hold on 
      
       %plot po
       quiver3([0],[0],[0],ag_intersect(1)*2/3,ag_intersect(3)*2/3,ag_intersect(2)*2/3,0,'-','MaxHeadSize',3,'Color',"#00FF00",'LineWidth',1.5,'DisplayName','$\overrightarrow{op}$');

    end
end