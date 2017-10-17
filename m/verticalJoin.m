function [ out ] = verticalJoin( im )
%verticalJoin: This function joins 3 images vertically
%   Takes in input 3 images
im1 = im{1};
im2 = im{2};
im3 = im{3};
global glob; glob.callingFunction = 1;
imTot1 = stich2_vert(im2,1,im1,1);
out = stich2_vert(imTot1,1,im3,1);
end


