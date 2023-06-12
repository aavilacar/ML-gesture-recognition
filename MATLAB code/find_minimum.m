function [min_gest_ch] = find_minimum(gest_ch)
%This function calculates the minumum value of a signal after being quantised

sample_points = length(gest_ch);    %Number of sample points in gest_ch (corresponding to the length of gest_ch)
quantization_step = 125;        %This value is used for 'quantising' the signal later on
gest_ch_quantised = zeros(1, sample_points);    %Pre-allocating size for speed;

%--- Getting the quantised energy signal ---%
%First half of the signal is quantised using the quantisation_step set earlier.
%--> Every 125 points, the MAV of these points is calculated and all of these points are set to this MAV value 
for n=1:quantization_step:(1/2)*sample_points
    gest_ch_quantised(n:n+(quantization_step-1)) = mean(abs(gest_ch(n:n+(quantization_step-1)))); 
end

%Third quarter of the signal is quantised using the quantisation_step × 2.
%--> Every 250 points, the MAV of these points is calculated and all of these points are set to this MAV value 
for m=(1/2)*sample_points+1:quantization_step*2:(3/4)*sample_points
    gest_ch_quantised(m:m+(quantization_step*2-1)) = mean(abs(gest_ch(m:m+(quantization_step*2-1))));
    last_quantisation_point = m;
end

%Last quarter of the signal is quantised all at once 
%--> The MAV of the remaining last points is calculated and all of these points are set to this MAV value.
gest_ch_quantised(last_quantisation_point:sample_points) = mean(abs(gest_ch(last_quantisation_point:sample_points)));
   
%Retrieving minimum value
min_gest_ch = min(gest_ch_quantised);
end
