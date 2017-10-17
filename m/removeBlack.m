function Iout = removeBlack(Iin)
y1=1;
black = true;
while black && y1<size(Iin,1)/2
    cont = length(find(Iin(y1,:,:)==0));
    cont = cont + length(find(isnan(Iin(y1,:,:))));
    cont = cont + length(find(Iin(y1,:,:)==1));
    black = cont==numel(Iin(y1,:,:));
    y1 = y1+1;
end
y2=size(Iin,1);
black = true;
while black && y2>size(Iin,1)/2
    cont = length(find(Iin(y2,:,:)==0));
    cont = cont + length(find(isnan(Iin(y2,:,:))));
    cont = cont + length(find(Iin(y2,:,:)==1));
    black = cont==numel(Iin(y2,:,:));
    y2 = y2-1;
end
x1 = 1;
black = true;
while black && x1<size(Iin,2)/2
    cont = length(find(Iin(:,x1,:)==0));
    cont = cont + length(find(isnan(Iin(:,x1,:))));
    cont = cont + length(find(Iin(:,x1,:)==1));
    black = cont==numel(Iin(:,x1,:));
    x1 = x1+1;
end
x2=size(Iin,2);
black = true;
while black && x2>size(Iin,2)/2
    cont = length(find(Iin(:,x2,:)==0));
    cont = cont + length(find(isnan(Iin(:,x2,:))));
    cont = cont + length(find(Iin(:,x2,:)==1));
    black = cont==numel(Iin(:,x2,:));
    x2 = x2-1;
end
Iout = Iin(y1:y2,x1:x2,:);