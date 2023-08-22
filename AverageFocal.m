%Function to calculate virtual camera coordinates (averaging among all the phis) 
% per alpha

function [coords]=AverageFocal(foc_information,alphaparam,phiparam)
   %Get # of rays
   size_alpha=floor((alphaparam(3)-alphaparam(1))/alphaparam(2))+1;
   size_phi=floor((phiparam(3)-phiparam(1))/phiparam(2))+1;

   %initialize output matrix
   coords= zeros(size_alpha,4);

   alpha_i=1;

   for a=alphaparam(1):alphaparam(2):alphaparam(3)
       sumx=0;
       sumy=0;
       sumz=0;

       phi_i=1;

        for p=phiparam(1):phiparam(2):phiparam(3)
            %Finding virtual camera coordinates
            sumx=sumx+foc_information{alpha_i,phi_i}(3);
            sumy=sumy+foc_information{alpha_i,phi_i}(4);
            sumz=sumz+foc_information{alpha_i,phi_i}(5);
            phi_i=phi_i+1;
        end

        %Output matrix: [alpha, x coordinate, y, z]; each row is a
        %different alpha
         coords(alpha_i,1)=a*180/pi;
         coords(alpha_i,2)=sumx/size_phi;
         coords(alpha_i,3)=sumy/size_phi;
         coords(alpha_i,4)=sumz/size_phi;

         alpha_i=alpha_i+1;
   end
end

