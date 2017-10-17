function [trX, trY] = findTraslation_opt(im1,l1,im2,l2)
    global debug
    global threshold1
    global threshold2
    global threshold3
    global threshold4
    global threshold5
    
    % OPTIMIZATION
    opt_index = 1;
    again = true;
    im1_original = im1;
    im2_original = im2;
    while (again)
        im1 = im1_original;
        im2 = im2_original;
        im1z1 = size(im1,2)-ceil(size(im1,2)/(2*l1))-1;
        im1z(1) = im1z1;
        im1z1 = (size(im1,2)-ceil(size(im1,2)/(l1))-1)*(l1>1);
        im1z(2) = im1z1; 
        im1z1 = size(im1,2)-ceil(size(im1,2)/2)-1;
        im1z(3) = im1z1; 
        im1z1=im1z(opt_index);

        im2z2 =  ceil(size(im2,2)/(2*l2))+1;
        im2z(1)=im2z2;
        im2z2 =  (ceil(size(im2,2)/(l2))+1)*(l2>1)+size(im2,2)*(l2==1);
        im2z(2)=im2z2;
        im2z2 =  ceil(size(im2,2)/2)+1;
        im2z(3)=im2z2;
        im2z2 = im2z(opt_index);

        %r = 1/2;
        r = 1/size(im1,1);

        h = ceil(size(im1,1)*r);
        % replace the useless part of the image with black
        im1 = [zeros(size(im1,1),im1z1),[zeros(h,size(im1,2)-im1z1);...
            im1(h+1:size(im1,1),im1z1+1:size(im1,2))]];
        im2 = [[zeros(h,im2z2-1);im2(h+1:size(im2,1),1:im2z2-1)],...
            zeros(size(im2,1),size(im2,2)-im2z2)];

        % END OF OPTIMIZATION
        if debug 
            dt = datestr(now,'yyyy.mm.dd_HH.MM.SS');
            imageFile1 = strcat(dt,'_tmp_im1.bmp');
            imageFile2 = strcat(dt,'_tmp_im2.bmp');
        else
            imageFile1 = 'tmp_im1.bmp';
            imageFile2 = 'tmp_im2.bmp';
        end
        imwrite(im1,imageFile1);
        imwrite(im2,imageFile2);
        [im1, des1, loc1] = sift(imageFile1);
        [im2, des2, loc2] = sift(imageFile2);
        [match, ~] = match2(im1, des1, loc1, im2, des2, loc2, threshold1);

        trX = []; % traslation X
        trY = []; % traslation Y
        goodMatch = zeros(length(match),1);
        for j=1:length(match)
            if match(j)>0
                deltaX = loc1(j,2)-loc2(match(j),2);
                deltaY = loc1(j,1)-loc2(match(j),1);
                deltaS = abs(loc1(j,3)-loc2(match(j),3));
                deltaA = abs(loc1(j,4)-loc2(match(j),4));
                conditions = (abs(deltaY)<threshold3) ...
                    * (abs(deltaS)<threshold5) * (deltaA<threshold4);
                if (conditions==1)
                    trX=[trX;deltaX];   % store the X traslation
                    trY=[trY;deltaY];   % store the Y traslation
                    goodMatch(j)=match(j);
                else
                    goodMatch(j)=0;
                end
            end
        end
        if debug
            showMatches(im1,im2,loc1,loc2,goodMatch);
        end
        indexes = {};
        max_p = 0;
        for j=1:length(trX) % for each value of X traslation
            I = find(abs(trX(:)-trX(j))<threshold2/2); % find the traslations 
                                        % contained in the interval [-1.5,1.5]
            if ((length(I)>max_p)&&(mean(trX(I))<size(im1,2)))
                max_p = length(I); % count them
                indexes = I; % save the indexes
            end
        end
        if (size(trX,1)>1)
            trX = mean(trX(indexes)); % compute the mean of the X traslation
            trY = mean(trY(indexes)); % compute the mean of the Y traslation
            again = false;
        else
            if (size(trX,1)==1)
                trX = trX(1);
                trY = trY(1);
                again = false;
            else
                if opt_index>=3
                    error(strcat('findTraslation_opt.m: Not enough matching ',...
                    'translation in findTraslation_opt.m'));
                else
                    opt_index = opt_index + 1;
                end
            end
        end
        %[trX, trY] = RANSAC(match,loc1,loc2);
        s = strcat('Optimization index: (',int2str(opt_index-(again==1)),'); Average across (',...
                int2str(length(indexes)),') traslactions for RANSAC.');
        if debug
            disp(s);
        end
        addOutputSubTitle('findTraslation_opt.m:');
        addOutput(s);        
    end
