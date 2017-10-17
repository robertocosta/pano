function [ out ] = posizionaPixel( in )
global glob
    imIn = in.foto;
    posIn = in.posizione;
    out = cell(length(imIn),1);
    for i=1:length(imIn)
        out{i} = figure;
        hold on;
        im = imIn{i};
        pos = posIn{i};
        for j=1:size(im,1)
            for k=1:size(im,2)
                [x,y,z] = sph2cart(pos(j,k,1),pos(j,k,2),glob.rSfera);
                scatter3(x,y,z,1000,[im(j,k),im(j,k),im(j,k)]/255,'.');
            end
        end
        hold off;
    end

end

