vidDevice = imaq.VideoDevice('winvideo', 1, 'RGB24_640x480', ... % Acquire input video stream
                    'ROI', [1 1 640 480], ...
                    'ReturnedColorSpace', 'rgb');
                
vidInfo = imaqhwinfo(vidDevice); % Acquire input video property
hblob = vision.BlobAnalysis('AreaOutputPort', false, ... % Set blob analysis handling
                                'CentroidOutputPort', true, ... 
                                'BoundingBoxOutputPort', true', ...
                                'MinimumBlobArea', 80, ...
                                'MaximumBlobArea', 500, ...
                                'MaximumCount', 10);
                            
                            hshapeinsBox = vision.ShapeInserter('BorderColorSource', 'Input port', ... % Set box handling
                                        'Fill', true, ...
                                        'FillColorSource', 'Input port', ...
                                        'Opacity', 0.4);
circleInserter_red     = vision.ShapeInserter('Shape','Circles','BorderColor','Custom','CustomBorderColor',single([1 0 0]));
circleInserter_green   = vision.ShapeInserter('Shape','Circles','BorderColor','Custom','CustomBorderColor',single([0 1 0]));
circleInserter_blue    = vision.ShapeInserter('Shape','Circles','BorderColor','Custom','CustomBorderColor',single([0 0 1]));
circleInserter_yellow  = vision.ShapeInserter('Shape','Circles','BorderColor','Custom','CustomBorderColor',single([1 1 0]));
circleInserter_cyan    = vision.ShapeInserter('Shape','Circles','BorderColor','Custom','CustomBorderColor',single([0 1 1]));
circleInserter_magenta = vision.ShapeInserter('Shape','Circles','BorderColor','Custom','CustomBorderColor',single([1 0 1]));


htextinsRed = vision.TextInserter('Text', 'Red   : %2d', ... % Set text for number of blobs
                                    'Location',  [5 2], ...
                                    'Color', [1 0 0], ... // red color
                                    'FontSize', 14);
htextinsPink = vision.TextInserter('Text', 'Pink   : %2d', ... % Set text for number of blobs
                                    'Location',  [5 50], ...
                                    'Color', [1 0 1], ... // red color
                                    'FontSize', 14);
                                
htextinsYellow = vision.TextInserter('Text', 'Yellow   : %2d', ... % Set text for number of blobs
                                    'Location',  [5 66], ...
                                    'Color', [1 1 0], ... // red color
                                    'FontSize', 14);
                                
htextinsGreen = vision.TextInserter('Text', 'Green : %2d', ... % Set text for number of blobs
                                    'Location',  [5 18], ...
                                    'Color', [0 1 0], ... // green color
                                    'FontSize', 14);
htextinsBlue = vision.TextInserter('Text', 'Blue  : %2d', ... % Set text for number of blobs
                                    'Location',  [5 34], ...
                                    'Color', [0 0 1], ... // blue color
                                    'FontSize', 14);
htextinsCent = vision.TextInserter('Text', '+      X:%4d, Y:%4d', ... % set text for centroid
                                    'LocationSource', 'Input port', ...
                                    'Color', [1 1 1], ... // white color
                                    'FontSize', 14);
                                
                                
                                
hVideoIn = vision.VideoPlayer('Name', 'Final Video', ... % Output video player
                                'Position', [100 100 vidInfo.MaxWidth+20 vidInfo.MaxHeight+30]);
nFrame = 0; % Frame number initialization


redThresh = 0.30; % Threshold for red detection
greenThresh = 0.10; % Threshold for green detection
blueThresh = 0.15; % Threshold for blue detection
yellowThresh1 = 0.012; %red   part
yellowThresh2 = 0.012; %green part
pinkThresh   = 0.22; %red   part