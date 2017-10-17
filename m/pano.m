function [ out ] = pano( in )
global glob
    % funzione sfera: (x-x0)^2+(y-y0)^2+(z-z0)^2=r^2
    % x^2+y^2+z^2=glob.rSfera;
    % x = glob.rSfera*sin alpha*cos fi
    % y = glob.rSfera*sin alpha*sin fi
    % z = glob.rSfera*cos alpha
    % x^2+y^2+z^2+ax+by+cz+d=0
    % centro C(-a/2,-b/2,-c/2)
    % http://it.mathworks.com/help/matlab/ref/scatter3.html
    scatter3(
end

