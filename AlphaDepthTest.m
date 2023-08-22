%Function that takes in series of virtual camera coordinates for different alphas and different tests, and plots 
%the z coordinates 

function AlphaDepthTest(depthtestaverages)

    %Create graph
    figure
    xlabel('Alpha (deg)')
    ylabel('Z coordinate of virtual camera')
    title('Z coordinate of virtual camera vs axis')

    [num_depthtestaverages,c]=size(depthtestaverages)

    %For every Alpha, 0 to 60 degrees, up by 10 degrees
    for alphvar=1:7 

        %Extract virtual cam coordinates of each tests for given alpha
        alphadegrees=(alphvar-1)*10;
        alphadepth=TestAlpha(depthtestaverages,alphadegrees);

        for nt=1:num_depthtestaverages %1 to the number of tests 
            zcoordinate=alphadepth(nt,3); %finds corresponding z coordinate give a test # and alpha
    
            %Plot Z coordinate vs alpha
            hold on 
            scatter(alphadegrees,zcoordinate,'filled'); 
            text(alphadegrees,zcoordinate,string(nt)) %plots test # next to point
            %[alphadegrees,zcoordinate]
        end
    end
end