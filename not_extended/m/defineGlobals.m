function defineGlobals
    global debug
    global transaction_type
    global algorithm_type
    global angle
    global path
    global format
    global length
    global threshold1
    global threshold2
    global threshold3
    global threshold4
    global threshold5
    global output
    global out
    
    debug = false;
    transaction_type = 1; % transaction = {'linear','inverse-centerDistance'};
    algorithm_type = 2; % algorithm = {'non-recoursive','recoursive'};
    
    angle = 22.6;
    path = '../images/kitchen/';
    format = '.bmp';
    length = 22;
    
    %angle = 33;
    %path = '../images/lab_20_4_16_man/';
    %format = '.bmp';
    %length = 12;
    
    threshold1 = 0.6;
    threshold2 = 3; % for X traslaction
    threshold3 = 5; % for Y traslaction
    threshold4 = 1/(2*pi); % for angle condition
    threshold5 = 3; % for scale condition
    
    output = {};
    addOutputTitle('lab4_tester_v02.m');
    addOutputTitle(strcat('out_',datestr(now,'yyyy.mm.dd_HH.MM.SS')));
    addOutputTitle(strcat('Path:',path,';Angle:',num2str(angle)));
    addOutputTitle(strcat('Thresholds:',...
        num2str(threshold1),',',...
        num2str(threshold2),',',...
        num2str(threshold3),',',...
        num2str(threshold4),',',...
        num2str(threshold5)));
    out = '';