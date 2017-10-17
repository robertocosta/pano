startup;

for index = 1:glob.nImages
%for index = 1:2
    I1 = rgb2gray(imread(char(strrep(glob.path1(index,:),' ',''))));
    I1 = projectIS(single(I1)/255);
    I2 = rgb2gray(imread(char(strrep(glob.path2(index,:),' ',''))));
    I2 = projectIS(single(I2)/255);
    if index == 1
        %Itot = stich2(I1,I2);
        Itot = sift_mosaic(I1,I2);
    else
        %Itot = stich2(Itot,stich2(I1,I2));
        Itot = sift_mosaic(Itot,sift_mosaic(I1,I2));
    end
end
%figure;
%imshow(Itot);