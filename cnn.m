clc 
clear all
close all


matlabroot ='C:\Users\shaki\Desktop\Image Processing'

Datasetpath=fullfile(matlabroot,'dataset')
Data=imageDatastore(Datasetpath,'IncludeSubfolders',true,'LabelSource','foldernames')
Data.ReadSize = numpartitions(Data)
Data.ReadFcn = @(loc)imresize(imread(loc),[400,600]);
Datasetpath2=fullfile(matlabroot,'data')
imdsTest=imageDatastore(Datasetpath2,'IncludeSubfolders',true,'LabelSource','foldernames');

layers=[imageInputLayer([400 600 3])
convolution2dLayer(5,20)
reluLayer
maxPooling2dLayer(3,'stride',3)
convolution2dLayer(5,20)
reluLayer
maxPooling2dLayer(3,'stride',3)
fullyConnectedLayer(3)
softmaxLayer
classificationLayer()]

options=trainingOptions('sgdm','MaxEpochs',15,'initialLearnRate',0.0001');



convnet=trainNetwork(Data,layers,options)

save NewskinDb.mat

