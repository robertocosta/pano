function projectedI = projectIS(image)
global glob
image = rgb2gray(image);
[h, w] = size(image);
d = w/2/tan(glob.alpha);
h/2/tan(glob.beta);
rx = sqrt(d^2+w^2/4);
ry = sqrt(d^2+h^2/4);
projectedI = single(zeros(size(image)));
padding = 100;
image = [zeros(padding/2,size(image,2)+padding);
    zeros(size(image,1),padding/2),image,zeros(size(image,1),padding/2);
    zeros(padding/2,size(image,2)+padding)];
for i=1:size(projectedI,1)
    for j=1:size(projectedI,2)
        x1 = j-w/2;
        y1 = i-h/2;
        x2 = d*tan(x1/rx);
        y2 = d*tan(y1/ry);
        %x3 = 
        projectedI(i,j) = image(round(y2+h/2),round(x2+w/2));
    end
end
projectedI = removeBlack(projectedI);
    