function hCheckWLANNodesConfiguration(wlanNodes)
%hCheckWLANNodesConfiguration Checks if the bandwidth, MACFrameAbstraction,
%and PHYAbstractionMethod are configured correctly for all the input WLAN
%nodes
%
%   hCheckWLANNodesConfiguration(WLANNODES) checks if all the nodes have
%   the same values for MACFrameAbstraction and PHYAbstractionMethod
%   properties. It also checks if all the WLAN devices operating on the
%   same channel frequency have the same channel bandwidth.
%
%   WLANNODES is an array or cell array of objects of type <a href="matlab:help('wlanNode')">wlanNode</a>.

%   Copyright 2022-2023 The MathWorks, Inc.

% Validate WLAN node inputs
if iscell(wlanNodes)
    for idx = 1:numel(wlanNodes)
        validateattributes(wlanNodes{idx}, "wlanNode", {'scalar'});
    end
    wlanNodes = [wlanNodes{:}];
else
    validateattributes(wlanNodes(1), "wlanNode", {'scalar'});
end

numDevices = numel([wlanNodes(:).DeviceConfig]);
freqBWPairs = zeros(2,numDevices);
deviceCount = 1;
for nodeID = 1:numel(wlanNodes)
    if nodeID>1
        if wlanNodes(nodeID).MACFrameAbstraction ~= wlanNodes(1).MACFrameAbstraction
            error("hCheckWLANNodesConfiguration:MACFrameAbstractionMismatch","All nodes must have the same MACFrameAbstraction value.");
        end

        if ~strcmp(wlanNodes(nodeID).PHYAbstractionMethod,wlanNodes(1).PHYAbstractionMethod)
            error("hCheckWLANNodesConfiguration:PHYAbstractionMethodMismatch","All nodes must have the same PHYAbstractionMethod.");
        end

        if wlanNodes(nodeID).DeviceConfig.MPDUAggregationLimit ~= wlanNodes(1).DeviceConfig.MPDUAggregationLimit
            error("hCheckWLANNodesConfiguration:MPDUAggregationLimitMismatch","All nodes must have the same value of MPDUAggregationLimit.");
        end
    end

    endIndex = numel([wlanNodes(nodeID).DeviceConfig(:)])-1;
    freqBWPairs(1,deviceCount:deviceCount+endIndex) = [wlanNodes(nodeID).DeviceConfig(:).ChannelFrequency];
    freqBWPairs(2,deviceCount:deviceCount+endIndex) = [wlanNodes(nodeID).DeviceConfig(:).ChannelBandwidth];
    deviceCount = deviceCount+endIndex+1;
end

freqBWPairs = sortrows(freqBWPairs.',[1 2]);
uniqueFreqBWPairs = unique(freqBWPairs,'rows');

for freqID = 1:numel(uniqueFreqBWPairs(:,1))-1
    if uniqueFreqBWPairs(freqID,:) == uniqueFreqBWPairs(freqID+1,:)
        continue;
    else
        if uniqueFreqBWPairs(freqID,1) ~= uniqueFreqBWPairs(freqID+1,1) %Check for frequency mismatch
            continue; %Continue since there can be multiple frequencies
        elseif uniqueFreqBWPairs(freqID,2) ~= uniqueFreqBWPairs(freqID+1,2) % Check for bandwidth mismatch
            error("hCheckWLANNodesConfiguration:BandwidthMismatch","Nodes operating in the same channel frequency must have the same channel bandwidth.");
        end
    end
end

% Suppress warning for LSIG check failure
warningsToSuppress = "wlan:wlanFormatDetect:LSIGCheckFail";
warning('off',warningsToSuppress);
end