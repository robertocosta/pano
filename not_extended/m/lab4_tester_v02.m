clear all;
close all;
defineGlobals;
global transaction_type
global algorithm_type
global output
global path

transaction={'linear','inverse-centerDistance'};
algorithm = {'non-recoursive','recoursive'};
addOutputTitle(char(strcat('Transaction: ',transaction(transaction_type))));
addOutputTitle(char(strcat('Algorithm: ',algorithm(algorithm_type))));
im_path = getImagesPaths;

% manual exposure
t = cputime;

if (algorithm_type==1)
    imTot = stich(im_path);
else
    imTot = stich_recoursive(im_path);
end
elapsed_A = cputime-t;
s = char(strcat('Elapsed CPU time (Exposure: manual, transaction:',...
    transaction(transaction_type),', algorithm:',algorithm(algorithm_type),...
    ')=',num2str(elapsed_A)));
disp(s);
addOutputSubTitle('lab4_tester_v02.m:');
addOutput(s);
% Cropping
addOutputTitle('Cropping');
imTot = crop(im_path,imTot);
% Saving
p=strsplit(path,'/');
imageFile1 = char(strcat(p(length(p)-1),'_pano_',algorithm(algorithm_type),'_',...
    transaction(transaction_type),'.jpg'));
addOutputSubTitle(strcat('Saving: ',imageFile1));
imwrite(imTot,imageFile1);

disp(char(output));
dlmcell(strcat('out_',imageFile1,'_',datestr(now,'yyyy.mm.dd_HH.MM.SS'),'.txt'),output);
