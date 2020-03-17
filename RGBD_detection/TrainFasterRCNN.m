clear;clc;
data = load('LabelData.mat');
T = data.T;

rng(0)
shuffledIdx = randperm(height(T));
idx = floor(0.6 * height(T));
trainingDataTbl = T(shuffledIdx(1:idx),:);
testDataTbl = T(shuffledIdx(idx+1:end),:);

imdsTrain = imageDatastore(trainingDataTbl{:,'pic_num'});
bldsTrain = boxLabelDatastore(trainingDataTbl(:,'position_all'));

imdsTest = imageDatastore(testDataTbl{:,'pic_num'});
bldsTest = boxLabelDatastore(testDataTbl(:,'position_all'));

trainingData = combine(imdsTrain,bldsTrain);
testData = combine(imdsTest,bldsTest);


%%
data = read(trainingData);
I = data{1};
bbox = data{2};
annotatedImage = insertShape(I,'Rectangle',bbox);
annotatedImage = imresize(annotatedImage,2);
figure
imshow(annotatedImage)
%%

inputSize = [40 40 3];
numAnchors = 5;
anchorBoxes = estimateAnchorBoxes(trainingData,numAnchors);

featureExtractionNetwork = resnet50;

featureLayer = 'activation_40_relu';
numClasses = width(T)-1;
lgraph = fasterRCNNLayers(inputSize,numClasses,anchorBoxes,featureExtractionNetwork,featureLayer);

%%
options = trainingOptions('sgdm',...
    'MaxEpochs',5,...
    'MiniBatchSize',2,...
    'InitialLearnRate',1e-4,...
    'CheckpointPath',tempdir);

doTrainingAndEval=true;
if doTrainingAndEval
    % Train the Faster R-CNN detector.
    % * Adjust NegativeOverlapRange and PositiveOverlapRange to ensure
    %   that training samples tightly overlap with ground truth.
    [detector, info] = trainFasterRCNNObjectDetector(trainingData,lgraph,options, ...
        'NegativeOverlapRange',[0 0.3], ...
        'PositiveOverlapRange',[0.6 1]);
else
    % Load pretrained detector for the example.
    pretrained = load('fasterRCNNResNet50EndToEndVehicleExample.mat');
    detector = pretrained.detector;
end

%% test and evaluation
doTrainingAndEval=true;
if doTrainingAndEval
    detectionResults = detect(detector,testData,'MinibatchSize',4);
else
    % Load pretrained detector for the example.
    pretrained = load('fasterRCNNResNet50EndToEndVehicleExample.mat');
    detectionResults = pretrained.detectionResults;
end
[ap, recall, precision] = evaluateDetectionPrecision(detectionResults,testData);
figure
plot(recall,precision)
xlabel('Recall')
ylabel('Precision')
grid on
title(sprintf('Average Precision = %.2f', ap))

% I=imread(testDataTbl.pic_num{50});
% annotatedImage = insertShape(I,'Rectangle',detectionResults.Boxes{50});
% imshow(annotatedImage)