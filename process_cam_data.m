
vidDevice = evalin('base', 'vidDevice');
redThresh = evalin('base', 'redThresh');
greenThresh = evalin('base', 'greenThresh');
blueThresh = evalin('base', 'blueThresh');
yellowThresh1 = evalin('base', 'yellowThresh1');
yellowThresh2 = evalin('base', 'yellowThresh2');
pinkThresh = evalin('base', 'pinkThresh');
htextinsRed = evalin('base', 'htextinsRed');
htextinsGreen = evalin('base', 'htextinsGreen');
htextinsBlue = evalin('base', 'htextinsBlue');
htextinsYellow = evalin('base', 'htextinsYellow');
htextinsCent = evalin('base', 'htextinsCent');
htextinsPink = evalin('base', 'htextinsPink');
hblob = evalin('base', 'hblob');
hshapeinsBox = evalin('base', 'hshapeinsBox');
hVideoIn = evalin('base', 'hVideoIn');

    
    rgbFrame = step(vidDevice); % Acquire single frame
        
    diffFrameRed = imsubtract(rgbFrame(:,:,1), rgb2gray(rgbFrame)); % Get red component of the image
    diffFrameRed = medfilt2(diffFrameRed, [3 3]); % Filter out the noise by using median filter
    binFrameRed = im2bw(diffFrameRed, redThresh); % Convert the image into binary image with the red objects as white
    
    diffFrameGreen = imsubtract(rgbFrame(:,:,2), rgb2gray(rgbFrame)); % Get green component of the image
    diffFrameGreen = medfilt2(diffFrameGreen, [3 3]); % Filter out the noise by using median filter
    binFrameGreen = im2bw(diffFrameGreen, greenThresh); % Convert the image into binary image with the green objects as white
    
    diffFrameBlue = imsubtract(rgbFrame(:,:,3), rgb2gray(rgbFrame)); % Get blue component of the image
    diffFrameBlue = medfilt2(diffFrameBlue, [3 3]); % Filter out the noise by using median filter
    binFrameBlue = im2bw(diffFrameBlue, blueThresh); % Convert the image into binary image with the blue objects as white
    
    binFrameYellow = im2bw(diffFrameRed, yellowThresh1) & im2bw(diffFrameGreen, yellowThresh2);
    [centroidYellow, bboxYellow] = step(hblob, binFrameYellow); % Get the centroids and bounding boxes of the yellow blobs
    centroidYellow = uint16(centroidYellow); % Convert the centroids into Integer for further steps 
      
    binFramePink   = xor(im2bw(diffFrameRed, redThresh) , im2bw(diffFrameRed, pinkThresh));
    [centroidPink, bboxPink] = step(hblob, binFramePink); % Get the centroids and bounding boxes of the pink blobs
    centroidPink = uint16(centroidPink); % Convert the centroids into Integer for further steps 
    
        
    [centroidRed, bboxRed] = step(hblob, binFrameRed); % Get the centroids and bounding boxes of the red blobs
    centroidRed = uint16(centroidRed); % Convert the centroids into Integer for further steps 
    
    
    [centroidGreen, bboxGreen] = step(hblob, binFrameGreen); % Get the centroids and bounding boxes of the green blobs
    centroidGreen = uint16(centroidGreen); % Convert the centroids into Integer for further steps 
    
    
    [centroidBlue, bboxBlue] = step(hblob, binFrameBlue); % Get the centroids and bounding boxes of the blue blobs
    centroidBlue = uint16(centroidBlue); % Convert the centroids into Integer for further steps 
    
    
   data_to_send = [];
   for i = 1:1:length(bboxRed(:,1))
    dummyx(i) = centroidRed(i,1);  
    dummyy(i) = centroidRed(i,2);
    size(i) = (bboxRed(i,3) + bboxRed(i,4))/2; 
   end
   if(length(bboxRed(:,1)) == 2)
       [val,ind_max] = max(size);
       [val,ind_min] = min(size);
    data_to_send = [data_to_send dummyx(ind_max) dummyy(ind_max) dummyx(ind_min) dummyy(ind_min)];  
   else
     data_to_send = [];
   end
   
   for i = 1:1:length(bboxGreen(:,1))
    dummyx(i) = centroidGreen(i,1);  
    dummyy(i) = centroidGreen(i,2);
    size(i) = (bboxGreen(i,3) + bboxGreen(i,4))/2; 
   end
   if(length(bboxGreen(:,1)) == 2)
       [val,ind_max] = max(size);
       [val,ind_min] = min(size);
    data_to_send = [data_to_send dummyx(ind_max) dummyy(ind_max) dummyx(ind_min) dummyy(ind_min)];  
   else
     data_to_send = [];
   end

      for i = 1:1:length(bboxBlue(:,1))
    dummyx(i) = centroidBlue(i,1);  
    dummyy(i) = centroidBlue(i,2);
    size(i) = (bboxBlue(i,3) + bboxBlue(i,4))/2; 
   end
   if(length(bboxBlue(:,1)) == 2)
       [val,ind_max] = max(size);
       [val,ind_min] = min(size);
    data_to_send = [data_to_send dummyx(ind_max) dummyy(ind_max) dummyx(ind_min) dummyy(ind_min)];  
   else
     data_to_send = [];
   end
   
   
      for i = 1:1:length(bboxYellow(:,1))
    dummyx(i) = centroidYellow(i,1);  
    dummyy(i) = centroidYellow(i,2);
    size(i) = (bboxYellow(i,3) + bboxYellow(i,4))/2; 
   end
   if(length(bboxYellow(:,1)) == 2)
       [val,ind_max] = max(size);
       [val,ind_min] = min(size);
    data_to_send = [data_to_send dummyx(ind_max) dummyy(ind_max) dummyx(ind_min) dummyy(ind_min)];  
   else
     data_to_send = [];
   end
   
      for i = 1:1:length(bboxPink(:,1))
    dummyx(i) = centroidPink(i,1);  
    dummyy(i) = centroidPink(i,2);
    size(i) = (bboxPink(i,3) + bboxPink(i,4))/2; 
   end
   if(length(bboxPink(:,1)) == 2)
       [val,ind_max] = max(size);
       [val,ind_min] = min(size);
    data_to_send = [data_to_send dummyx(ind_max) dummyy(ind_max) dummyx(ind_min) dummyy(ind_min)];  
   else
     data_to_send = [];
   end
   data_to_send;
   cam_data = data_to_send;
   assignin('base', 'cam_data', cam_data);
   rgbFrame(1:80,1:90,:) = 0; % put a black region on the output stream

    vidIn = step(hshapeinsBox, rgbFrame, bboxRed, single([1 0 0])); % Instert the red box
    vidIn = step(hshapeinsBox, vidIn, bboxYellow, single([1 1 0])); % Instert the yellow box
    vidIn = step(hshapeinsBox, vidIn, bboxPink, single([1 0 1])); % Instert the pink box
    vidIn = step(hshapeinsBox, vidIn, bboxGreen, single([0 1 0])); % Instert the green box
    vidIn = step(hshapeinsBox, vidIn, bboxBlue, single([0 0 1])); % Instert the blue box
    
    for object = 1:1:length(bboxRed(:,1)) % Write the corresponding centroids for red
        centXRed = centroidRed(object,1); centYRed = centroidRed(object,2);
        vidIn = step(htextinsCent, vidIn, [centXRed centYRed], [centXRed-6 centYRed-9]); 
    end
    for object = 1:1:length(bboxGreen(:,1)) % Write the corresponding centroids for green
        centXGreen = centroidGreen(object,1); centYGreen = centroidGreen(object,2);
        vidIn = step(htextinsCent, vidIn, [centXGreen centYGreen], [centXGreen-6 centYGreen-9]); 
    end
    for object = 1:1:length(bboxBlue(:,1)) % Write the corresponding centroids for blue
        centXBlue = centroidBlue(object,1); centYBlue = centroidBlue(object,2);
        vidIn = step(htextinsCent, vidIn, [centXBlue centYBlue], [centXBlue-6 centYBlue-9]); 
    end
    for object = 1:1:length(bboxPink(:,1)) % Write the corresponding centroids for pink
        centXPink = centroidPink(object,1); centYPink = centroidPink(object,2);
        vidIn = step(htextinsCent, vidIn, [centXPink centYPink], [centXPink-6 centYPink-9]); 
    end
    for object = 1:1:length(bboxYellow(:,1)) % Write the corresponding centroids for pink
        centXYellow = centroidYellow(object,1); centYYellow = centroidYellow(object,2);
        vidIn = step(htextinsCent, vidIn, [centXYellow centYYellow], [centXYellow-6 centYYellow-9]); 
    end
      
    vidIn = step(htextinsRed, vidIn, uint8(length(bboxRed(:,1)))); % Count the number of red blobs
    vidIn = step(htextinsGreen, vidIn, uint8(length(bboxGreen(:,1)))); % Count the number of green blobs
    vidIn = step(htextinsBlue, vidIn, uint8(length(bboxBlue(:,1)))); % Count the number of blue blobs
    vidIn = step(htextinsPink, vidIn, uint8(length(bboxPink(:,1)))); % Count the number of pink blobs
    vidIn = step(htextinsYellow, vidIn, uint8(length(bboxYellow(:,1)))); % Count the number of yellow blobs
   
    step(hVideoIn, vidIn); % Output video stream
    %nFrame = nFrame+1;