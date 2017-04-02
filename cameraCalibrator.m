function cameraCalibrator(basis,numImages)
%%mcc -W cpplib:camCalibMatlab -T link:lib cameraCalibrator.m
files = cell(1, numImages);
for i = 1:numImages
    %files{i} = fullfile( 'D:', 'SHARE', 'Lenovo','photo', '3', sprintf('IMG_%d.jpg', i+basis));
    files{i} = fullfile( 'E:', '918', 'Lenovo','photo', '3', sprintf('IMG_%d.jpg', i+basis));
end

% Detect the checkerboard corners in the images.
[imagePoints, boardSize] = detectCheckerboardPoints(files);

% Generate the world coordinates of the checkerboard corners in the
% pattern-centric coordinate system, with the upper-left corner at (0,0).
squareSize = 28; % in millimeters(����Ҫ̫��ȷ�����ҶԽ��ûʲôӰ�죬���������������ܵõ���ͬ�Ľ����
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera.��Ĭ�ϲ���������䣬���������ǰ������
cameraParams = estimateCameraParameters(imagePoints, worldPoints,'EstimateTangentialDistortion',true,'NumRadialDistortionCoefficients',2);
save('cameraParams','cameraParams');

createXml('Intrinsic',cameraParams.IntrinsicMatrix);
createXml('distortion',[cameraParams.RadialDistortion,cameraParams.TangentialDistortion,0]);

% % Evaluate calibration accuracy.
% figure; showReprojectionErrors(cameraParams);
% title('Reprojection Errors');
% 
% % imOrig = imread(fullfile(matlabroot, 'toolbox', 'vision', 'visiondata', ...
% %         'calibration', 'slr', 'image9.jpg'));
% imOrig = imread(fullfile('E:', '918', 'Lenovo','photo', '3','IMG_2452.jpg'));
% % figure; imshow(imOrig);%, 'InitialMagnification', magnification);
% % title('Input Image');
% 
% [im, newOrigin] = undistortImage(imOrig, cameraParams);%, 'OutputView', 'full');
% figure; imshow(im);%, 'InitialMagnification', magnification);
% %figure;imshow(im);
% title('Undistorted Image');
% imwrite(im,'temp.jpg');

end