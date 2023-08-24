function Plot_Percent_Error(lasertests_err)


    figure
    title('% Error in Length & Depth according to laser parameters and depth')
    grid on 
    [r,u]=size(laser_errtests);
    
    
    for i = 1:11:r
        test_lasererror=laser_errtests(i:i+10,1:5)
      
        o_param=(laser_originv(:,((i+10)/11)))';
        d_param=(laser_dirv(:,((i+10)/11)))';
        vair_angle=test_lasererror(11,4); %finding the  vair alpha for depth of 2 m
        vair_pangle=test_lasererror(11,5); %finding the  vair phi  for depth of 2 m
    
        plot_x=test_lasererror(:,1);
        plot_y=test_lasererror(:,3);
    
        hold on
        %+ string(mat2str(d_param))+ ' ' +
        scatter(plot_x,plot_y,'filled','DisplayName','origin: ' + string(norm(o_param)) +' alpha:' + string(vair_angle)+ char(176)+ ' phi:' + string(vair_pangle)+char(176))
        legend
    end
end