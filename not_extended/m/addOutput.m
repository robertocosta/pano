function addOutput(s)
    global output
    output(size(output,1)+1,1) = {strcat('----',s)};