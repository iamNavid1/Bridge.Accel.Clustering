% ........................................................................

% % My proposed Matlab codes for clustering the first 2000 samples of 
% acceleration response data of Haringvlietbrug project based on 
% different traffic loads
% Algorithm: K-means
% Measure: Dynamic Time Warping Barycenter Average
% evaluationPlot.m
% © Navid Salami Pargoo
% 2020


function evaluationPlot(sequences, idx)

% Randomly selecting five samples of each categories to check the similarity of 
% the samples clustered in a same category in both time and frequency domain.


Ind1 = find(idx==1);
Ind1 = Ind1(randsample(1:numel(Ind1),5));
Ind2 = find(idx==2);
Ind2 = Ind2(randsample(1:numel(Ind2),5));
Ind3 = find(idx==3);
Ind3 = Ind3(randsample(1:numel(Ind3),5));
Ind4 = find(idx==4);
Ind4 = Ind4(randsample(1:numel(Ind4),5));
Ind5 = find(idx==5);
Ind5 = Ind5(randsample(1:numel(Ind5),5));

% 5 randomly selected signals in each category in time domain 
CL1 = sequences(Ind1,:);
CL2 = sequences(Ind2,:);
CL3 = sequences(Ind3,:);
CL4 = sequences(Ind4,:);
CL5 = sequences(Ind5,:);

% 5 randomly selected signals in the first category in frequency domain 
X=1000*(0:500)/1000;
Y11=abs(fft(CL1(1,:)/1000));
Y11=Y11(1:501);
Y12=abs(fft(CL1(2,:)/1000));
Y12=Y12(1:501);
Y13=abs(fft(CL1(3,:)/1000));
Y13=Y13(1:501);
Y14=abs(fft(CL1(4,:)/1000));
Y14=Y14(1:501);
Y15=abs(fft(CL1(5,:)/1000));
Y15=Y15(1:501);

% Ploting the randomly selected signals of teh first cluster in time domain
figure
hold on
subplot(5,2,1)
plot(CL1(1,:))
subplot(5,2,3)
plot(CL1(2,:))
subplot(5,2,5)
plot(CL1(3,:))
subplot(5,2,7)
plot(CL1(4,:))
subplot(5,2,9)
plot(CL1(5,:))
% Ploting the randomly selected signals of the first cluster in frequency domain
subplot(5,2,2)
plot(X,Y11)
subplot(5,2,4)
plot(X,Y12)
subplot(5,2,6)
plot(X,Y13)
subplot(5,2,8)
plot(X,Y14)
subplot(5,2,10)
plot(X,Y15)

sgtitle('5 Random Samples from Cluster 1 (Acceleration Response & Frequency Content)')
hold off

% Plot DTW-based distance (similarity measure) of the 5 signals in frquency
% domain with respect to each other
M1=zeros(5,5);
R1=[Y11; Y12; Y13; Y14; Y15];

for i=1:5
    for j=1:5
        M1(i,j) = dtw(R1(i,:),R1(j,:));
    end
end

figure
imagesc(M1)
colorbar

% --------

% 5 randomly selected signals in the second category in frequency domain 
Y21=abs(fft(CL2(1,:)/1000));
Y21=Y21(1:501);
Y22=abs(fft(CL2(2,:)/1000));
Y22=Y22(1:501);
Y23=abs(fft(CL2(3,:)/1000));
Y23=Y23(1:501);
Y24=abs(fft(CL2(4,:)/1000));
Y24=Y24(1:501);
Y25=abs(fft(CL2(5,:)/1000));
Y25=Y25(1:501);

% Ploting the randomly selected signals of the second cluster in time domain
figure
hold on
subplot(5,2,1)
plot(CL2(1,:))
subplot(5,2,3)
plot(CL2(2,:))
subplot(5,2,5)
plot(CL2(3,:))
subplot(5,2,7)
plot(CL2(4,:))
subplot(5,2,9)
plot(CL2(5,:))
% Ploting the randomly selected signals of the second cluster in frequency domain
subplot(5,2,2)
plot(X,Y21)
subplot(5,2,4)
plot(X,Y22)
subplot(5,2,6)
plot(X,Y23)
subplot(5,2,8)
plot(X,Y24)
subplot(5,2,10)
plot(X,Y25)
sgtitle('5 Random Samples from Cluster 2 (Acceleration Response & Frequency Content)')
hold off

% Plot DTW-based distance (similarity measure) of the 5 signals in frquency
% domain with respect to each other
M2=zeros(5,5);
R2=[Y21; Y22; Y23; Y24; Y25];

for i=1:5
    for j=1:5
        M2(i,j) = dtw(R2(i,:),R2(j,:));
    end
end

figure
imagesc(M2)
colorbar

% --------

% 5 randomly selected signals in the third category in frequency domain 
Y31=abs(fft(CL3(1,:)/1000));
Y31=Y31(1:501);
Y32=abs(fft(CL3(2,:)/1000));
Y32=Y32(1:501);
Y33=abs(fft(CL3(3,:)/1000));
Y33=Y33(1:501);
Y34=abs(fft(CL3(4,:)/1000));
Y34=Y34(1:501);
Y35=abs(fft(CL3(5,:)/1000));
Y35=Y35(1:501);

% Ploting the randomly selected signals of the third cluster in time domain
figure
hold on
subplot(5,2,1)
plot(CL3(1,:))
subplot(5,2,3)
plot(CL3(2,:))
subplot(5,2,5)
plot(CL3(3,:))
subplot(5,2,7)
plot(CL3(4,:))
subplot(5,2,9)
plot(CL3(5,:))
% Ploting the randomly selected signals of the third cluster in frequency domain
subplot(5,2,2)
plot(X,Y31)
subplot(5,2,4)
plot(X,Y32)
subplot(5,2,6)
plot(X,Y33)
subplot(5,2,8)
plot(X,Y34)
subplot(5,2,10)
plot(X,Y35)
sgtitle('5 Random Samples from Cluster 3 (Acceleration Response & Frequency Content)')
hold off

% Plot DTW-based distance (similarity measure) of the 5 signals in frquency
% domain with respect to each other
M3=zeros(5,5);
R3=[Y31; Y32; Y33; Y34; Y35];

for i=1:5
    for j=1:5
        M3(i,j) = dtw(R3(i,:),R3(j,:));
    end
end

figure
imagesc(M3)
colorbar

% --------

% 5 randomly selected signals in the fourth category in frequency domain 
Y41=abs(fft(CL4(1,:)/1000));
Y41=Y41(1:501);
Y42=abs(fft(CL4(2,:)/1000));
Y42=Y42(1:501);
Y43=abs(fft(CL4(3,:)/1000));
Y43=Y43(1:501);
Y44=abs(fft(CL4(4,:)/1000));
Y44=Y44(1:501);
Y45=abs(fft(CL4(5,:)/1000));
Y45=Y45(1:501);

% Ploting the randomly selected signals of the fourth cluster in time domain
figure
hold on
subplot(5,2,1)
plot(CL4(1,:))
subplot(5,2,3)
plot(CL4(2,:))
subplot(5,2,5)
plot(CL4(3,:))
subplot(5,2,7)
plot(CL4(4,:))
subplot(5,2,9)
plot(CL4(5,:))
% Ploting the randomly selected signals of the fourth cluster in frequency domain
subplot(5,2,2)
plot(X,Y41)
subplot(5,2,4)
plot(X,Y42)
subplot(5,2,6)
plot(X,Y43)
subplot(5,2,8)
plot(X,Y44)
subplot(5,2,10)
plot(X,Y45)
sgtitle('5 Random Samples from Cluster 4 (Acceleration Response & Frequency Content)')
hold off

% Plot DTW-based distance (similarity measure) of the 5 signals in frquency
% domain with respect to each other
M4=zeros(5,5);
R4=[Y41; Y42; Y43; Y44; Y45];

for i=1:5
    for j=1:5
        M4(i,j) = dtw(R4(i,:),R4(j,:));
    end
end

figure
imagesc(M4)
colorbar

% --------

% 5 randomly selected signals in the fifth category in frequency domain 
Y51=abs(fft(CL5(1,:)/1000));
Y51=Y51(1:501);
Y52=abs(fft(CL5(2,:)/1000));
Y52=Y52(1:501);
Y53=abs(fft(CL5(3,:)/1000));
Y53=Y53(1:501);
Y54=abs(fft(CL5(4,:)/1000));
Y54=Y54(1:501);
Y55=abs(fft(CL5(5,:)/1000));
Y55=Y55(1:501);

% Ploting the randomly selected signals of the fifth cluster in time domain
figure
hold on
subplot(5,2,1)
plot(CL5(1,:))
subplot(5,2,3)
plot(CL5(2,:))
subplot(5,2,5)
plot(CL5(3,:))
subplot(5,2,7)
plot(CL5(4,:))
subplot(5,2,9)
plot(CL5(5,:))
% Ploting the randomly selected signals of the fifth cluster in frequency domain
subplot(5,2,2)
plot(X,Y51)
subplot(5,2,4)
plot(X,Y52)
subplot(5,2,6)
plot(X,Y53)
subplot(5,2,8)
plot(X,Y54)
subplot(5,2,10)
plot(X,Y55)
sgtitle('5 Random Samples from Cluster 5 (Acceleration Response & Frequency Content)')
hold off

% Plot DTW-based distance (similarity measure) of the 5 signals in frquency
% domain with respect to each other
M5=zeros(5,5);
R5=[Y51; Y52; Y53; Y54; Y55];

for i=1:5
    for j=1:5
        M5(i,j) = dtw(R5(i,:),R5(j,:));
    end
end

figure
imagesc(M5)
colorbar

end
