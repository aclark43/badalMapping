%%% function created to determine what sized stimulus subjects where
%%% ACTUALLY viewing given any error in badal reading. If dealing with the
%%% reversed badal condtiion, CONIDTION = 1. If instead the calculator
%%% reading was changed and the wrong side of the lens was read, CONDITION
%%% = 2. 

%%% Written by Ashley M. Clark, 12/18/2023

CONDITION = 2;
% T = PixelAngle12122023;
allScreenDist = [T.VirtualScreenDistanceasRecordedinEyeRISmm];

if CONDITION == 1
    
    % vsd_Recorded = readScreenDistanceFromExcel;
    % T = readtable("PixelAngle_12122023.xls");
    idxFlippedBadalRail = 1:8;
    vsdEyeris = allScreenDist(idxFlippedBadalRail)';
    rangeMap = [min(vsdEyeris):1:max(vsdEyeris)];
    
    
    correctVirtualScreenDist = mapOutAcutalBadalValsReverseRail(vsdEyeris);
    
    
elseif CONDITION == 2
    
    idxWrongReading = 25:28;
    allScreenDist = [T.VirtualScreenDistanceasRecordedinEyeRISmm];
    rangeMap = [min(vsdEyeris):1:max(vsdEyeris)];
    vsdEyeris = allScreenDist(idxWrongReading)';

    correctVirtualScreenDist = mapOutAcutalBadalValsWrongReading(vsdEyeris);

    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function correctVirtualScreenDistance = mapOutAcutalBadalValsReverseRail(vsdEyeris)

allBadalVals = 1:400;

for i = 1:length(allBadalVals)
    calcScreenDistFromLensDist(i) = BadalCalculator_12182023(allBadalVals(i),5100);
end

figure;
plot(allBadalVals,calcScreenDistFromLensDist)
xlabel('All Badal Screen Diff')
ylabel('nvd calculated')

for s = 1:length(vsdEyeris)
    distanceInput(s) = allBadalVals(find(calcScreenDistFromLensDist == vsdEyeris(s)));
end

frontLensLocation = distanceInput + 50; %fixed distance on rail

flipToCorrectFrontLensLocation = 450 - frontLensLocation; %flipping the values on the rail

for i = 1:length(flipToCorrectFrontLensLocation)
    correctVirtualScreenDistance(i) = BadalCalculator_12182023(flipToCorrectFrontLensLocation(i),5100);
end

end


function correctVirtualScreenDistance = mapOutAcutalBadalValsWrongReading(vsdEyeris)

allBadalVals = 1:400;

for i = 1:length(allBadalVals)
    calcScreenDistFromLensDist(i) = BadalCalculator_2023_new(allBadalVals(i),5100);
end

figure;
plot(allBadalVals,calcScreenDistFromLensDist)
xlabel('All Badal Screen Diff')
ylabel('nvd calculated')

for s = 1:length(vsdEyeris)
    distanceInput(s) = allBadalVals(find(calcScreenDistFromLensDist == vsdEyeris(s)));
end

% 50 is the size of the railing 
% holding the lens, originally was measuring from back to back, 
% but code at this time was expecting back to front
frontLensLocation = distanceInput + 50; 

flipToCorrectFrontLensLocation = frontLensLocation;

for i = 1:length(flipToCorrectFrontLensLocation)
    correctVirtualScreenDistance(i) = BadalCalculator_2023_new(flipToCorrectFrontLensLocation(i),5100);
end

end


