function [ out ] = horizontalJoin( im1,im2,l1 )
%horizontalJoin: This function joins 2 images horizontally
%   as simple as that
global glob
    %glob.thrX = 300;
    %glob.thrY = 1000;
    im1original = im1;
    im2original = im2;
    im1g = rgb2gray(im1);
    im2g = rgb2gray(im2);
    im2opt = im2g(1:end,1:floor(end/l1));
    im2black = [im2opt,zeros(size(im2g,1),...
        size(im2g,2)-size(im2opt,2),'uint8')];
    [trX, trY] = findTraslation_opt(im1g,1,im2black,l1);

    %if trX>0
        im1 = imtranslate(im1,[-trX, -trY],'linear','FillValues',0,'OutputView','full');
        im2 = imtranslate(im2,[trX, trY],'linear','FillValues',0,'OutputView','full');
        
%    im4 = imhistmatch(im1,im2);
        im3 = im2;
        for i=1:size(im2,1)
            for j=1:size(im2,2)
                if (i<size(im1,1) && j<size(im1,2) && mean(im1(i,j,:))>0)&&...
                    (im2(i,j)==0 || abs(i-abs(trY))<2 || abs(j-abs(trX))<2)
                    im3(i,j,:)=im1(i,j,:);
                end
            end
        end
        out = im3;
    %{
    else
        im2 = imtranslate(im2,[trX, trY],'linear','FillValues',0,'OutputView','full');
        im3 = im1;
        for i=1:size(im1,1)
            for j=1:size(im1,2)
                if (i<size(im2,1) && j<size(im2,2) && mean(im2(i,j,:))>0)&&...
                    (im1(i,j)==0 || abs(i-abs(trY))<2 || abs(j-abs(trX))<2)
                    im3(i,j,:)=im2(i,j,:);
                end
            end
        end
        out = im3;
    end
    %}
end

