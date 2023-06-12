clear; clc;
%This code will extract the time domain features from recorded sEMG signals and appropriately format them to be exported
%into the main ML code

%This threshold is used in the pre-processing of the signals later on
thr = single(0.0598);
%thr = single(0.0488);

%--- Database 1 ---%
%Importing and combining Database 1 data
load('../Database 1/female_1.mat'); 
gest1_ch1 = hook_ch1; gest1_ch2 = hook_ch2; gest2_ch1 = spher_ch1; gest2_ch2 = spher_ch2;

load('../Database 1/female_2.mat'); 
gest1_ch1 = [gest1_ch1; hook_ch1]; gest1_ch2 = [gest1_ch2; hook_ch2];
gest2_ch1 = [gest2_ch1; spher_ch1]; gest2_ch2 = [gest2_ch2; spher_ch2];

load('../Database 1/female_3.mat')
gest1_ch1 = [gest1_ch1; hook_ch1]; gest1_ch2 = [gest1_ch2; hook_ch2];
gest2_ch1 = [gest2_ch1; spher_ch1]; gest2_ch2 = [gest2_ch2; spher_ch2];

load('../Database 1/male_1.mat')
gest1_ch1 = [gest1_ch1; hook_ch1]; gest1_ch2 = [gest1_ch2; hook_ch2];
gest2_ch1 = [gest2_ch1; spher_ch1]; gest2_ch2 = [gest2_ch2; spher_ch2];

load('../Database 1/male_2.mat')
gest1_ch1 = [gest1_ch1; hook_ch1]; gest1_ch2 = [gest1_ch2; hook_ch2];
gest2_ch1 = [gest2_ch1; spher_ch1]; gest2_ch2 = [gest2_ch2; spher_ch2];

%Turning data into 'single' data type
gest1_ch1 = single(gest1_ch1); gest1_ch2 = single(gest1_ch2);
gest2_ch1 = single(gest2_ch1); gest2_ch2 = single(gest2_ch2);

%Clearing unused variables
clearvars -except thr gest1_ch1 gest1_ch2 gest2_ch1 gest2_ch2;

%Pre-processing samples from Database 1
if size(gest1_ch1,1) ~= size(gest1_ch2,1)   %Gesture 1
    disp('Channel 1 and Channel 2 sample size does not match for Gesture 1');
else
    [gest1_ch1, wl_gest1_ch1] = pre_processing(gest1_ch1, thr);
    [gest1_ch2, wl_gest1_ch2] = pre_processing(gest1_ch2, thr);
end
if size(gest2_ch1,1) ~= size(gest2_ch2,1)   %Gesture 2
    disp('Channel 1 and Channel 2 sample size does not match for Gesture 2');
else
    [gest2_ch1, wl_gest2_ch1] = pre_processing(gest2_ch1, thr);
    [gest2_ch2, wl_gest2_ch2] = pre_processing(gest2_ch2, thr);
end

%Extracting features from Database 1 
data_gest1 = feature_function(gest1_ch1, gest1_ch2, wl_gest1_ch1, wl_gest1_ch2);
data_gest2 = feature_function(gest2_ch1, gest2_ch2, wl_gest2_ch1, wl_gest2_ch2);
%}

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

%Turning data into 'single' data type
gest1_ch1 = single(gest1_ch1); gest1_ch2 = single(gest1_ch2);
gest2_ch1 = single(gest2_ch1); gest2_ch2 = single(gest2_ch2);

%Clearing unused variables
clearvars -except data_gest1 data_gest2 thr gest1_ch1 gest1_ch2 gest2_ch1 gest2_ch2;

%Pre-processing samples from Database 2
if size(gest1_ch1,1) ~= size(gest1_ch2,1)   %Gesture 1
    disp('Channel 1 and Channel 2 sample size does not match for Gesture 1');
else
    [gest1_ch1, wl_gest1_ch1] = pre_processing(gest1_ch1, thr);
    [gest1_ch2, wl_gest1_ch2] = pre_processing(gest1_ch2, thr);
end
if size(gest2_ch1,1) ~= size(gest2_ch2,1)   %Gesture 2
    disp('Channel 1 and Channel 2 sample size does not match for Gesture 2');
else
    [gest2_ch1, wl_gest2_ch1] = pre_processing(gest2_ch1, thr);
    [gest2_ch2, wl_gest2_ch2] = pre_processing(gest2_ch2, thr);
end

%Extracting features from Database 2
% data_gest1 = feature_function(gest1_ch1, gest1_ch2, wl_gest1_ch1, wl_gest1_ch2);
% data_gest2 = feature_function(gest2_ch1, gest2_ch2, wl_gest1_ch1, wl_gest1_ch2);
data_gest1 = [data_gest1; feature_function(gest1_ch1, gest1_ch2, wl_gest1_ch1, wl_gest1_ch2)];
data_gest2 = [data_gest2; feature_function(gest2_ch1, gest2_ch2, wl_gest2_ch1, wl_gest2_ch2)];
%}

%-- Mixing the data from all the different datasets equally
data_gest1 = mix_dataset(data_gest1);
data_gest2 = mix_dataset(data_gest2);

%--- Exporting the data ---%
%Exporting the data as .txt files, which will be saved in the current directory
writematrix(data_gest1,'gest1.txt','Delimiter','space');
writematrix(data_gest2,'gest2.txt','Delimiter','space');

%Exporting data from only one sample, to use on Arduino
index1 = 1;
index2 = 2;
writematrix(gest1_ch1(index1,:),'sample1.txt','Delimiter','comma');
writematrix(gest1_ch2(index1,:),'sample2.txt','Delimiter','comma');
writematrix(data_gest1(index2,:),'sample_features.txt','Delimiter','comma');
writematrix([wl_gest1_ch1(index1), wl_gest1_ch2(index1)],'sample_wl.txt','Delimiter','comma');
