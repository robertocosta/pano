function Itot = stich(I)
n = size(I,1);
switch n
    case 1
        Itot = I{1};
    case 2
        Itot = {sift_mosaic(I{1},I{2});sift_mosaic(I{2},I{1})};
    otherwise
        m = floor(n/2);
        Itot = I{m};
        for i=m-1:-1:1
            Itot = sift_mosaic(Itot,I{i});
            Itot = sift_mosaic(Itot,I{n-i-mod(n,2));
        end
        if mod(n,2)
            Itot = sift_mosaic(Itot,I{n});
        end
end