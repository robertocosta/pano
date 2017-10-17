function frameOut = purge(frameIn, Itot)
index = 1;
for i=1:size(frameIn,2)
    if Itot(round(frameIn(2,i)),round(frameIn(1,i))) ~= 0
        frameOut(1:3,index) = frameIn(:,i);
        index = index + 1;
    end
end
