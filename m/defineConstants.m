function [ out ] = defineConstants( n,im )
%defineConstants( n,im ) set global glob vaiable
%   input n: # of images, input im: sample image
global glob
calibration;
glob.thrMatch = 0.55;
glob.thrAngle = 0.1/(2*pi);
glob.thrScale = 1;
glob.roundSize.x = 1200;
glob.roundSize.y = 1400;
glob.roundVerticalSize = 1400;
glob.delTr = 10;
glob.horizontalMultiplier = 1/10;
%glob.plotWidth=350;
%glob.plotHeight=300;
%glob.plotRadius = 50;
%glob.nMatches = 7;
glob.nIm = n;
% sizes of the images
glob.imX = size(im,2);
glob.imY = size(im,1);

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
glob.outX = floor(glob.rX*2*glob.alpha/180*pi);
glob.outY = floor(glob.rY*2*glob.beta/180*pi);
glob.minCorrespondance = 4;
end

