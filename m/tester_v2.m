global glob
%{

clear all;
close all;
addpath('matlab/lib/');
addpath('vlfeat-0.9.20/toolbox/sift');
%startup;
% Load images.
panoramaDir = 'images/';
panoramaScene = imageSet(panoramaDir);

% Display images to be stitched
montage(panoramaScene.ImageLocation);

images = sphProj(panoramaScene);
%{

for j=1:size(columns,2)
imwrite(columns{j},strcat('col_',int2str(j),'.jpg'));
end

%}
row = (length(images)/3);
tmp = cell(length(images)/row,row);
for i=1:length(images)
    tmp(floor((i-1)/row)+1,i-row*floor((i-1)/row))=images(i);
end
images = tmp;
clearvars tmp;
columns = cell(1,size(images,2));

glob.trhX = 100;
glob.thrY = 800;
%{
rows = cell(3,1);
rows(:,1) = images(:,1);
for i=1:3
    for j=2:size(images,2)
        rows{i}=horizontalJoin(images{i,j},rows{i},j);
    end
end
%}
for i=1:size(images,2)
   columns{i}=roundSize(verticalJoin(images(:,i)));
   % columns{i}=roundSize(horizontalJoin(...
   %     horizontalJoin(images{2,i},images{3,i},1),images{1,i},1));
end
%figure, imshow(columns{1});
 %}
glob.thrX = 900;
glob.thrY = 200;
out = columns;
for i=1:size(images,2)
    glob.currentColumn = i;
    out{i}=roundVerticalSize(horizontalJoin(columns{i},columns{mod(i,length(out))+1},i));
end
