clear all;
close all;
clc;
files = 'D:\CV Project\Optical flow/trimmed_1.mp4';
videoRead = vision.VideoFileReader(files, 'VideoOutputDataType', 'uint8');
Flow_LK = opticalFlowLK('NoiseThreshold', 0.009);
videoPlayer = vision.VideoPlayer('Position', [100, 100, 680, 520]);
i = 0;
while ~isDone(videoRead)
    i = i+1    
    frame = videoRead();    
    flow_calc = estimateFlow(Flow_LK, rgb2gray(frame)); 
    % Display the optical flow vectors
    %imshow(frame); 
    %hold on;
    plot(flow_calc, 'DecimationFactor', [5 5], 'ScaleFactor', 10);
    hold off;   
    videoPlayer(frame);
    filename_real = "D:\CV Project\Video Frames\flows/flow_"+i+".mat"
    save(filename_real, "flow")
end
release(videoRead);
release(videoPlayer);
