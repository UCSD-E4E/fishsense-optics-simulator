%Function to find the virtual cam coordinates of a desired alpha for a series of
%tests 

function [averagesmatrix]= TestAlpha(avg_variables,desired_alpha)
     
     %Create Graph
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
     xlim([-.15 .15]);
     ylim([.5 .8]);
     zlim([-.151 .151]);
     %}
     
     [numtests,numcolumns]=size(avg_variables);
     alphanumber=(desired_alpha/10)+1;

     %Initialize matrix with #tests as #rows and xyz coordinates of virtual cam and test # as columns
     averagesmatrix=zeros(numtests,4); 

     for r=1:numtests %For every test
        avgtestname=avg_variables{r}; %choosing one test

        %Extracting virtual cam coordinate for that test and alpha
        alpha_avgx=avgtestname(alphanumber,2);
        alpha_avgy=avgtestname(alphanumber,3);
        alpha_avgz=avgtestname(alphanumber,4);
        averagesmatrix(r,:)=[alpha_avgx,alpha_avgy,alpha_avgz,r];

        
        %Plot virtual cam coordinates
        hold on 
        scatter3(alpha_avgx,alpha_avgz,alpha_avgy,'filled') 
        hold on
        text(alpha_avgx,alpha_avgz,alpha_avgy,string(r)) 
        %}

     end
end


    

