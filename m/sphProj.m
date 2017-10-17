function [ out ] = sphProj( in )
global glob
%sphProj: Perform spherical projection of color images
%   output is a cell array with the projected images,
%   input is a ImageSet object
    out = cell(in.Count,1);
    imInOriginal = read(in,1);
    defineConstants(in.Count,imInOriginal);
    cameraParams = glob.cameraParams;
    [imIn,~] = undistortImage(imInOriginal,cameraParams);
    %imIn = imInOriginal;
    imOut = zeros(glob.outY,glob.outX,3,'uint8');
    %position = zeros(size(imOut,1),size(imOut,2),2);        
    for j=1:size(imOut,1)
        for k=1:size(imOut,2)
            x = glob.planeDistance*tan(k/glob.rX-glob.alpha/180*pi)+glob.imX/2;
            y = glob.planeDistance*tan(j/glob.rY-glob.beta/180*pi)+glob.imY/2;
            %disp(strcat('x=',num2str(x),' ; y=',num2str(y),...
            %    ' ; x1=',int2str(k),' ; y1=',int2str(j)));
            imOut(j,k,:)=imIn(round(y),round(x),:);
            %position(j,k,1)=2*glob.alpha*k/size(imOut,2)-glob.alpha;    % x
            %vposition(j,k,2)=2*glob.beta*j/size(imOut,1)-glob.beta;      % y
        end
    end
    out{1} = imOut;
    %out{1} = imIn;
    
    for i=2:in.Count
        imInOriginal = read(in,i);
        %imIn = undistortImage(imInOriginal,cameraParams);
        imIn = imInOriginal;
        imOut = zeros(glob.outY,glob.outX,3,'uint8');
        %position = zeros(size(imOut,1),size(imOut,2),2);        
        for j=1:size(imOut,1)
            for k=1:size(imOut,2)
                x = glob.planeDistance*tan(k/glob.rX-glob.alpha/180*pi)+glob.imX/2;
                y = glob.planeDistance*tan(j/glob.rY-glob.beta/180*pi)+glob.imY/2;
                %disp(strcat('x=',num2str(x),' ; y=',num2str(y),...
                %    ' ; x1=',int2str(k),' ; y1=',int2str(j)));
                imOut(j,k,:)=imIn(round(y),round(x),:);
                %position(j,k,1)=2*glob.alpha*k/size(imOut,2)-glob.alpha;    % x
                %vposition(j,k,2)=2*glob.beta*j/size(imOut,1)-glob.beta;      % y
            end
        end
        out{i} = imOut;
        %out{i} = imIn;
    end
    
end

