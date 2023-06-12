function [data_gest_mixed] = mix_dataset(data_gest)
%This function shuffles the features from the samples of each person/day equally

%Sanity check to see the numbers are mixed correctly 
%(uncomment to see the original position of the samples as a last column in the matrix)
%data_gest = [data_gest, (1:size(data_gest,1))'];

data_gest_mixed = single(zeros(size(data_gest,1),size(data_gest,2)));   %Matrix with the shuffled features. Pre-allocating size for speed

counter1 = 1;   %counter1 is used to fill the first 14 instances of the shuffled feature matrix with each loop iteration later on
counter2 = 1;   %counter2 is used to track the cummulative number of loop iterations in order to determine with value to fill in the 15th instance of the shuffled feature matrix with each loop iteration later on
counter3 = 1;   %counter3, counter4 and counter5 are used to fill in the 15th instance of the shuffled feature matrix with each loop iteration later on 
counter4 = 1;
counter5 = 1;

%With each loop iteration, 15 instances of the shuffled feature matrix are defined
for n=1:30      %30*15 = 450
    %Filling the first 14 instances
    data_gest_mixed(counter1,:) = data_gest(n,:);    %Dataset 1, Female 1
    data_gest_mixed(counter1+1,:) = data_gest(n+150,:);    %Dataset 2, Male Day 1
    data_gest_mixed(counter1+2,:) = data_gest(n+250,:);    %Dataset 2, Male Day 2
    data_gest_mixed(counter1+3,:) = data_gest(n+30,:);    %Dataset 1, Female 2
    data_gest_mixed(counter1+4,:) = data_gest(n+350,:);    %Dataset 2, Male Day 3
    data_gest_mixed(counter1+5,:) = data_gest(n+180,:);    %Dataset 2, Male Day 1
    data_gest_mixed(counter1+6,:) = data_gest(n+60,:);    %Dataset 1, Female 3
    data_gest_mixed(counter1+7,:) = data_gest(n+280,:);    %Dataset 2, Male Day 2
    data_gest_mixed(counter1+8,:) = data_gest(n+380,:);    %Dataset 2, Male Day 3
    data_gest_mixed(counter1+9,:) = data_gest(n+90,:);    %Dataset 1, Male 1
    data_gest_mixed(counter1+10,:) = data_gest(n+210,:);    %Dataset 2, Male Day 1
    data_gest_mixed(counter1+11,:) = data_gest(n+310,:);    %Dataset 2, Male Day 2
    data_gest_mixed(counter1+12,:) = data_gest(n+120,:);    %Dataset 1, Male 2
    data_gest_mixed(counter1+13,:) = data_gest(n+410,:);    %Dataset 2, Male Day 3
    
    %Filling the 15th instance
    if rem(counter2,3) == 0 && counter3 <= 10   %If counter2 is a multiple of 3 this code is executed
        data_gest_mixed(counter1+14,:) = data_gest(counter3+240,:);    %Dataset 2, Male Day 1
        counter3 = counter3 + 1;
    elseif rem(counter2,2) == 0 && counter4 <= 10   %If counter2 is a multiple of 2 this code is executed
        data_gest_mixed(counter1+14,:) = data_gest(counter4+340,:);    %Dataset 2, Male Day 2
        counter4 = counter4 + 1;
    elseif counter5 <= 10   %If counter2 is neither a multiple of 2 or 3 this code is executed
        data_gest_mixed(counter1+14,:) = data_gest(counter5+440,:);    %Dataset 2, Male Day 3
        counter5 = counter5 + 1;
    end
    
    counter1 = counter1 + 15;
    counter2 = counter2 + 1;
end
end