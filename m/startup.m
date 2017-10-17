clear all; close all; %clc;
addpath('matlab/lib');
%defineGlobals;
global glob
% ratio between best match and second best threshold
%glob.threshold1 = 1;
% sizes of plots
%{
glob.plotWidth=350;
glob.plotHeight=300;
glob.plotRadius = 50;
glob.nMatches = 7;
% sizes of the images
glob.imX = 1200;
glob.imY = 800;

glob.focalDistance = 18;
glob.CCDSizeX = 22.3;
glob.CCDSizeY = 14.9;
glob.alpha = atan(glob.CCDSizeX/2/glob.focalDistance)*180/pi;
glob.beta = atan(glob.CCDSizeY/2/glob.focalDistance)*180/pi;

glob.planeDistance = (glob.imX / 2 / tan(glob.alpha/180*pi)+...
    glob.imY / 2 / tan(glob.beta/180*pi)) /2;
glob.rSfera = sqrt(glob.planeDistance^2+glob.imX^2/4+glob.imY^2/4);
glob.rX = sqrt(glob.planeDistance^2+glob.imX^2/4);
glob.rY = sqrt(glob.planeDistance^2+glob.imY^2/4);
glob.outX = round(glob.rX*2*glob.alpha/180*pi);
glob.outY = round(glob.rY*2*glob.beta/180*pi);


%}
%{
%% ADD VLFEAT LIBRARY
run('D:/unipd/Esami/Image and video analysis/final_project/vlfeat-0.9.20/toolbox/vl_setup');

%% LOAD FIRST ROW OF IMAGES PATHS
glob.nImages = 11;
%glob.nImages = 2;
buildingDir = '../images/';
buildingScene = imageSet(buildingDir);
immagini.originali = cell(glob.nImages,1);
for i=1:glob.nImages
    immagini.originali{i} = read(buildingScene, i);
end
tmp = proietta(immagini.originali);
for i=1:length(tmp)
    immagini.proiettate.foto{i,1} = tmp{i,1}.im;
    immagini.proiettate.posizione{i,1} = tmp{i,1}.pos;
end
%Itot = imread(glob.path1Cell{1});
%for i=1:size(glob.path1,1)
%    Itot = sift_mosaic(Itot,imread(glob.path1Cell{i}));
%end
%Itot = stich_rec(glob.path1Cell);
%imageTot = pano(
%figure;
%imshow(immagini.originali{1,1});
%figure;
%imshow(immagini.proiettate.foto{1});
rgb=cat(3,immagini.proiettate.foto{1,1},...
    immagini.proiettate.foto{1,1},immagini.proiettate.foto{1,1});

%Im3D = posizionaPixel(immagini.proiettate);
%{
unregistered = immagini.proiettate.foto{1};
figure, imshow(unregistered)
text(size(unregistered,2),size(unregistered,1)+15, ...
    'First Image', ...
    'FontSize',7,'HorizontalAlignment','right');
ortho = immagini.proiettate.foto{2};
ortho = ortho(:,1:100);
figure, imshow(ortho)
text(size(ortho,2),size(ortho,1)+15, ...
    'Second Image', ...
    'FontSize',7,'HorizontalAlignment','right');
load westconcordpoints
t_concord = fitgeotrans(movingPoints,fixedPoints,'projective');
Rfixed = imref2d(size(ortho));
registered = imwarp(unregistered,t_concord,'OutputView',Rfixed);
figure, imshowpair(ortho,registered,'blend')
%}

for i=1:glob.nImages
    imwrite(immagini.proiettate.foto{i},...
        strcat('../images/out/i(',int2str(i),').jpg'));
end
%{
I1 = stich2_opt(im1,1,im2,1);
[optimizer, metric]  = imregconfig('monomodal');
movingRegistered = imregister(im2,im1,'affine',optimizer,metric);
imshowpair(im1, movingRegistered,'Scaling','joint');
imshow(im1)
figure, imshow(I1);
%}
buildingDir = '../images/out/';
buildingScene = imageSet(buildingDir);
%montage(buildingScene.ImageLocation);

% Initialize features for I(1)
grayImage = read(buildingScene, 1);
points = detectSURFFeatures(grayImage,'MetricThreshold',70);
[features, points] = extractFeatures(grayImage, points);

% Initialize all the transforms to the identity matrix. Note that the
% projective transform is used here because the building images are fairly
% close to the camera. Had the scene been captured from a further distance,
% an affine transform would suffice.
tforms(buildingScene.Count) = projective2d(eye(3));

% Iterate over remaining image pairs
for n = 2:buildingScene.Count

    % Store points and features for I(n-1).
    pointsPrevious = points;
    featuresPrevious = features;

    % Read I(n).
    % I = read(buildingScene, n);

    % Detect and extract SURF features for I(n).
    grayImage = read(buildingScene, n);
    points = detectSURFFeatures(grayImage,'MetricThreshold',70);
    [features, points] = extractFeatures(grayImage, points);

    % Find correspondences between I(n) and I(n-1).
    indexPairs = matchFeatures(features, featuresPrevious, 'Unique', true);

    matchedPoints = points(indexPairs(:,1), :);
    matchedPointsPrev = pointsPrevious(indexPairs(:,2), :);

    % Estimate the transformation between I(n) and I(n-1).
    tforms(n) = estimateGeometricTransform(matchedPoints, matchedPointsPrev,...
        'projective', 'Confidence', 97, 'MaxNumTrials', 10000);

    % Compute T(1) * ... * T(n-1) * T(n)
    tforms(n).T = tforms(n-1).T * tforms(n).T;
end
%}