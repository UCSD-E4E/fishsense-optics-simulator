# fishsense-optics-simulator

**Purpose**
The purpose of this program is to simulate the refraction of light rays underwater through a flat port.   

GraphRays2.m takes in parameters relating to a physical camera and environmental conditions, and plots the refraction of the rays “exiting” a pinhole camera, as well as the projection of the rays in the water back towards the optical axis (without refraction). All distances are measured in mm, and angles in radians. This model assumes that the chosen optical axis (defined as [0;0;1])  is normal to all refractive layers.  

**Function Parameters**  
_GraphRays2 (normal,dist,indices,lim,alpha_param,phi_param,label)_  

normal = [0;0;1]   
- With the current code, normal should always be specified as a vector in this direction.
  
dist = [d1,d2,d3], where   
- d1 = distance from optical center to glass  
- d2= thickness of glass  
- d3 = distance from glass/water interface to a specified distance  

indices = [i_glass,i_water], where   
- i_glass = index of refraction of glass  
- i_water = index of refraction of water  

lim= limit of the axes  
- The X and Y axis are plotted from [-lim,lim], and the Z axis from [-lim/8, lim].  

alpha_param= [alpha_start,alpha_step,alpha_end], where    
- alpha_start = starting alpha angle  
- alpha_step = step size  
- alpha_end = final alpha angle  
- Alpha is the angle between the in-air ray and the optical axis.   

phi_param = [phi_start, phi_step,phi_end]  
- same as alpha_param, but for phi. Phi is the angle of the in-air light ray  measured counterclockwise about the positive z axis, starting from the positive x axis   

label = ‘y’ or ‘n’.   
- ‘y’ is used to match the refracted ray to its corresponding backtraced ray by graphing them with the same color  
- ‘n’ makes the refracted rays blue and backtraced rays red  

**References**  
[1] A. Agrawal, S. Ramalingam, Y. Taguchi and V. Chari, "A theory of multi-layer flat refractive geometry," 2012 IEEE Conference on Computer Vision and Pattern Recognition, 
 Providence, RI, USA, 2012, pp. 3346-3353, doi: 10.1109/CVPR.2012.6248073.  
  
[2] Łuczyński, Tomasz & Pfingsthorn, Max & Birk, Andreas. (2017). The Pinax-model for accurate and efficient refraction correction of underwater cameras in flat-pane housings. Ocean Engineering. 133. 9-22. 10.1016/j.oceaneng.2017.01.029.   
