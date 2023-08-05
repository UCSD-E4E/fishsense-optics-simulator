%Plotting the points of closest distances between the backtraced rays and optical axis

function DisplayResults(focalinfo)

    %Plot radial distance vs alpha
    [m,n]=size(focalinfo);

    figure 

    %graphing optical axis
    quiver3(0,-50,0,0,10,0,10,'-ok') 
    hold on
    plot3(0,0,0,'o','MarkerSize',8,'MarkerFaceColor','#000000') 
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
            alphavari=focalinfo{g,h}(1);
            betavari=focalinfo{g,h}(2);
            vari=focalinfo{g,h}(3); %x
            vari2=focalinfo{g,h}(4); %y
            vari3=focalinfo{g,h}(5);%z

            hold on

            scatter3(vari,vari3,vari2,'filled') 
            text(vari,vari3,vari2,(string(alphavari)+ " " + string(betavari)))
        end
    end
end