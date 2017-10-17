function [ out ] = roundVerticalSize( im )
%roundSize Arrotonda la dimensione y dell'immagine al centinaio successivo
%   Riempie di nero
global glob
[y1,x1,z] = size(im);
%y2 = glob.roundVerticalSize;
i=0; black = true;
while i<y1 && black
    i = i+1;
    for j=1:x1
        black = black && mean(im(i,j,:))==0;
    end
end
im = im(i:end,:,:);
i=size(im,1); black = true;
while i>0 && black
    i=i-1;
    for j=1:x1
        black = black && mean(im(i,j,:))==0;
    end
end
im = im(1:i,:,:);
out = im;
