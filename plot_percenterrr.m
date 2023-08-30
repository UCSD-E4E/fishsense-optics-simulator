%Function that takes in some LaserDepthError and plots the %Error in length
%& Depth according to laser parameters and depth 

%Both a scatter and box plot option. Choose one and comment the other
%out.

%Scatter Plot:
%%{

%Parameters: 
%laser_errtests=[laser_error2;laser_error3;laser_error4;laser_error5;laser_error6;laser_error7;laser_err2;laser_err6];
laser_errtests=[laser_err2];

laser_originv=[laser_origin2,laser_origin3,laser_origin4,laser_origin5,laser_origin6,laser_origin7,pool_lo,dive_lo];
laser_dirv=[laser_dir2,laser_dir3,laser_dir4,laser_dir5,laser_dir6,laser_dir7,pool_ld,dive_ld];

figure
title('% Error in Length & Depth according to laser parameters and depth')
xlabel('Depth (mm)')
ylabel('Percent Error')
grid on 
[r,u]=size(laser_errtests);


for i = 1:11:r
    test_lasererror=laser_errtests(i:i+10,1:5);
  
    o_param=(laser_originv(:,((i+10)/11)))';
    d_param=(laser_dirv(:,((i+10)/11)))';
    vair_angle=test_lasererror(11,4); %finding the  vair alpha for depth of 2 m
    vair_pangle=test_lasererror(11,5); %finding the  vair phi  for depth of 2 m

    plot_x=test_lasererror(:,1);
    plot_y=test_lasererror(:,3);

    hold on
    %+ string(mat2str(d_param))+ ' ' +
    %scatter(plot_x,plot_y,'filled','DisplayName','origin: ' + string(norm(o_param)) +' alpha:' + string(vair_angle)+ char(176)+ ' phi:' + string(vair_pangle)+char(176))
    scatter(plot_x,plot_y,'filled','DisplayName','Laser #' + string((i+10)/11))
    legend

end


%Box Plot
%{
%Parameters
laser_errtest=[laser_error2';laser_error3';laser_error4';laser_error5';laser_error6';laser_error7';laser_err2';laser_err6'];

[r,u]=size(laser_errtest) 

%Initializing a matrix with the # rows of being #tests and each column a different depth
box_matrix=zeros((r/5),u); 

a_var=0;

for i = 3:5:(r-2)
   
    a_var=a_var+1;

   for c = 1:u
        box_matrix(a_var,c)=laser_errtest(i,c);
   end
   
end

%Plot Figure
figure 
hold on

boxplot(box_matrix)

xticklabels({'0.5','1.0','1.5','2.0','2.5','3.0','3.5','4.0','4.5','5','5.5'})
xlabel('Actual Depth (m)','Interpreter','latex')
title('Percent Error in Depth Estimation vs Actual Depth','Interpreter','latex')
ylabel('\% Error in Depth','Interpreter','latex')
grid on

xaxisproperties= get(gca, 'XAxis');
xaxisproperties.TickLabelInterpreter = 'latex'; % latex for x-axis
yaxisproperties= get(gca, 'YAxis');
yaxisproperties.TickLabelInterpreter = 'latex';   % tex for y-axis

%}