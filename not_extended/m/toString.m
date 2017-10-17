function s = toString(S)
    s='';
    for i=1:length(S)
        s1 = strsplit(char(S(i)),'/');
        s = strcat(s,char(s1(length(s1))),';');
    end