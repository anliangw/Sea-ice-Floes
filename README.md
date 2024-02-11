# Identifing Sea-ice-Floes
Integrating a Data-Driven Classifier and Shape-Modulated Segmentation for Sea-Ice Floe Extraction
Sea-ice images are foundational resources for studying the evolution of sea-ice floes (SIFs). However, extracting SIFs from diverse and complex 
sea-ice images using conventional segmentation methods is both tedious and challenging. The precision of identified SIFs is often compromised 
by various interferences, including low contrast, speckle noise, melt ponds, and slush ice. In this paper, we employ random forest machine 
learning to bolster the robustness of ice-water classification against interference. This data-driven approach reduces the reliance on subjective 
visual inspection for classification. Furthermore, we incorporated shape modulation within the framework of irregular watershed segmentation. 
By emphasizing contour convexity, we adeptly merge the oversegmented SIFs, thereby addressing the challenges inherent in traditional segmentation 
methods. Our methodology enhances accuracy and considerably reduces processing time. It also requires less manual intervention than traditional methods. 
This elevated level of accuracy and efficiency facilitates the extraction of SIFs from diverse types of sea-ice images, fostering research into SIF 
evolution under varying atmospheric and oceanic conditions.
we propose a pipeline for SIF segmentation that exhibits higher accuracy and requires fewer parameter adjustments than other methods. 
By leveraging an RF classifier for ice and water and incorporating shape modulation for SIF merging, this pipeline exhibits broad applicability 
to various types of sea-ice images captured by different sensors. Our aim is to enhance the accuracy and efficiency of SIF extraction while 
minimizing subjective intervention and manual adjustments.Our procedure was developed to achieve SIF segmentation with a high level of objectivity. 
The SIF segmentation procedure primarily depended on two open-source libraries, Weka and BioVoxxel, which rely on the open-platform ImageJ (Fiji). 
Weka was utilized for the RF classifier, while BioVoxxel was employed for irregular feature modulation based on the shape parameter of convexity. 
In summary, ice floe segmentation consisted of three main steps, as depicted in Fig. 2. These steps required two subjective actions. The first step 
involved manually selecting training samples for sea-ice and water, and the last step required specifying one parameter convexity C.
Here, the Fig. 18b (orthorecfied Fig. 1b) is taken as an example to explain how to use our codes. 
(1) The software package Fiji can be downloaded from https://imagej.net/software/fiji/downloads.
(2) The codes file can be read by many software such as notepad.
(3) The codes should be run in Fiji (File -> Open -> seaice.ijm -> Run). 
(4) Make sure that plugins Weka and BioVoxxel are correctly installed in your Fiji.
 
