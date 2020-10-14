% ........................................................................

% % My proposed Matlab codes for clustering the first 2000 samples of 
% acceleration response data of Haringvlietbrug bridge (Netherlands) based on 
% different traffic loads
% Algorithm: K-means
% Measure: Dynamic Time Warping Barycenter Average
% DBAclustering.m
% Navid Salami Pargoo
% 2020

% ........................................................................

% Clear memory 
clear

% Load the dataset into the variable "data"
load('data.mat')


% ============= FORM THE INPUT SEQUENCE OF SAMPLES FOR CLUSTERING =============

% Extract the 1st 2000 samples for clustering into the variable "sequences"
for i=1:2000
    sequences(i,:) = data(i,:);
end


% ================= FORM A 400-SAMPLE-SEQUENCE FOR AVERAGING =================

% Form 400 unique random numbers between 1 to 2000
indexDBA = randperm(size(sequences,1), 400);


for i=1:size(indexDBA,2)
    sequencesDBA(i,:) = sequences(indexDBA(i),:);
end


% ================= CALCULATE THE DBA OF 400-SAMPLE-SEQUENCE =================

tic
average = DBA(sequencesDBA);
toc

% ========== CALCULATE DTW DISTANCE OF INPUT SAMPLES TO THE AVERAGE ===========

Dist = zeros(size(sequences,1),1);

tic
for i=1:size(sequences,1)
    Dist(i) = dtw(sequences(i,:), average);
end
toc

% Consider distance with a value greater than 20 as outliers
indOut = find(Dist>20);
Dist(indOut) = [];

% Plot the distance of each sample to the DTW Barycenter Average
figure;
scatter([1:size(Dist,1)],Dist);
title('First 2000 samples to be classified')
xlabel('Sample no.')
ylabel('DTW-based Euclidean Distance w.r.t. Barycenter Average')


% ============ CLUSTER THE DISTANCES IN 5 CATEGORIES WITH K-MEANS =============

tic
k = 5;
[idx,C] = kmeans(Dist,k);
toc

% Plot the distances clustered in different labeled categories
figure;
hold on
for i=1:size(Dist,1)
    scatter(i,Dist(i),[],idx(i));
    text(i+0.1,Dist(i)+0.1,num2str(idx(i)));
end
colorbar;
title('Clustering first 2000 samples in 5 categories using DBA of 400 randomly selected samples')
xlabel('Sample no.')
ylabel('DTW-based Euclidean Distance w.r.t. Barycenter Average')



% ========================= EVALUATE THE ALGORITHM ===========================

% Randomly selecting five samples of each categories to check the similarity of 
% the samples clustered in a same category in both time and frequency domain.

evaluationPlot(sequences, idx)


