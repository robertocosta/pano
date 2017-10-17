function I = stich_recoursive(im_path)
    global angle
    global out
    n = size(im_path,1);
    m = mod(n,2);
    if ((n>=2)&&(m==0))
        im1 = stich_recoursive(im_path(1:n/2));
        im2 = stich_recoursive(im_path(n/2+1:n));
        out = strcat('left image : (',toString(im_path(1:n/2)),');\\',...
            'right image : (',toString(im_path(n/2+1:n)),').');
        I = stich2_opt(im1,n/2,im2,n/2);
        
    else
        if ((n>2)&&(m>0))
            im1 = stich_recoursive(im_path(1:round(n/2)));
            im2 = stich_recoursive(im_path(round(n/2)+1:n));
            out = strcat('left image : (',toString(im_path(1:round(n/2))),');\\',...
                'right image : (',toString(im_path(round(n/2)+1:n)),').');
            I = stich2_opt(im1,round(n/2),im2,round(n/2-1));
        else
            if (n==1)
                %char(im_path(n))
                img1 = imread(char(im_path(n)));
                im1 = projectIC(img1,angle);
                I = im1;
            end
        end
    end
            
            