function [ssc] = slope_sign_changes(gest_ch)
%This function calculates the Slope Sign Changes (SSC) of the samples (i.e. how many times the gradient of the signal
%changes between 0, +ve and -ve)

samples = size(gest_ch,1);      %Number of samples in gest_ch (corresponding to the number of rows in the matrix)

%Calculating the SSC
ssc = single(zeros(samples,1));     %Pre-allocating size for speed
for n=1:samples             %Looping through all of the samples and storing their SSC values in ssc
    gradient_signs = sign(gradient(gest_ch(n,:)));    %Getting the sign of the gradient for each sample point
    previous = gradient_signs(1);       %previous and counter are used in the for loop to get the SSC
    counter = 0;
    for m=2:length(gradient_signs)      %Looping through gradient_signs and counting the number of times the values change
        current = gradient_signs(m);
        if previous ~= current
            counter = counter + 1;      %Storing the SSC in counter
        end
        previous = gradient_signs(m);
    end
    ssc(n,1) = counter;
end
end

% Using diff function to get the gradient by forward differences [dx(i)= x(i+1)-x(i)] - Gives different values
%gradient_signs = sign(diff(gest_ch(n,:)));    %Getting the sign of the gradient for each sample point
