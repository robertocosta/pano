close all;
clear all;
defineGlobals;
global algorithm_type
global output
global out
global angle
im_pathA = getImagesPaths;
im1 = projectIC(imread(char(im_pathA(1))),angle);
im2 = projectIC(imread(char(im_pathA(2))),angle);
im3 = projectIC(imread(char(im_pathA(3))),angle);
im4 = projectIC(imread(char(im_pathA(4))),angle);
if (algorithm_type==1)
    out = strcat('left image: i1.png;\\right image: i2.png');
    I1 = stich2_opt(im1,1,im2,1);
    out = strcat('left image: i1.png, i2.png;\\right image: i3.png');
    I2 = stich2_opt(I1,2,im3,1);
    out = strcat('left image: i1.png, i2.png, i3.png;\\right image: i4.png');
    I3 = stich2_opt(I2,3,im4,1);
else
    out = strcat('left image: i1.png;\\right image: i2.png');
    I1 = stich2_opt(im1,1,im2,1);
    figure('name',out);
    imshow(I1);
    out = strcat('left image: i3.png;\\right image: i4.png');
    I2 = stich2_opt(im3,1,im4,1);
    figure('name',out);
    imshow(I2);
    out = strcat('left image: i1.png, i2.png;\\right image: i3.png, i4.png');
    I3 = stich2_opt(I1,2,I2,2);
    figure('name',out);
    imshow(I3);
end

disp(char(output));
