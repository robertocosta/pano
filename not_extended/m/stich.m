function I = stich(im_path)
    global angle
    global out
    n = size(im_path,1);
    img1 = imread(char(im_path(1)));
    im1 = projectIC(img1,angle);    
    for i=2:n
        img2 = imread(char(im_path(i)));
        im2 = projectIC(img2,angle);
        out = strcat('left image: ',toString(im_path(1:i-1)),';\\',...
            'right image: ',int2str(i),'.');
        im1 = stich2_opt(im1,i,im2,1);
    end
    I = im1;
