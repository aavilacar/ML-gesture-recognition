%This code displays graphically the process of signal endpoint detection
clear;
load('../Database 2/male_day_3.mat');    %Loading dataset (each row in the matrix corresponds to the data for a sample)
gest_ch_complete = hook_ch1;    %Choosing the gesture and channel to analyse
clearvars -except gest_ch_complete;    %Clearing unused variables

%Setting the threshold to be used for endpoint detection
thr = single(0.0488);
%thr = single(0.0598);

Fs = 500;       %Sampling frequency [Hz]
t = 1/Fs;       %Time step [s]

for n=1:size(gest_ch_complete,1)    %Looping through all of the samples in the dataset and plotting the respective graphs
    clf;
    gest_ch = gest_ch_complete(n,:);
    gest_ch = gest_ch - mean(gest_ch);    %Offset correction
    lines_thr = max(gest_ch)/2;     %lines_thr is used for plotting later on
    
    %Plotting the original signal
    figure(1);
    subplot(2,2,1);
    plot(gest_ch);
    title('Original signal');
    
    %Doing endpoint detection and retrieving all the corresponding relevant variables/values
    [gest_ch, data] = endpoint_detection(gest_ch, thr);
    start_point = data(2);
    finish_point = data(3);
    thr_start = data(4);
    thr_finish = data(5);
    wl = data(1);
    gest_ch_quantised = gest_ch(2,:);
    gest_ch = gest_ch(1,:);
    
    %Plotting the quantised energy signal along with the calculated endpoints and thresholds
    subplot(2,2,2);
    hold on;
    plot(gest_ch_quantised,'k');
    plot(repelem(start_point,3),linspace(0,thr*3,3),'g');
    plot(repelem(finish_point,3),linspace(0,thr*3,3),'r');
    plot(1:length(gest_ch),repelem(thr_start,length(gest_ch)),'c');
    plot(1:length(gest_ch),repelem(thr_finish,length(gest_ch)),'b');    
    hold off;
    legend('Quantised signal','Starting point','Ending point','Starting threshold','Ending threshold');
    title('Quantised energy signal');
    
    %Plotting the signal after enpoint detection along with the calculted endpoints
    subplot(2,2,3);
    hold on;
    plot(gest_ch);  
    plot(repelem(start_point,3),linspace(-lines_thr,lines_thr,3),'g');
    plot(repelem(finish_point,3),linspace(-lines_thr,lines_thr,3),'r');
    hold off;
    legend('Signal','Starting point','Ending point');
    title('Signal after endpoint detection');
    fprintf('%i ',n);
    input('Continue?');
end