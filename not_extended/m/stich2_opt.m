function I = stich2_opt(im1,l1,im2,l2)
global debug
global transaction_type
global out
    s = strsplit(out,'\\');
    addOutputSubTitle(strcat('stich2_opt.m:'));
    addOutput(char(s(1)));
    addOutput(char(s(2)));
    [im1, im2] = sameSize(im1,im2);
    [trX, trY] = findTraslation_opt(im1,l1,im2,l2);
    overlap = size(im1,2)-trX;
    im2 = imtranslate(im2,[trX, trY],'linear','FillValues',0,'OutputView','full');
    if (trY<0)
        % add zeros at the beginning of im1
        im1 = [zeros(ceil(trY),size(im1,2));im1];  
    else
        % add zeros at the end of im1
        im1 = [im1;zeros(ceil(trY),size(im1,2))];
    end
    [im1, im2] = sameSize(im1,im2);
    % now im1 and im2 has the same vertical size
    % the limits of the transition area are
    i1 = size(im1,2)-ceil(overlap);
    i2 =  size(im1,2);
    % coordinates of the center of the 2 images
    c1 = size(im1,2)/2;
    c2 = i1+(size(im2,2)-i1)/2;
    if (i1<=c1), i1 = ceil(c1+1); end
    if (i2>=c2), i2 = ceil(c2-1); end
    
    for i=1:i1-1
        imTot(:,i) = im1(:,i);
    end
    if debug a=[];b=[]; end
    for i=i1:i2
        if (transaction_type==1)
            alpha = (i2-i)/overlap; % line through (i1,1),(i2,0)
            beta = (i-i1)/overlap; % line through (i1,0),(i2,1)
        else
            if (transaction_type==2)
                alpha = (i1-c1)/((i-c1)*l1);
                beta = (c2-i2)/((c2-i)*l2); 
            else
                alpha = 1;
                beta = 1;
            end
        end
        alpha = alpha / (alpha + beta); % normalization
        beta = 1 - alpha;
        if debug a=[a;alpha]; b=[b;beta]; end
        imTot(:,i) = im1(:,i)*alpha + im2(:,i)*beta; % weighted average
    end
    if debug
        figure;
    	stem(1:size(a,1),[a,b]);
    	disp(strcat('a(first)=',num2str(a(1)),';b(last)=',num2str(b(size(b,1)))));
    end
    for i = i2+1:size(im2,2)
        imTot(:,i) = im2(:,i);
    end
    I = imTot;

    