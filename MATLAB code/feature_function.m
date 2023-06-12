function [data_gest] = feature_function(gest_ch1, gest_ch2, wl_gest_ch1, wl_gest_ch2)
%This function extracts the features for all of the samples in the data set (using the pre-defined functions) and puts 
%them together into a matrix (where each row of the matrix contains the features for each sample)

%--- Time domain features ---%
%Feature 1 - Mean Absolute Value (MAV)
mav_gest_ch1 = mean_absolute_value(gest_ch1, wl_gest_ch1);
mav_gest_ch2 = mean_absolute_value(gest_ch2, wl_gest_ch2);

%Feature 2 - Zero Crossings (ZC)
zc_gest_ch1 = zero_crossings(gest_ch1);
zc_gest_ch2 = zero_crossings(gest_ch2);

%Feature 3 - Slope Sign Changes (SSC)
ssc_gest_ch1 = slope_sign_changes(gest_ch1);
ssc_gest_ch2 = slope_sign_changes(gest_ch2);

%Feature 4 - Waveform Length (WL) (in seconds)
%wl_gest_ch1_s = waveform_length(wl_gest_ch1);
%wl_gest_ch2_s = waveform_length(wl_gest_ch2);


%--- Combining the data ---%
%Combining the data from each channel
data_gest_ch1 = [mav_gest_ch1 zc_gest_ch1 ssc_gest_ch1]; %wl_gest_ch1_s];
data_gest_ch2 = [mav_gest_ch2 zc_gest_ch2 ssc_gest_ch2]; %wl_gest_ch2_s];

%Combining the Channel 1 and Channel 2 data into one
data_gest = [data_gest_ch1 data_gest_ch2];
end

