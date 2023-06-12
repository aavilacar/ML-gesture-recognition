function [wl] = waveform_length(wl_gest_ch)
%This function calculates the Waveform Length (WL) of the samples (i.e. the time width of the signal) in seconds

samples = length(wl_gest_ch);      %Number of samples in wl_gest_ch (corresponding to the number of rows in the matrix)
fs = 500;       %Sampling frequency [Hz]
t = 1/fs;       %Time step [s]

%Calculating the WL (in seconds)
wl = single(zeros(samples,1));     %Pre-allocating size for speed
for n=1:samples            %Looping through all of the samples and storing their WL (in seconds) in wl
    wl(n,1) = wl_gest_ch(n) * t;
end
end

