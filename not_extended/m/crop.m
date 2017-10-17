function im = crop(imPath,imToCrop)
    global debug
    im1 =stich(imPath(size(imPath,1)));
    im2 =stich(imPath(1));
    [trX, ~] = findTraslation_opt(im1,1,im2,1);
    limit = size(imToCrop,2)-ceil((size(im1,2)-trX));
    im = imToCrop(1:size(imToCrop,1),1:limit);
    if debug
        figure;
        imshow([im(1:size(im,1),size(im,2)-200:size(im,2)),im(1:size(im,1),1:200)]);
    end