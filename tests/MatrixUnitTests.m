%% Test Class Definition
classdef MatrixUnitTests < matlab.unittest.TestCase
    
    % -------------------------------------------------------------------
    % Copyright (c) 2019 Shapelets.io
    %
    % This Source Code Form is subject to the terms of the Mozilla Public
    % License, v. 2.0. If a copy of the MPL was not distributed with this
    % file, You can obtain one at http://mozilla.org/MPL/2.0/.
    % -------------------------------------------------------------------
    
    properties
        delta
    end
    
    methods (TestClassSetup)
        function addLibraryClassToPath(testCase)
            p = path;
            testCase.addTeardown(@path,p);
            addpath ..;
            testCase.delta = 1e-6;
        end
    end
    
    %% Test Method Block
    methods (Test)
        function testFindBestNDiscords(testCase)
           a = khiva.Array(single([11, 10, 11, 10, 11, 10, 11, 10, 11, ...
               10, 11, 10, 11]'));
           b = khiva.Array(single([9, 10.1, 10.2, 10.1, 10.2, 10.1, ...
               10.2, 10.1, 10.2, 10.1, 10.2, 10.1, 9]'));
           [profile, index] = khiva.Matrix.stomp(a, b, 3);
           [~, ~, subsequenceIndices] = khiva.Matrix.findBestNDiscords...
               (profile, index, 3, 2, false);
           expectedIndex = uint32([0 10]');
           indexHost = subsequenceIndices.getData();
           testCase.verifyEqual(indexHost, expectedIndex);
        end

        function testFindBestNDiscordsMultipleProfiles(testCase)
           a = khiva.Array(single([[11, 10, 11, 10, 11, 10, 11, 10, 11, ...
               10, 11, 10, 11]', [11, 10, 11, 10, 11, 10, 11, 10, 11, ...
               10, 11, 10, 11]']));
           b = khiva.Array(single([[9, 10.1, 10.2, 10.1, 10.2, 10.1, ...
               10.2, 10.1, 10.2, 10.1, 10.2, 10.1, 9]', [9, 10.1, 10.2, ...
               10.1, 10.2, 10.1, 10.2, 10.1, 10.2, 10.1, 10.2, 10.1, 9]']));
           [profile, index] = khiva.Matrix.stomp(a, b, 3);
           [~, ~, subsequenceIndices] = khiva.Matrix.findBestNDiscords...
               (profile, index, 3, 2, false);
           expectedIndex(:, :, 1) = uint32([[0, 10]', [0, 10]']);
           expectedIndex(:, :, 2) = uint32([[0, 10]', [0, 10]']);
           indexHost = subsequenceIndices.getData();
           testCase.verifyEqual(indexHost, expectedIndex);
        end

        function testFindBestNDiscordsMirror(testCase)
           a = khiva.Array(single([10, 11, 10, 10, 11, 10]'));
           [profile, index] = khiva.Matrix.stompSelfJoin(a, 3);
           [~, discordsIndices, subsequenceIndices] = ...
               khiva.Matrix.findBestNDiscords(profile, index, 3, 1, true);
           expectedDiscordIndex = uint32(3);
           expectedSubsequenceIndex = uint32(1);
           discordIndexHost = discordsIndices.getData();
           subsequenceIndexHost = subsequenceIndices.getData();
           testCase.verifyEqual(discordIndexHost, expectedDiscordIndex);
           testCase.verifyEqual(subsequenceIndexHost, expectedSubsequenceIndex);
        end

        function testFindBestNDiscordsConsecutive(testCase)
           a = khiva.Array(single([10, 11, 10, 11, 10, 11, 10, 11, 10, ...
               11, 10, 11, 10, 9.999, 9.998]'));
           [profile, index] = khiva.Matrix.stompSelfJoin(a, 3);
           [~, ~, subsequenceIndices] = ...
               khiva.Matrix.findBestNDiscords(profile, index, 3, 2, true);
           expectedSubsequenceIndex = uint32([12, 11]');
           subsequenceIndexHost = subsequenceIndices.getData();
           testCase.verifyEqual(subsequenceIndexHost(1), ...
               expectedSubsequenceIndex(1));
           testCase.verifyNotEqual(subsequenceIndexHost(2), ...
               expectedSubsequenceIndex(2));
        end
        
        function testFindBestNMotifs(testCase)
           a = khiva.Array(single([10, 10, 10, 10, 10, 10, 9, 10, 10, ...
               10, 10, 10, 11, 10, 9]'));
           b = khiva.Array(single([10, 11, 10, 9]'));
           [profile, index] = khiva.Matrix.stomp(a, b, 3);
           [~, motifsIndices, subsequenceIndices] = ...
               khiva.Matrix.findBestNMotifs(profile, index, 3, 1, false);
           expectedMotifsIndex = uint32(12);
           expectedSubsequenceIndex = uint32(1);
           motifsIndexHost = motifsIndices.getData();
           subsequenceIndexHost = subsequenceIndices.getData();
           testCase.verifyEqual(motifsIndexHost, expectedMotifsIndex);
           testCase.verifyEqual(subsequenceIndexHost, expectedSubsequenceIndex);
        end
        
        function testFindBestNMotifsMultipleProfiles(testCase)
           a = khiva.Array(single([[10, 10, 10, 10, 10, 10, 9, 10, 10, ...
               10, 10, 10, 11, 10, 9]', [10, 10, 10, 10, 10, 10, 9, 10, ...
               10, 10, 10, 10, 11, 10, 9]']));
           b = khiva.Array(single([[10, 11, 10, 9]', [10, 11, 10, 9]']));
           [profile, index] = khiva.Matrix.stomp(a, b, 3);
           [~, motifsIndices, subsequenceIndices] = ...
               khiva.Matrix.findBestNMotifs(profile, index, 3, 1, false);
           expectedMotifsIndex(:, :, 1) = uint32([12, 12]);
           expectedMotifsIndex(:, :, 2) = uint32([12, 12]);
           expectedSubsequenceIndex(:, :, 1) = uint32([1, 1]);
           expectedSubsequenceIndex(:, :, 2) = uint32([1, 1]);
           motifsIndexHost = motifsIndices.getData();
           subsequenceIndexHost = subsequenceIndices.getData();
           testCase.verifyEqual(motifsIndexHost, expectedMotifsIndex);
           testCase.verifyEqual(subsequenceIndexHost, expectedSubsequenceIndex);
        end
        
        function testFindBestNMotifsMirror(testCase)
           a = khiva.Array(single([10.1, 11, 10.2, 10.15, 10.775, ...
               10.1, 11, 10.2]'));
           [profile, index] = khiva.Matrix.stompSelfJoin(a, 3);
           [~, discordsIndices, subsequenceIndices] = ...
               khiva.Matrix.findBestNMotifs(profile, index, 3, 2, true);
           expectedDiscordIndex = uint32([0, 0]');
           expectedSubsequenceIndex = uint32([5, 3]');
           discordIndexHost = discordsIndices.getData();
           subsequenceIndexHost = subsequenceIndices.getData();
           testCase.verifyEqual(discordIndexHost, expectedDiscordIndex);
           testCase.verifyEqual(subsequenceIndexHost, expectedSubsequenceIndex);
        end
        
        function testFindBestNMotifsConsecutive(testCase)
           a = khiva.Array(single([10.1, 11, 10.1, 10.15, 10.075, 10.1, ...
               11, 10.1, 10.15]'));
           [profile, index] = khiva.Matrix.stompSelfJoin(a, 3);
           [~, discordsIndices, subsequenceIndices] = ...
               khiva.Matrix.findBestNMotifs(profile, index, 3, 2, true);
           expectedDiscordIndex = uint32(6);
           expectedSubsequenceIndex = uint32(3);
           discordIndexHost = discordsIndices.getData();
           subsequenceIndexHost = subsequenceIndices.getData();
           testCase.verifyEqual(discordIndexHost(2), expectedDiscordIndex);
           testCase.verifyEqual(subsequenceIndexHost(2), expectedSubsequenceIndex);
        end
        
        function testStomp(testCase)
           a = khiva.Array(single([[10, 11, 10, 11]', [10, 11, 10, 11]']));
           b = khiva.Array(single([[10, 11, 10, 11, 10, 11, 10, 11]', ...
               [10, 11, 10, 11, 10, 11, 10, 11]']));
           [profile, index] = khiva.Matrix.stomp(a, b, 3);
           expectedIndex = zeros([6, 2, 2, 1], 'uint32');
           expectedIndex(:,:,1) = [[0, 1, 0, 1, 0, 1]', [0, 1, 0, 1, 0, 1]'];
           expectedIndex(:,:,2) = [[0, 1, 0, 1, 0, 1]', [0, 1, 0, 1, 0, 1]'];
           expectedProfile = single(expectedIndex * 0.0);
           profileHost = profile.getData();
           indexHost = index.getData();
           diffProfile = abs(profileHost - expectedProfile);
           testCase.verifyLessThanOrEqual(diffProfile, 1e-2);
           testCase.verifyEqual(indexHost, expectedIndex);
        end
        
        function testStompSelfJoin(testCase)
           a = khiva.Array(single([[10, 10, 11, 11, 10, 11, 10, 10, 11, 11, ...
               10, 11, 10, 10]',[11, 10, 10, 11, 10, 11, 11, 10, 11, 11, ...
               10, 10, 11, 10]']));
           [profile, index] = khiva.Matrix.stompSelfJoin(a, 3);
           expectedIndex = uint32([[6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5]', ...
               [9, 10, 11, 6, 7, 8, 3, 4, 5, 0, 1, 2]']);
           expectedProfile = single(expectedIndex * 0.0);
           profileHost = profile.getData();
           indexHost = index.getData();
           diffProfile = abs(profileHost - expectedProfile);
           testCase.verifyLessThanOrEqual(diffProfile, 1e-2);
           testCase.verifyEqual(indexHost, expectedIndex);
        end
    end
end
