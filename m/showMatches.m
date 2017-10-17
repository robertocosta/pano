%{
function showMatches(I1,I2)
% function showMatches(I1,I2,MATCHES)
global glob
matches = glob.matches;
n = glob.nMatches;
scores = glob.scores;
F1 = glob.f1;
F2 = glob.f2;

f1 = figure(1);
set(f1, 'Position', [0 100 glob.plotWidth glob.plotHeight]);
f1.PaperPositionMode = 'auto';
Itot = zeros(max([size(I1,1),size(I2,1)]),size(I1,2)+size(I2,2));
Itot(1:end,1:size(I1,2)) = [zeros(size(I2,1)-size(I1,1),size(I1,2));I1];
Itot(1:end,size(I1,2)+1:end) = [zeros(size(I1,1)-size(I2,1),size(I2,2));I2];
imshow(Itot);

FRAME1 = glob.plotRadius*ones(3,n);
for i=1:n
	FRAME1(1,i) = F1(1,matches(1,i));   % x1
	FRAME1(2,i) = F1(2,matches(1,i));   % y1
    FRAME1(3,i) = glob.plotRadius*min(scores)/scores(i);
end
FRAME1 = purge(FRAME1,Itot);
vl_plotframe(FRAME1);

FRAME2 = glob.plotRadius*ones(3,n);
for i=1:n
	FRAME2(1,i) = F2(1,matches(2,i))+size(I1,2);
	FRAME2(2,i) = F2(2,matches(2,i));
    FRAME2(3,i) = glob.plotRadius*min(scores)/scores(i);
end
FRAME2 = purge(FRAME2,Itot);
vl_plotframe(FRAME2);
n = size(FRAME1,2);
tr = zeros(n,2);
for i = 1: n
    tr(i,:) = [FRAME2(1,i)-FRAME1(1,i),FRAME2(2,i)-FRAME1(2,i)];
    line([FRAME1(1,i) FRAME2(1,i)], ...
        [FRAME1(2,i) FRAME2(2,i)], 'Color', 'g');
end
glob.trX = mean(tr(:,1));
glob.trY = mean(tr(:,2));
%}
function showMatches(im1,im2,loc1,loc2,match)
% Create a new image showing the two images side by side.
        im3 = appendimages(im1,im2);

        % Show a figure with lines joining the accepted matches.
        
        figure('Position', [100 100 size(im3,2) size(im3,1)]);
        colormap('gray');
        imagesc(im3);
        hold on;
        cols1 = size(im1,2);
        for i = 1: size(match,1)
          if (match(i) > 0)
            line([loc1(i,2) loc2(match(i),2)+cols1], ...
                 [loc1(i,1) loc2(match(i),1)], 'Color', 'c');
          end
        end
        hold off;