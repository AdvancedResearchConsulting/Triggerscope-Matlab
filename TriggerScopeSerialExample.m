port = 10;
    
portStr = sprintf('COM%d',port);
% Create a serial port object. 
obj1 = instrfind('Type', 'serial', 'Port', portStr, 'Tag', ''); 
% Create the serial port object if it does not exist 
% otherwise use the object that was found. 
if isempty(obj1) 
    s1 = serial(portStr,'BaudRate',115200,'StopBits',1,'Parity','none','Terminator','LF');
else 
    fclose(obj1); 
    s1 = obj1(1);
end 

% open TriggerScope
fopen(s1);    
pause(1);
% read startup string
str = fscanf(s1,'%c'); disp(strtrim(str))

% initialize/comms check
fprintf(s1,'*');
str = fscanf(s1,'%c'); disp(strtrim(str))

% get debug status
fprintf(s1,'STAT?');
str = fscanf(s1,'%c'); disp(strtrim(str))
while(s1.BytesAvailable>0)
    str = fscanf(s1,'%c'); disp(strtrim(str))
end

% set TTL1 to 1
fprintf(s1,'TTL1,1');
str = fscanf(s1,'%c'); disp(strtrim(str))

% set TTL1 to 0
fprintf(s1,'TTL1,0');
str = fscanf(s1,'%c'); disp(strtrim(str))

% close port
fclose(s1)

