function model = generateModelFromRaw(rawFilePath, nSpaces)

    % Offset
    offsetStr = repmat(' ',1,nSpaces);

    % Open wave file
    disp([offsetStr '(1/3) Loading raw file...']);
    
    nChannels = 8; % Eight channels for now
    rawData = readRaw(rawFilePath, nChannels); 
    waveSignal = extractMostPowerfulChannelFromRaw(rawData);
               
    % Parameters
    hopSize = 512;
    frameSize = 1024;
    Fs = 48000;
    window = transpose(generateWindow(frameSize));
    
    % Generate features
    disp([offsetStr '(2/3) Extracting features...']);
    features = generateFeaturesForTraining(waveSignal, hopSize, frameSize, Fs, window);
    
    % Parameters
    nCentroids = 256;
    
    % Generate model
    disp([offsetStr '(3/3) Training model...']);
    model = generateModel(features, nCentroids);
    
return