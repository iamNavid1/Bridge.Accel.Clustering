# Clustering Acceleration Response of the Haringvlietbrug bridge (Netherlands)
This repository provides a MATLAB code for unsupervised clustering of acceleration response of the Haringvlietbrug bridge in order to attribute each signal to a specific traffic load category using k-means algorithm, Dynamic Time Warping distance measure and DTW Barycenter Averaging. 

# Introduction
There has been an ongoing  research about the Haringvlietbrug project, a 1 km long bridge on which sensors were installed in two areas (with and without cracks). The cracks are rather small resulting in a great challenge in the Structural Health Monitoring (SHM) field. Because of the size of these cracks, it is needed to focus on the high frequency domain. However, as we know from literature, the environmental and operational variability (EOV) often mask the presence of cracks in the frequency domain. Therefore, the major challenge here is to tackle the EOV. This means that we need to understand the sources of variability and understand the different types of variability. Once we are able to do that, it is possible to proceed with feature extraction and, finally, damage detection. </br>
It has been learned that the variability in the high frequency region is highly affected by the traffic load (operational); each vehicle passage produces a (slightly) different frequency response. In the last part of the research, a method has been proposed to cluster  the raw time signals of each traffic excitation with minimal preprocessing and leaving the samples in the time domain.</br>
The accelerations were recorded for a continuous 15 minutes per hour. During these 15 minutes, multiple vehicles pass by. Figure 1 represents an example of a 15-minute recording.</br>

![acceleration response](https://raw.githubusercontent.com/iamnavid1/Bridge.Accel.Clustering/main/images/accelerationResponse.png)
Figure 1. Recording of acceleration response for 15 minutes (x-axis is time in seconds)</br>

Each sample was constructed based on a triggering algorithm; once the accelerations exceed a certain threshold a trigger is activated, and a sample array of certain length is saved. These samples are used for the clustering. However, since we know how much variance we have among the different traffic loads, it is needed to distillate the samples capturing only one single vehicle passing by. A preview of 5 different (non-standardized) loadings are illustrated in Figure 2. </br>

![samples of each passage](https://raw.githubusercontent.com/iamnavid1/Bridge.Accel.Clustering/images/samlpes.png)
Figure 2. Samples of loading due to a single vehicle passing by (Total length: 1 sec, Sampling frequency: 1000 HZ)</br>

# Dynamic Time Warping
Most clustering algorithms work with features extracted from raw data. These features are often of low dimension. When feeding the algorithm with these feature samples, the distance (similarity) is measured by usually linear metrics such as the Euclidean Distance. Since our aim is to perform clustering on raw signals, two problems arise when using standard (Euclidean) distance metrics. First, since the acceleration arrays are rather large, the curse of dimensionality happens and leads metric to explode and, as a result, valuable information is lost. Second, since no time-related information is captured in the commonly used Euclidean distance, we are not able to handle slightly shifted samples. This results in a rather meaningless distance metric. Therefore, we need a suitable metric capable of handling the two issues stated above, for example with Dynamic Time Warping (DTW). It measures the actual similarity of two time series – taking into account the time dimension. </br>
In time series analysis, dynamic time warping (DTW) is one of the algorithms for measuring similarity between two temporal sequences, which may vary in speed. While normal distance metrics ignore this time aspect, DTW is able to “understand” shifts in time. For example, comparing two similar samples, but one shifted in time, the Euclidean Distance would erroneously measure the series as “further away”, while the DTW will regard the series as similar.</br>

![DTW distance](https://raw.githubusercontent.com/iamnavid1/Bridge.Accel.Clustering/images/DTW.png)
Figure 3. Euclidean Distance matching versus Dynamic Time Warping matching </br>





