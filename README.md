# Clustering Acceleration Response of the Haringvlietbrug bridge (Netherlands)
This repository provides a MATLAB code for unsupervised clustering of acceleration response of the Haringvlietbrug bridge in order to attribute each signal to a specific traffic load category using k-means algorithm, Dynamic Time Warping distance measure and DTW Barycenter Averaging. Furthermore, the dataset of this project (the acceleration response signals can be downloaded from the following link: https://bit.ly/2T6sCd7

# Introduction
There has been an ongoing  research about the Haringvlietbrug project, a 1 km long bridge on which sensors were installed in two areas (with and without cracks). The cracks are rather small resulting in a great challenge in the Structural Health Monitoring (SHM) field. Because of the size of these cracks, it is needed to focus on the high frequency domain. However, as we know from literature, the environmental and operational variability (EOV) often mask the presence of cracks in the frequency domain. Therefore, the major challenge here is to tackle the EOV. This means that we need to understand the sources of variability and understand the different types of variability. Once we are able to do that, it is possible to proceed with feature extraction and, finally, damage detection. </br>
It has been learned that the variability in the high frequency region is highly affected by the traffic load (operational); each vehicle passage produces a (slightly) different frequency response. In the last part of the research, a method has been proposed to cluster  the raw time signals of each traffic excitation with minimal preprocessing and leaving the samples in the time domain.</br>
The accelerations were recorded for a continuous 15 minutes per hour. During these 15 minutes, multiple vehicles pass by. Figure 1 represents an example of a 15-minute recording.</br>

![acceleration response](https://raw.githubusercontent.com/iamnavid1/Bridge.Accel.Clustering/main/images/accelerationResponse.png)</br>
Figure 1. Recording of acceleration response for 15 minutes (x-axis is time in seconds)</br>

Each sample was constructed based on a triggering algorithm; once the accelerations exceed a certain threshold a trigger is activated, and a sample array of certain length is saved. These samples are used for the clustering. However, since we know how much variance we have among the different traffic loads, it is needed to distillate the samples capturing only one single vehicle passing by. A preview of 5 different (non-standardized) loadings are illustrated in Figure 2. </br>

![samples of each passage](https://raw.githubusercontent.com/iamnavid1/Bridge.Accel.Clustering/main/images/samlpes.png)</br>
Figure 2. Samples of loading due to a single vehicle passing by (Total length: 1 sec, Sampling frequency: 1000 HZ)</br>

# Dynamic Time Warping
Most clustering algorithms work with features extracted from raw data. These features are often of low dimension. When feeding the algorithm with these feature samples, the distance (similarity) is measured by usually linear metrics such as the Euclidean Distance. Since our aim is to perform clustering on raw signals, two problems arise when using standard (Euclidean) distance metrics. First, since the acceleration arrays are rather large, the curse of dimensionality happens and leads metric to explode and, as a result, valuable information is lost. Second, since no time-related information is captured in the commonly used Euclidean distance, we are not able to handle slightly shifted samples. This results in a rather meaningless distance metric. Therefore, we need a suitable metric capable of handling the two issues stated above, for example with Dynamic Time Warping (DTW). It measures the actual similarity of two time series – taking into account the time dimension. </br>
In time series analysis, dynamic time warping (DTW) is one of the algorithms for measuring similarity between two temporal sequences, which may vary in speed. While normal distance metrics ignore this time aspect, DTW is able to “understand” shifts in time. For example, comparing two similar samples, but one shifted in time, the Euclidean Distance would erroneously measure the series as “further away”, while the DTW will regard the series as similar.</br>

![DTW distance](https://raw.githubusercontent.com/iamnavid1/Bridge.Accel.Clustering/main/images/DTW.png)</br>
Figure 3. Euclidean Distance matching versus Dynamic Time Warping matching </br>

# DBA
DBA stands for Dynamic Time Warping Barycenter Averaging. DBA is an averaging method that is consistent with Dynamic Time Warping. Figure 4 gives an example of the difference between the traditional arithmetic mean of the set of time series and DBA. </br>
For more info and finding underlying research and scientific papers please refere to: https://github.com/fpetitjean/DBA </br>

![arithmetic mean](https://raw.githubusercontent.com/fpetitjean/DBA/master/images/arithmetic.png)</br>
![DBA](https://raw.githubusercontent.com/fpetitjean/DBA/master/images/DBA.png)</br>
Figure 4. Arithmetic mean versus DTW Barycenter Averaging </br>

# K-Means Clustering Algorithm
In this research, a k-means clustering (centroid based clustering) algorithm has been implemented, where we decide upon the number of clusters upfront. Hence, in the first step, we have decided to cluster the data into five categories according what is illustrated in figure 5.</br>
![Five Vehicle Categories](https://raw.githubusercontent.com/iamnavid1/Bridge.Accel.Clustering/main/images/5categories.png)</br>
Figure 5. Different classes of vehicles passing the bridge </br>

Since performing a DBA over such large array of acceleration responses is an extensively time-consuming task with high computational cost, we decided to evaluate the accuracy of using 20% of the samples for making DBA instead of taking all the samples into account. Hence, within the first 1000 samples, 200 samples were randomly selected and used to construct the average based on DBA method. Then, the average of the dataset using whole samples was also constructed based on DBA method neglecting the computational cost. Based on the DTW analysis on the two constructed averages, it turned out that the two signals are very similar with a DTW distance as little as 1.1 which confirms their similarity, this is shown in Figure 6. Hence, we decided to take 20% of the samples to form the average as a representation of the whole dataset. </br>

![Similarity measure](https://raw.githubusercontent.com/iamnavid1/Bridge.Accel.Clustering/main/images/similarity.png)</br>
Figure 6. DTW distance of the two averages constructed from the whole and 20% of the dataset </br>

In the next step, the DTW distance of each sample to the reference average is evaluated. In order to validate the accuracy of the idea of using 20% of samples as the reference average instead of the whole dataset, the DTW distance of each sample was measured with respect to both averages. To prevent repetition, Figure 7 represents only the plot of DTW distance of each sample to the whole dataset although another one also exists for the 20% of the dataset.</br>

![distance](https://raw.githubusercontent.com/iamnavid1/Bridge.Accel.Clustering/main/images/distance.png)</br>
Figure 7. DTW distance of each samples to the reference average (of the whole dataset) </br>

Then, a k-means clustering algorithm was performed to classify these distances into 5 distinct categories. The results of this clustering are shown in Figure 8. It is clear that accuracy of the second training set (using the reference average of 20% of the dataset) in comparison to the first one (using the refence average of the whole dataset) is 94.5%, which sounds acceptable. </br>

![clustering](https://raw.githubusercontent.com/iamnavid1/Bridge.Accel.Clustering/main/images/clustering1.png)</br>
![clustering](https://raw.githubusercontent.com/iamnavid1/Bridge.Accel.Clustering/main/images/clustering2.png)</br>
Figure 8. Clustering using full average (above) versus clustering using 20% average (below)</br>

Then, in order to check the similarity of the samples clustered in a same category in both time and frequency domain, five samples of each categories were randomly selected. Figures 8-12 represent these samples in both time and frequency domains for all 5 categories, as well as the distance of these samples in frequency domain with respect to each other. </br>

![Signlas of Cluster 1](https://raw.githubusercontent.com/iamnavid1/Bridge.Accel.Clustering/main/images/signalsCluster1.png)</br>
![Similarity of Signals of Cluster 1](https://raw.githubusercontent.com/iamnavid1/Bridge.Accel.Clustering/main/images/dtw1.png)</br>
Figure 8. Five samples of cluster number 1 in time and frequency domain and their DTW distances (similarity measure) to each other </br>

![Signlas of Cluster 2](https://raw.githubusercontent.com/iamnavid1/Bridge.Accel.Clustering/main/images/signalsCluster2.png)</br>
![Similarity of Signals of Cluster 2](https://raw.githubusercontent.com/iamnavid1/Bridge.Accel.Clustering/main/images/dtw2.png)</br>
Figure 9. Five samples of cluster number 2 in time and frequency domain and their DTW distances (similarity measure) to each other </br>

![Signlas of Cluster 3](https://raw.githubusercontent.com/iamnavid1/Bridge.Accel.Clustering/main/images/signalsCluster3.png)</br>
![Similarity of Signals of Cluster 3](https://raw.githubusercontent.com/iamnavid1/Bridge.Accel.Clustering/main/images/dtw3.png)</br>
Figure 10. Five samples of cluster number 3 in time and frequency domain and their DTW distances (similarity measure) to each other </br>

![Signlas of Cluster 4](https://raw.githubusercontent.com/iamnavid1/Bridge.Accel.Clustering/main/images/signalsCluster4.png)</br>
![Similarity of Signals of Cluster 4](https://raw.githubusercontent.com/iamnavid1/Bridge.Accel.Clustering/main/images/dtw4.png)</br>
Figure 11. Five samples of cluster number 4 in time and frequency domain and their DTW distances (similarity measure) to each other </br>

![Signlas of Cluster 5](https://raw.githubusercontent.com/iamnavid1/Bridge.Accel.Clustering/main/images/signalsCluster5.png)</br>
![Similarity of Signals of Cluster 5](https://raw.githubusercontent.com/iamnavid1/Bridge.Accel.Clustering/main/images/dtw5.png)</br>
Figure 12. Five samples of cluster number 5 in time and frequency domain and their DTW distances (similarity measure) to each other </br>

# Conclusion
In this research, we manage to perform a global averaging using and accurate similarity measure. Also, regarding the computational cost, this method is proven to be significantly less time consuming. The k-means algorithm empowers us to achieve a rapid assessment.


