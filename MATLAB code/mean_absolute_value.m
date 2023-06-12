function [mav] = mean_absolute_value(gest_ch, wl_gest_ch)
%This function calculates the Mean Absolute Value (MAV) of the samples

if size(gest_ch,1) ~= length(wl_gest_ch)
    disp('Channel and Waveform Length arrays are not the same size')
else
    samples = size(gest_ch,1);      %Number of samples in gest_ch (corresponding to the number of rows in the matrix)
end

%Calculating the MAV
mav = single(zeros(samples,1));     %Pre-allocating size for speed
for n=1:samples             %Looping through all of the samples and storing their MAV in mav
    if wl_gest_ch(n) ~= 0
        sum = 0;
        for m=1:length(gest_ch(n,:))
            sum = sum + abs(gest_ch(n,m));      %Getting the sum of the absolute values of all the points in the signal
        end
        mav(n,1) = sum / wl_gest_ch(n);     %Dividing by the number of sample points to get the MAV
    else
        mav(n,1) = 0;   
    end
end
end

% Using MATLAB's sum function to get the sum of the array - Gives different values
%mav(n,1) = sum(abs(gest_ch(n,:))) / wl_gest_ch(n);