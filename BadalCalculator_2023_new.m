function [nvd, bench] = BadalCalculator(dm, g)
% -- Oct, 9, 2023, correct dm, dm is the distiance from the front carrier of the badal lens and the front carreir of the auxiliary lens
% -- Sep 24, 2023
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
% Alight the fornt/near side (reference to subjects) of the carriers of Badel lens 
% to the rail. Move auxiliary lens and read the number on the rail 
% that alight to the fornt/near side of the carrier of auxiliary lens.

% For more details, see: 
% Magnificaiton and Ocular Vergence for 2nd Variation of Badal Opotometer
% from Atchison, David A., et al. "Useful variations of the badal optometer." Optometry and vision science: official publication of the American Academy of Optometry 72.4 (1995): 279-284.
% https://www.ncbi.nlm.nih.gov/pubmed/7609955
% pg 283

% First-order specification of single doublet pair
EFL = 152.5170;                             % effective focal length
BFL = 138.7224;                             % back focal length 
FFL = 146.2802;                             % front focal length 
THI = 30.9782;                              % the distance between the front and back surface of the doublet
                                            % 2 * (8.4 + 7) + 0.1782
MIN_DIST = 52;                              % the minimum distance between two doublet pair lens. The lens mount(carrier) will touch with each other.
WIDTH_FIRST_CARRIER = 25.4                  % the width of Thorlab's RC1 dovetail rail carrier
                                            % https://www.thorlabs.com/thorproduct.cfm?partnumber=RC1
d = dm + MIN_DIST - WIDTH_FIRST_CARRIER;    % true distace between two doublet pair lens


p1 = g - (d + 2 * (THI + BFL) - EFL); 	% Distance from Auxiliary lens to monitor.
q1  = 1./(1 / EFL - 1 ./ p1);     		% Image after  Auxiliary lens
p2 = d + 2 * (EFL - FFL) - q1; 		    % Distance from Badal lens to object.
q2 = 1./(1 / EFL - 1 ./ p2); 			% Image after  Badal lens
m  = q1 ./ p1 .* q2 ./ p2;

vd = EFL - q2;
nvd = abs(round(vd/m)); 

bench.lensdist_measured   = dm; 
bench.lensdist_calculated = d;
bench.vd_real       = g;
bench.vd_virtual    = nvd; 
bench.F_badal       = 1000 / EFL; 
bench.F_aux         = 1000 / EFL; 
bench.magnification = m; 
bench.vergence      = -1000 / vd; 


%oh = q1 ./ p1 .* q2 ./ p2 * h; 
%va = atan2(oh, vd) / pi * 180;