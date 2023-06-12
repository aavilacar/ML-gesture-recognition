function [zc] = zero_crossings(gest_ch)
%This function calculates the Zero Crossings (ZC) of the samples (i.e. how many times the signal crosses the time axis)

samples = size(gest_ch,1);      %Number of samples in gest_ch (corresponding to the number of rows in the matrix)

%Calculating the ZC
zc = single(zeros(samples,1));     %Pre-allocating size for speed
for n=1:samples            %Looping through all of the samples and storing their ZC value in zc
    signs = sign(gest_ch(n,:));    %Getting the sign of each sample point
    previous = signs(1);       %previous and counter are used in the for loop to get the ZC
    counter = 0;
    for m=2:length(signs)      %Looping through signs and counting the number of times the values change
        current = signs(m);
        if previous ~= current
            counter = counter + 1;      %Storing the ZC in counter
        end
        previous = signs(m);
    end
    zc(n,1) = counter;
end
end

