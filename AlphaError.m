%Function to graph xyz errors of one alpha for various test conditions
%Desired alpha and phi is in degrees

function AlphaError(test_variables,desired_alpha,desired_phirange)

    %Create graph
    figure
    hold on
    grid on 
    xlabel('X Error (mm)')
    ylabel('Y Error (mm)')
    axis equal

    [numrows,numcolumns]=size(test_variables);

    for r=1:numrows %For every test
        testname=test_variables{r}; 

        alphanumber=(desired_alpha/10)+1;
        starting_phi=(desired_phirange(1)/10)+1;
        ending_phi=(desired_phirange(2)/10)+1;

        for p=starting_phi:ending_phi
            error_vector=testname{alphanumber,p}(6:8);
            hold on 
            scatter(error_vector(1),error_vector(2),'filled') 
            hold on
            text(error_vector(1),error_vector(2),string((p-1)*10))
        end              
    end 

end
