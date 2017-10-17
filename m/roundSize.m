function [ out ] = roundSize( im )
%roundSize Arrotonda la dimensione dell'immagine al centinaio successivo
%   Riempie di nero
global glob
[y1,x1,z] = size(im);
x2 = glob.roundSize.x;
y2 = glob.roundSize.y;
out = zeros(y2,x2,z,'uint8');
fromI = floor((y2-y1)/2);
fromJ = floor((x2-x1)/2);
for i=fromI+1:fromI+size(im,1)
    for j=fromJ+1:fromJ+size(im,2)
        out(i,j,:)=im(i-fromI,j-fromJ,:);
    end
end
end

