function I12 = stich2(I1,I2)
I12L = sift_mosaic(I1,I2);
I12R = sift_mosaic(I2,I1);
offset = 100;
I12 = sift_mosaic(I12L(1:end,1:round(end/2)+offset,:),...
    I12R(1:end,round(end/2)-offset:end,:));
%{
    figure(3)
    imshow(I12L)
    figure(4)
    imshow(I12R)
    figure(5)
    imshow(I12)
%}