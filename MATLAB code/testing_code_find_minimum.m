%This code retrieves the average minumum value of the quantised energy signals for all the signals in a single database
clear; clc;

%--- Database 2 ---%
%Importing and combining Database 2 data
load('../Database 2/male_day_1.mat'); 
gest1_ch1 = hook_ch1; gest1_ch2 = hook_ch2; gest2_ch1 = spher_ch1; gest2_ch2 = spher_ch2;

load('../Database 2/male_day_2.mat'); 
gest1_ch1 = [gest1_ch1; hook_ch1]; gest1_ch2 = [gest1_ch2; hook_ch2];
gest2_ch1 = [gest2_ch1; spher_ch1]; gest2_ch2 = [gest2_ch2; spher_ch2];

load('../Database 2/male_day_3.mat'); 
gest1_ch1 = [gest1_ch1; hook_ch1]; gest1_ch2 = [gest1_ch2; hook_ch2];
gest2_ch1 = [gest2_ch1; spher_ch1]; gest2_ch2 = [gest2_ch2; spher_ch2];

min_gest_ch1 = zeros(size(gest1_ch1,1),2);  %Pre-allocating size for speed
min_gest_ch2 = zeros(size(gest1_ch2,1),2);  %Pre-allocating size for speed

for n=1:size(gest1_ch1,1)
    %Channel 1
    gest1_ch1(n,:) = gest1_ch1(n,:) - mean(gest1_ch1(n,:));    %Offset correction
    min_gest_ch1(n,1) = find_minimum(gest1_ch1(n,:));   %Storing the minimum quantised energy value of Gesture 1 Channel 1 in the first instance of min_gest_ch1 
    gest2_ch1(n,:) = gest2_ch1(n,:) - mean(gest2_ch1(n,:));    %Offset correction
    min_gest_ch1(n,2) = find_minimum(gest2_ch1(n,:));   %Storing the minimum quantised energy value of Gesture 2 Channel 1 in the second instance of min_gest_ch1
    
    %Channel 2
    gest1_ch2(n,:) = gest1_ch2(n,:) - mean(gest1_ch2(n,:));    %Offset correction
    min_gest_ch2(n,1) = find_minimum(gest1_ch2(n,:));   %Storing the minimum quantised energy value of Gesture 2 Channel 1 in the first instance of min_gest_ch2
    gest2_ch2(n,:) = gest2_ch2(n,:) - mean(gest2_ch2(n,:));    %Offset correction
    min_gest_ch2(n,2) = find_minimum(gest2_ch2(n,:));   %Storing the minimum quantised energy value of Gesture 2 Channel 2 in the second instance of min_gest_ch2
end

thr_ch1 = mean(mean(min_gest_ch1))
thr_ch2 = mean(mean(min_gest_ch2))

thr = (thr_ch1 + thr_ch2) / 2