function [gest_ch, wl] = pre_processing(gest_ch, thr)
%This function pre-processes the sEMG signals before their features are extracted. It does this through offset
%correction and endpoint detection

samples = size(gest_ch,1);      %Number of samples in gest_ch (corresponding to the number of rows in the matrix)

%Calculating the WL
wl = single(zeros(samples,1));     %Pre-allocating size for speed

for n=1:samples
    %Offset correction - Offset in the signal is removed
    gest_ch(n,:) = gest_ch(n,:) - mean(gest_ch(n,:));
    
    %Endpoint detection - Main segment of the signal is retrieved along with its corresponding Waveform Length using
    %the set threshold value
    [gest_ch(n,:),wl(n,1)] = endpoint_detection(gest_ch(n,:), thr);
end

end