%load alexnet
alex = alexnet;
layers = alex.Layers;

%modify layer to   136 categories
layers(23) = fullyConnectedLayer(136);  
layers(25) = classificationLayer;

%set up for training
allImages = imageDatastore('Dataset2' , 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
[trainingImages, testImages] = splitEachLabel(allImages, 0.8, 'randomize');

%re-train the network
opts = trainingOptions('sgdm','InitialLearnRate' , 0.001, 'MaxEpochs', 50, 'MiniBatchSize',32, 'ExecutionEnvironment','gpu');
myNet= trainNetwork(trainingImages, layers,opts);

%Measure Network accuracy
[predictedLabels,scores]  = classify(myNet, testImages);
accuracy = mean(predictedLabels == testImages.Labels);

[confMat,order] = confusionmat(testImages.Labels, predictedLabels);

%Calculate Recall
for i =1:size(confMat,1)
    recall(i) = confMat(i,i)/sum(confMat(i,:));
end
recall(isnan(recall))=[0];
Recall = sum(recall)/size(confMat,1);
Recall;

%Calculate Precision
for i =1:size(confMat,1)
    precision(i) = confMat(i,i)/sum(confMat(:,i));
end
precision(isnan(precision))=[0];
Precision = sum(precision)/size(confMat,1);
Precision;

%Calculate F-score
F_score = 2*Recall*Precision/(Precision+Recall);
F_score;
 
%Check for Incorrectly classified images
testImageLabels = testImages.Labels;
Labels = cat(2, testImageLabels, predictedLabels);
A = (testImageLabels == predictedLabels);
[row,col,v] = find(A==0);

%Get the incorrectly classified Labels
%Predicted Labels
for i = 1:length(v)
    PL(i) = predictedLabels(row(i));
    [row1,col1,v1] = find(testImages.Labels == PL);
end
%True Test Labels
for i = 1:length(v)
    TL(i) = testImageLabels(row(i));
end
    
