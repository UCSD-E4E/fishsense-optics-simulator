%Function to graph xyz errors based on alpha 
%desired alpha and phi is in degrees


function AlphaError(test_variables,desired_alpha,desired_phirange)

    %---------CREATE GRAPH------------
    figure
    %graphing optical axis and origin
    quiver3(0,-100,0,0,500,0,'--ok')
    hold on
    plot3(0,0,0,'o','MarkerSize',5,'MarkerFaceColor','#000000')
    ax= gca;
    ax.ZDir='reverse';
    grid on 
    xlabel('X Axis (mm)')
    ylabel('Z Axis (mm)')
    zlabel('Y Axis (mm)')
    
    view(gca,[0 90 1])

    [numrows,numcolumns]=size(test_variables);

    for r=1:numrows %For every test
        testname=test_variables{r}; %choosing one test
        alphanumber=(desired_alpha/10)+1;
        starting_phi=(desired_phirange(1)/10)+1;
        ending_phi=(desired_phirange(2)/10)+1;

        for p=starting_phi:ending_phi
            error_vector=testname{alphanumber,p}(6:8);
            hold on 
            scatter3(error_vector(1),error_vector(3),error_vector(2),'filled') 
            hold on
            text(error_vector(1),error_vector(3),error_vector(2),string((p-1)*10))
        end              
    end 

end
