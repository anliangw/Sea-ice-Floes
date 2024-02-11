//Fig. 1a is taken as an example to explain how to use our codes. The codes can be run in the “interactive interpreter” window (Plugins -> Macros -> interactive interpreter) of Fiji. 
// make sure that plugins Weka and BioVoxxel are correctly installed in your Fiji.
// Ortho-rectification of sea-ice image is not carried out by our codes, so it needs to be done before running the codes.


// change lines below for your own working path and image name
path = "C:/anliangwang/"
image_name = "seaice.png";
open(path + image_name);
run("Duplicate...", "title=[copy.png]");


// activate plugin Weka to classify sea ice and sea water
run("Trainable Weka Segmentation");
selectWindow("Trainable Weka Segmentation v3.3.2");


// sample training dataset for sea ice; this part is better to be done by interactive windows of Fiji. The dataset can be an enclosed area or a line referring to Fig.3.
//setTool("polygon");
makePolygon(142,90,138,142,130,184,130,198,156,186,179,188,188,199,192,227,198,257,203,297,211,321,208,349,209,383,204,409,186,419,160,414,135,413,126,413,146,435,173,448,185,466,197,470,220,445,227,391,222,358,222,329,227,295,218,269,209,239,208,220,197,203,187,187,165,154);
call("trainableSegmentation.Weka_Segmentation.addTrace", "1", "1");
//setTool("polyline");
makeLine(564,179,568,190,574,201,579,213,584,227,585,237,587,244,593,252, 598,263,603,275,609,290,609,296);
call("trainableSegmentation.Weka_Segmentation.addTrace", "1", "1");
makeLine(495,11,502,28);
call("trainableSegmentation.Weka_Segmentation.addTrace", "1", "1");
makeLine(633,11,644,27,649,41,658,57,665,78,673,99,677,112,685,128,692,150);
call("trainableSegmentation.Weka_Segmentation.addTrace", "1", "1");
makeLine(782,5,790,20,795,35,775,39,753,47,748,51,749,68,751,73,752,82,755,88,755,92);
call("trainableSegmentation.Weka_Segmentation.addTrace", "1", "1");
makeLine(847,297,849,310,852,317,854,324,856,325,862,325,855,329,856,333, 860,332,866,328,873,325,883,321,886,322);
call("trainableSegmentation.Weka_Segmentation.addTrace", "1", "1");
makeLine(961,284,964,305,967,325,969,345,970,361,971,381,974,404,974,414);
call("trainableSegmentation.Weka_Segmentation.addTrace", "1", "1");
makeLine(1097,198,1108,205,1120,211,1128,216,1140,219,1145,218);
call("trainableSegmentation.Weka_Segmentation.addTrace", "1", "1");
makeLine(1186,21,1195,55,1201,69,1207,81,1210,92,1216,103,1223,115,1228,127, 1232,136,1240,148,1252,152);
call("trainableSegmentation.Weka_Segmentation.addTrace", "1", "1");
makeLine(762,1006,769,1008,778,1011,787,1010,800,1010,817,1010,820,1013);
call("trainableSegmentation.Weka_Segmentation.addTrace", "1", "1");


// sample training dataset for seawater; this part is better to be done by interactive windows of Fiji. The dataset can be an enclosed area or a line referring to Fig.3.
//setTool("polygon");
makePolygon(307,668,305,681,305,694,296,714,297,730,306,747,320,744,326, 726,319,704,316,680);
call("trainableSegmentation.Weka_Segmentation.addTrace", "0", "1");
//setTool("oval");
makeOval(770, 952, 30, 48);
makeOval(762, 924, 34, 78);
call("trainableSegmentation.Weka_Segmentation.addTrace", "0", "1");
makeOval(596, 1048, 74, 62);
makeOval(606, 1048, 64, 62);
makeOval(606, 1048, 64, 50);
call("trainableSegmentation.Weka_Segmentation.addTrace", "0", "1");
//setTool("polygon");
makePolygon(808,1375,808,1356,810,1343,814,1335,816,1328,817,1326,826,1326,831,1326,834,1337,839,1356,837,1377,837,1387,817,1379,807,1377);
call("trainableSegmentation.Weka_Segmentation.addTrace", "0", "1");
//setTool("oval");
makeOval(888, 5, 59, 49);
makeOval(888, -13, 59, 67);
call("trainableSegmentation.Weka_Segmentation.addTrace", "0", "1");


// Select the techniques to generate extra features of sea-ice images.
call("trainableSegmentation.Weka_Segmentation.setFeature", "Gaussian_blur=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Sobel_filter=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Membrane_projections=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Mean=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Hessian=false");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Difference_of_gaussians=false");


//Set patch size for directional filtering.
call("trainableSegmentation.Weka_Segmentation.setMembranePatchSize","19");


//Train the classifying model and classify ice and water.
call("trainableSegmentation.Weka_Segmentation.trainClassifier");
call("trainableSegmentation.Weka_Segmentation.getResult");


//Convert the classification image into binary ice-water image for segmentation.
selectWindow("Classified image");
saveAs("PNG", path+"Classified image.png");
run("Duplicate...", "title=[Classified image-copy.png]");
setAutoThreshold("Default dark");
run("Threshold...");
setThreshold(0, 0);
setOption("BlackBackground", true);
run("Convert to Mask");
close("Threshold");


//Complete the sea-ice floe segmentation with irregular watershed method.
run("Watershed Irregular Features", "erosion=1 convexity_threshold=0.95 separator_size=0-Infinity");


//Analyze sea-ice floe size distribution. The floes less than 2 pixels are ignored.
run("Set Measurements...", "area centroid perimeter redirect=None decimal=3");
run("Analyze Particles...", "size=2-Infinity show=Outlines display summarize add");
selectWindow(image_name);
roiManager("Show All without labels");
RoiManager.setGroup(0);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line Width", 2);
run("Flatten");
saveAs("PNG", path+ "result.png");