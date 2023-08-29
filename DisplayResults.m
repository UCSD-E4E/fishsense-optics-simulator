%Plotting the points of closest distances between the backtraced rays and optical axis

function DisplayResults(focalinfo)

    %Find size of input 
    [m,n]=size(focalinfo);%m is the number of alphas, n is the number of phis

    %Create graph
    figure 
    quiver3(0,-50,0,0,10,0,10,'-ok') %optical axis
    hold on
    plot3(0,0,0,'o','MarkerSize',8,'MarkerFaceColor','#000000') %optical center
    set ( gca, 'zdir', 'reverse' )
    xlabel('x axis')
    ylabel('z axis')
    zlabel('y axis')
    xlim([-.15 .15]);
    ylim([.5 .8]);
    zlim([-.151 .151]);

    hold on
    for g=1:m
        for h=1:n
            alphavari=focalinfo{g,h}(1); %alpha
            phivari=focalinfo{g,h}(2); %phi
            vari=focalinfo{g,h}(3); %x coord
            vari2=focalinfo{g,h}(4); %y coord
            vari3=focalinfo{g,h}(5);%z coord
            hold on
            %plot coordinates
            scatter3(vari,vari3,vari2,'filled') 
            text(vari,vari3,vari2,(string(alphavari)+ ", " + string(phivari)))
        end
    end
end