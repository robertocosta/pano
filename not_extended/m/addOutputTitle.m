function addOutputTitle(s)
    global output
    lTot = 90;
    l = lTot-length(s);
    sx = l/2 + 0.5*(mod(l,2)==1);
    dx = l/2 - 0.5*(mod(l,2)==1);
    for i=1:sx
        s = strcat('*',s);
    end
    for i=1:dx
        s = strcat(s,'*');
    end
    output(size(output,1)+1,1) = {s};