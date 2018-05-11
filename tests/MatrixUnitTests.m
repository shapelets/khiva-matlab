%% Test Class Definition
classdef MatrixUnitTests < matlab.unittest.TestCase
    
    % -------------------------------------------------------------------
    % Copyright (c) 2018 Grumpy Cat Software S.L.
    %
    % This Source Code Form is subject to the terms of the Mozilla Public
    % License, v. 2.0. If a copy of the MPL was not distributed with this
    % file, You can obtain one at http://mozilla.org/MPL/2.0/.
    % -------------------------------------------------------------------
    
    properties
        lib
        delta
    end
    
    methods (TestClassSetup)
        function addLibraryClassToPath(testCase)
            p = path;
            testCase.addTeardown(@path,p);
            addpath ..;
            import tsa.Array.*
            testCase.lib = tsa.Library.instance();
            testCase.delta = 1e-6;
        end
    end
    
    %% Test Method Block
    methods (Test)
        function testFindBestNDiscords(testCase)
           a = tsa.Array(single([11, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 11]'));
           b = tsa.Array(single([9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 9]'));
           [profile, index] = tsa.Matrix.stomp(a, b, 3);
           [~, ~, subsequenceIndices] = tsa.Matrix.findBestNDiscords(profile, index, 2);
           expectedIndex = uint32([9 0]');
           indexHost = subsequenceIndices.getData();
           testCase.verifyEqual(indexHost, expectedIndex);
        end
        
        function testFindBestNMotifs(testCase)
           a = tsa.Array(single([10, 10, 10, 10, 10, 10, 9, 10, 10, 10, ...
               10, 10, 11, 10, 9]'));
           b = tsa.Array(single([10, 11, 10, 9]'));
           [profile, index] = tsa.Matrix.stomp(a, b, 3);
           [~, motifsIndices, subsequenceIndices] = ...
               tsa.Matrix.findBestNMotifs(profile, index, 2);
           expectedMotifsIndex = uint32([12 11]');
           expectedSubsequenceIndex = uint32([1 0]');
           motifsIndexHost = motifsIndices.getData();
           subsequenceIndexHost = subsequenceIndices.getData();
           testCase.verifyEqual(motifsIndexHost, expectedMotifsIndex);
           testCase.verifyEqual(subsequenceIndexHost, expectedSubsequenceIndex);
        end
        
        function testStomp(testCase)
           a = tsa.Array(single([[10, 11, 10, 11]', [10, 11, 10, 11]']));
           b = tsa.Array(single([[10, 11, 10, 11, 10, 11, 10, 11]', ...
               [10, 11, 10, 11, 10, 11, 10, 11]']));
           [profile, index] = tsa.Matrix.stomp(a, b, 3);
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
           a = tsa.Array(single([[10, 10, 11, 11, 10, 11, 10, 10, 11, 11, ...
               10, 11, 10, 10]',[11, 10, 10, 11, 10, 11, 11, 10, 11, 11, ...
               10, 10, 11, 10]']));
           [profile, index] = tsa.Matrix.stompSelfJoin(a, 3);
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
