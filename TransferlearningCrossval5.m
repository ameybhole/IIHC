%load alexnet
alex = alexnet;
layers = alex.Layers;

%modify layer to   136 categories
layers(23) = fullyConnectedLayer(136);  
layers(25) = classificationLayer;

%set up for training
allImages = imageDatastore('Dataset2' , 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
[imd1, imd2, imd3, imd4, imd5] = splitEachLabel(allImages,0.2,0.2,0.2,0.2,0.2,'randomize');
k = 5;
partStores{1} = imd1.Files ;
partStores{2} = imd2.Files ;
partStores{3} = imd3.Files ;
partStores{4} = imd4.Files ;
partStores{5} = imd5.Files ;
idx = crossvalind('Kfold', k, k);

for i = 1:k
    i;
    test_idx = (idx == i);
    train_idx = ~test_idx;

    testImages = imageDatastore(partStores{test_idx}, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
    trainingImages = imageDatastore(cat(1, partStores{train_idx}), 'IncludeSubfolders', true, 'LabelSource', 'foldernames');

    opts = trainingOptions('sgdm','InitialLearnRate' , 0.001, 'MaxEpochs', 50, 'MiniBatchSize',32, 'ExecutionEnvironment','gpu');
    myNet= trainNetwork(trainingImages, layers,opts);
    
    %Measure Network accuracy
    [predictedLabels,scores]  = classify(myNet, testImages);
    accuracy(i) = mean(predictedLabels == testImages.Labels);
    [confMat,order] = confusionmat(testImages.Labels, predictedLabels);
    confMatALL{i} = confMat;
    
    %Calculate Recall
    for a =1:size(confMat,1)
        recall(a) = confMat(a,a)/sum(confMat(a,:));
    end
    recall(isnan(recall))=[0];
    Recall = sum(recall)/size(confMat,1);
    RecallALL(i) = Recall;
    
    %Calculate Precision
    for b =1:size(confMat,1)
        precision(b) = confMat(b,b)/sum(confMat(:,b));
    end
    precision(isnan(precision))=[0];
    Precision = sum(precision)/size(confMat,1);
    PrecisionALL(i) = Precision;
    
    % F-score
    F_score = 2*Recall*Precision/(Precision+Recall);
    F_scoreALL(i)= F_score;
    disp(F_score);
    
    %Check for Incorrectly classified images
    testImageLabels = testImages.Labels;
    Labels = cat(2, testImageLabels, predictedLabels);
    A = (testImageLabels == predictedLabels);
    [row,col,v] = find(A==0);
    
    missclassifiedALL{i} = v;
    disp(v);
    
    %Get the incorrectly classified Labels
    %Predicted Labels
    for j = 1:length(v)
        PL(j) = predictedLabels(row(j));
        [row1,col1,v1] = find(testImages.Labels == PL);
    end
    %True Test Labels
    for m = 1:length(v)
        TL(m) = testImageLabels(row(m));
    end
    
     PredLabel{i} = PL;
     TestLabel{i} = TL;
    
end

