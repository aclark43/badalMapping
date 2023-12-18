function [nvd, bench] = BadalCalculator(dm, g)
% March 15, 2019
% MAC & RW

% CALCULATE:
% dm     = measured distance between LENSES in (mm) -- see measuring instructions below
% g     = measured distance from EYE to DISPLAY (mm)  
% nvd   = the view distance you should enter into EyeRIS to account for magnification changes (mm)
% bench = details of badal calculation

% SETUP:
% Face the flat side of lens to the male connector of the 3 in  tube. Push 
% the lens to the end to the holding tube and lock with lock ring. Mount
% 3 in tube holder on the 2" Dovetail Rail Carriers with post and post
% holder. Place the female side of 3 in tube (with lens) on a flat
% surface. When installing tube holder (with Carriers and holder), move it
% such that the short side of th carriers sit on the flat surface.

% MEASURE: 
% Slide two lens on the rail. The male side of tube should face subjects.
% Alight the far side (reference to subjects) of the carriers of Badel lens 
% to the rail at 50 mm. Move auxiliary lens and read the number on the rail 
% that alight to the far side of the carrier of auxiliary lens. Subtract
% 50mm from this measument to get the input d; 

% For more details, see: 
% Magnificaiton and Ocular Vergence for 2nd Variation of Badal Opotometer
% from Atchison, David A., et al. "Useful variations of the badal optometer." Optometry and vision science: official publication of the American Academy of Optometry 72.4 (1995): 279-284.
% https://www.ncbi.nlm.nih.gov/pubmed/7609955
% pg 283

d1 = 1.80721; % the distance between lens mount to the front principle plane
d2 = 21.2379; % the distance between lens mount to the back principle plane
s = 16.577;  % the distance between the front and back principle planes
f  = 150; % focal length of our lenses (Fb and Fa) in mm
d = dm + d1 + d2 - s; % adjust d to be distance from FRONT PP of Badal and BACK PP of Auxiliary (PP = principal plane)

p1  = g - (f + d + 2 * s); % Distance from Auxiliary lens to monitor.
q1  = 1./(1 / f - 1 ./ p1); % Image after  Auxiliary lens
p2 = d - q1; % Distance from Badal lens to object.
q2 = 1./(1 / f - 1 ./ p2); % Image after  Badal lens
vd = f - q2;
m  = q1 ./ p1 .* q2 ./ p2;

nvd = abs(round(vd/m)); 

bench.lensdist_measured   = dm; 
bench.lensdist_calculated = d; 
bench.vd_real       = g;
bench.vd_virtual    = nvd; 
bench.F_badal       = 1/f/1000; 
bench.F_aux         = 1/f/100; 
bench.magnification = m; 
bench.vergence      = -1/vd*1000; 


%oh = q1 ./ p1 .* q2 ./ p2 * h; 
%va = atan2(oh, vd) / pi * 180;