load NewskinDb.mat

imdsTest.ReadSize = numpartitions(imdsTest)
imdsTest.ReadFcn = @(loc)imresize(imread(loc),[400,600]);
yTest = classify(convnet,imdsTest); 
accuracy = sum(yTest == imdsTest.Labels) / numel(imdsTest.Labels);