# fishsense-optics-simulator

The purpose of this program is to simulate the refraction of light rays underwater through a flat port. All distances are measured in mm, and angles in radians. 

**GraphRays3.m** takes in parameters relating to a physical camera and environmental conditions, and plots the refraction of the rays “exiting” a pinhole camera, as well as the projection of the rays in the water back towards the optical axis, without refraction (I'm referring to these rays as "backtraced rays" going forward ). It also keeps track of the closest distance of the backtraced rays to the optical axis. 

**DisplayResults.m** plots the point of closest distance for each backtraced ray from the optical axis, and labels each point with the alpha and phi parameters.

**FindIntersection.m** is a helper function that calculates the intersection of each ray to each interface, as well as the closest distance between the backtraced ray to the optical axis. 

**FindLaserDepthError.m** plots the path of a laser at a given position and direction, and its refraction as the reflected beam travels back torwards the camera. 

**Function Parameters**  
_GraphRays3 (rotation1,rotation2,thickness,indices,lim,alpha_param,phi_param,color,label)_ 
_FindLaserDepthError(rotation1,rotation2,thickness,indices,laser_origin,laser_dir)_

rotation1 = [rotationy,rotationx]   
- Describes the rotation of the air/glass interface about the y axis, then the x axis.
  
rotation2 = [rotationy,rotationx]
- Describes the rotation of the glass/water interface about the y axis, then the x axis.
  
dist = [d1,d2,d3], where   
- d1 = distance from optical center to intersection of optical axis to the air/glass interface  
- d2= thickness of glass, measured from the interface intersections with the optical axis
- d3 = distance from the intersection of the optical axis and glass/water interface to a specified distance  

indices = [i_air,i_glass,i_water], where   
- i_air = index of refraction of air
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

color = ‘y’ or ‘n’.   
- ‘y’ is used to match the refracted ray to its corresponding backtraced ray by graphing them with the same color  
- ‘n’ makes the refracted rays blue and backtraced rays red

label = 'y' or 'n'
- 'y' labels the corresponding alpha angles to each ray

laserorigin = [laserx;lasery;laserz]
- Contains the coordinates of the laser origin

laserdir = [laser_dirx;laser_diry;laser_dirz]
- Contains the directional coordinates of the laser (unit vector)

**References**  
[1] A. Agrawal, S. Ramalingam, Y. Taguchi and V. Chari, "A theory of multi-layer flat refractive geometry," 2012 IEEE Conference on Computer Vision and Pattern Recognition, 
 Providence, RI, USA, 2012, pp. 3346-3353, doi: 10.1109/CVPR.2012.6248073.  
  
[2] Łuczyński, Tomasz & Pfingsthorn, Max & Birk, Andreas. (2017). The Pinax-model for accurate and efficient refraction correction of underwater cameras in flat-pane housings. Ocean Engineering. 133. 9-22. 10.1016/j.oceaneng.2017.01.029.   
