%Function to graph xy errors based on alpha 
%Desired alpha and phi is in degrees

function XYError(test_variables,desired_alpharange,desired_phirange)

    %Create Graph
    figure
    grid on 
    xlabel('Distance of point from image sensor center (pixels)')
    ylabel('Error Magnitude (mm)')
    title('Error vs. distance from center point')
    xlim([0 2000]);


    [numrows,numcolumns]=size(test_variables)

    starting_alpha=(desired_alpharange(1)/10)+1;
    ending_alpha=(desired_alpharange(2)/10)+1;
    
    starting_phi=(desired_phirange(1)/10)+1;
    ending_phi=(desired_phirange(2)/10)+1;

    for r=1:numrows %For every test
        testname=test_variables{r}; %choosing one test

        if r==1
            depth_num=.5;
        elseif r==2
            depth_num=1;
        elseif r==3
            depth_num=2;
        elseif r==4
            depth_num=3;
        elseif r==5
            depth_num=4;
        elseif r==6
            depth_num=5;
        end
        
        alphasvec=zeros(1,ending_alpha);
        errvec=zeros(1,ending_alpha);

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
            error_vector=testname{alph,ending_phi}(6:8); %utilizes end phi. Maybe should average phis instead for case of rotated planes, or use 90 deg
            
            %Extract image sensor pixels 
            pixel_nums=testname{alph,ending_phi}(9:10);
            pixel_mag=testname{alph,ending_phi}(11);
           
            testnumber=string(r);
            %name=testnumber + ";" + string(alphindeg);

            %calculate magnitude of XY error
            mag_error=norm(error_vector);

            alphasvec(alph)=pixel_mag;
            errvec(alph)=mag_error;

        end 
         hold on 
         plot(alphasvec,errvec,'-o','DisplayName',string(depth_num)+ ' ' + 'meters')
         legend
    end 
end
