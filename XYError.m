%Function to graph xy errors based on alpha 
%Desired alpha and phi is in degrees

function XYError(test_variables,desired_alpharange,desired_phirange)

    %Create Graph
    figure
    plot(0,0,'o','MarkerSize',5,'MarkerFaceColor','#000000')
    grid on 
    xlabel('Alpha (deg)')
    ylabel('Error Magnitude (mm)')
    title('Magnitude of XY error assuming known depth')

    [numrows,numcolumns]=size(test_variables)

    starting_alpha=(desired_alpharange(1)/10)+1;
    ending_alpha=(desired_alpharange(2)/10)+1;
    
    starting_phi=(desired_phirange(1)/10)+1;
    ending_phi=(desired_phirange(2)/10)+1;

    for r=1:numrows %For every test
        testname=test_variables{r}; %choosing one test
        
        for alph=starting_alpha:ending_alpha %for every alpha

            %Uncomment to plot each error by x and y coords
                %{
            for p=starting_phi:ending_phi 
                error_vector=testname{alph,p}(6:8); 
                
                hold on 
                scatter(error_vector(1),error_vector(2),'filled') 
                hold on
                text(error_vector(1),error_vector(2),string((alph-1)*10)+" " + string(r)) %or(p-1)*10
            end  
                %}


            %find alpha in degrees
            alphindeg=(alph-1)*10;

            %Extract error vector from test
            error_vector=testname{alph,ending_phi}(6:8); %utilizes end phi. Maybe should average phis instead for case of rotated planes
            
            testnumber=string(r);
            %name=testnumber + ";" + string(alphindeg);

            %calculate magnitude of XY error
            mag_error=norm(error_vector)

            %plot Alpha vs Magnitude of Error
            hold on 
            scatter(alphindeg,mag_error,'filled')
            hold on
            text(alphindeg,mag_error, testnumber)
        end 
    end 
end
