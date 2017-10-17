function im_path = getImagesPaths
    global path
    global format
    global length

    im_path = cell(length,1);
    for i=1:length
        im_path(i) = {strcat(path,'i',int2str(i),format)};
    end