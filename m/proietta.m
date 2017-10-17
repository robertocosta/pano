function [ out ] = proietta( in )
global glob
% l'output è un array 3D in cui le prime 2 dimensioni rappresentano la
% posizione, la terza dimensione indicizza i dati: 3D=1 => grayscale
% level, 3D=2 => angolo longitudinale dal centro, 3D=3 => angolo
% latitudinale dal centro.
out = cell(length(in),1);
for i=1:length(in)
    %[azimuth,elevation,r] = cart2sph(x,y,z);
    imIn = in{i};
    imOut = zeros(glob.outY,glob.outX,'uint8');
    position = zeros(size(imOut,1),size(imOut,2),2);
    for j=1:size(imOut,1)
        for k=1:size(imOut,2)
            x = glob.planeDistance*tan(k/glob.rX-glob.alpha/180*pi)+glob.imX/2;
            y = glob.planeDistance*tan(j/glob.rY-glob.beta/180*pi)+glob.imY/2;
            %disp(strcat('x=',num2str(x),' ; y=',num2str(y),...
            %    ' ; x1=',int2str(k),' ; y1=',int2str(j)));
            imOut(j,k)=imIn(round(y),round(x));
            position(j,k,1)=2*glob.alpha*k/size(imOut,2)-glob.alpha;    % x
            position(j,k,2)=2*glob.beta*j/size(imOut,1)-glob.beta;      % y
        end
    end
    out{i,1}.im = imOut;
    out{i,1}.pos = position;
end

