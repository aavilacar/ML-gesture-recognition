function [gest_ch,wl] = endpoint_detection(gest_ch, thr)
%This function detects the main segment of the sEMG signal and sets the rest of the signal to zero. The energy of the
%signal is obtained (by calculating its absolute value) and this energy wave is then transformed into a step function 
%(using the mean values of the wave for each step). The starting and ending points of the signal are then found using 
%different thresholds and the signal is cut at these points

sample_points = length(gest_ch);    %Number of sample points in gest_ch (corresponding to the length of gest_ch)
quantization_step = 125;        %This value is used for 'quantising' the signal later on
gest_ch_quantised = zeros(1, sample_points);    %Pre-allocating size for speed

thr_start = thr*1.875;      %Starting threshold to calculate the starting point
thr_finish = thr*2.25;      %Ending threshold to calculate the ending point

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
%}

%--- Endpoint detection ---%
%Starting point detection
start_point = [];
for counter1=1:1:sample_points      %Looping through all of the points in the sample (from start to end)
    if gest_ch_quantised(counter1) >= thr_start     %If the value of the quantised energy signal point is equal or larger than the starting threshold, the starting point is equal to counter1
        start_point = counter1;     %Starting point is stored in start_point
        break
    end
end

%Ending point detection
finish_point = [];
for counter2=sample_points:-1:1     %Looping through all of the points in the sample (from end to start)
    if gest_ch_quantised(counter2) >= thr_finish    %If the value of the quantised energy signal point is equal or larger than the ending threshold, the ending point is equal to counter2
        finish_point = counter2;    %Ending point is stored in finish_point
        break
    end
end

%Starting point exceptions
%--> If no starting point is detected using the current starting threshold, this threshold is lowered and another 
%    attempt to find the starting point is carried out. 
if isempty(start_point) == 1
    thr_start = thr*1.75;
    for counter1=1:1:sample_points
        if gest_ch_quantised(counter1) >= thr_start
            start_point = counter1;
            break
        end
    end
end
if isempty(start_point) == 1
    thr_start = thr*1.625;
    for counter1=1:1:sample_points
        if gest_ch_quantised(counter1) >= thr_start
            start_point = counter1;
            break
        end
    end
end
if isempty(start_point) == 1
    thr_start = thr*1.5;
    for counter1=1:1:sample_points
        if gest_ch_quantised(counter1) >= thr_start
            start_point = counter1;
            break
        end
    end
end

%Ending point exceptions
%--> If no ending point is detected using the current ending threshold, this threshold is lowered to the current 
%    starting threshold and another attempt to find the ending point is carried out.
if isempty(start_point) == 0 && isempty(finish_point) == 1
    thr_finish = thr_start;
    for counter2=sample_points:-1:1
        if gest_ch_quantised(counter2) >= thr_finish
            finish_point = counter2;
            break
        end
    end
end

%--- Preparing endpoints and gest_ch signal for output ---%
if isempty(start_point) == 0 && isempty(finish_point) == 0  %If the endpoints have been found, the following code is executed
    
    %Decreasing and increasing the starting and ending points, respectively, to account for some of the error associated
    %with quantisation (in order to not loose important information in the signal) 
    start_bias = round(0.125*quantization_step);        %Starting point is decreased by 0.125 × quantisation_step
    finish_bias = round(1.125*quantization_step);       %Ending point is increased by 1.125 × quantisation_step
    start_point = start_point-start_bias;
    finish_point = finish_point+finish_bias;
    if start_point < 1      %If after the adjustment, the starting point is smaller than 1, it is set equal to 1 
        start_point = 1;
    end
    if finish_point > sample_points     %If after the adjustment, the ending point is greater than the total number of sample points, it is set equal to the last sample point  
        finish_point = sample_points;
    end

    %Zeroing the points in the signal outside the endpoints
    gest_ch(1:start_point) = 0;
    gest_ch(finish_point:sample_points) = 0;
    wl = finish_point - (start_point-1);    %Storing the Waveform Length [number of sample points] in wl 
    
elseif isempty(start_point) == 1 && isempty(finish_point) == 1  %If the endpoints have not been found, the following code is executed
    start_point = 1;        %Setting the starting point equal to 1
    finish_point = sample_points;   %Setting the ending point equal to the last sample point 
    
    %Zeroing all the points in the signal
    gest_ch = zeros(1, sample_points);
    wl = 0;     %Storing the Waveform Length [number of sample points] in wl
end

% To output the following data, along with the modified 'gest_ch' signal and WL, uncomment the following code
%{
wl = [wl start_point finish_point thr_start thr_finish];
gest_ch = [gest_ch; gest_ch_quantised];
%}
end

