%Equations marked by [1] are taken from [1]

% [1] A. Agrawal, S. Ramalingam, Y. Taguchi and V. Chari, "A theory of multi-layer flat refractive geometry," 
% 2012 IEEE Conference on Computer Vision and Pattern Recognition, 
% Providence, RI, USA, 2012, pp. 3346-3353, doi: 10.1109/CVPR.2012.6248073.

function [v_glass, v_water, glass_intercept, water_intercept] = pathfinder(origin, v_air, mu_air, d_air, d_glass, mu_glass, mu_water, n)

% Takes in an origin point, the location of the camera sensor, the initial
% air vector, the refractive index of air (mu_air), and the distance
% between the origin and the glass plane, the distance between the glass
% plane and the water, the refractive index of glassa (mu_glass), and also
% the normal line

% Outputs the glass vector, water vector, and the two intercepts along the
% glass and water planes.

% Make all input vectors unit vectors

v_air = v_air / norm(v_air);
n = n / norm(n);

% Make sure all input vectors are vertical

shape_v_air = size(v_air);
if shape_v_air(2) ~= 1
    v_air = v_air';
end

shape_n = size(n);
if shape_n(2) ~= 1
     n = n';
end

shape_origin = size(origin);
if shape_origin(2) ~= 1
     origin = origin';
end

% Use the similar triangle law to find the length of v_air as a scalar

h_air = d_air / (v_air' * n);

% use the scaled v_air vector in order to get the interception between the
% ray and the glass plane

glass_intercept = h_air*v_air + origin;

% Use Snell's law to get refracted ray (EQUATION 1)
n=-n; %Normal for snells law defined in -Z direction
a_glass = mu_air/mu_glass; %[1]
b_glass = -mu_air*v_air'*n; %[1]
b_glass = b_glass - sqrt(mu_air^2*(v_air'*n)^2 - (mu_air^2-mu_glass^2)*(v_air'*v_air)); %[1]
b_glass = b_glass/mu_glass; %[1]

v_glass = a_glass * v_air + b_glass * n; %[1]

% Make sure that v_glass is a unit vector
v_glass = v_glass / norm(v_glass);

% Use the similar triangle law to find the length of v_glass as a scalar
n=-n;
h_glass = d_glass / (v_glass' * n);

% use the scaled v_glass vector in order to get the interception between the
% ray and the water plane

water_intercept = h_glass*v_glass + glass_intercept;


% Use Snell's law to get refracted ray 
n=-n; 
a_water = mu_glass/mu_water; %[1]
b_water = -mu_glass*v_glass'*n; %[1]
b_water = b_water - sqrt(mu_glass^2*(v_glass'*n)^2 - (mu_glass^2-mu_water^2)*(v_glass'*v_glass)); %[1]
b_water = b_water/mu_water; %[1]

v_water = a_water * v_glass + b_water * n; %[1]

% Make sure that v_glass is a unit vector
v_water = v_water / norm(v_water);

end 