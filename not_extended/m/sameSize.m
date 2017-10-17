function [imA, imB] = sameSize(im1,im2)
    if (size(im1,1)>size(im2,1))
        % add zeros at the beginning of im2
        imA = im1;
        imB = [zeros(size(im1,1)-size(im2,1),size(im2,2));im2];  
    else
        % add zeros at the beginning of im1
        imA = [zeros(size(im2,1)-size(im1,1),size(im1,2));im1];  
        imB = im2;
    end