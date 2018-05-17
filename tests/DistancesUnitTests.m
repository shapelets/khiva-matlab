%% Test Class Definition
classdef DistancesUnitTests < matlab.unittest.TestCase
    
    % -------------------------------------------------------------------
    % Copyright (c) 2018 Grumpy Cat Software S.L.
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
        function testDtw(testCase)
            a = tsa.Array([[1, 1, 1, 1, 1]', [2, 2, 2, 2, 2]', [3, 3, 3, 3, 3]', [4, 4, 4, 4, 4]', [5, 5, 5, 5, 5]']);
            b = tsa.Distances.dtw(a);
            expected = [0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 10, 5, 0, 0, 0, 15, 10, 5, 0, 0, 20, 15, 10, 5, 0];
            c = b.getData();
            diff = abs(reshape(c,1,[]) - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testDtw2(testCase)
            a = tsa.Array([[1, 1, 1, 1, 1]', [2, 2, 2, 2, 2]', [3, 3, 3, 3, 3]', [4, 4, 4, 4, 4]', [5, 5, 5, 5, 5]']);
            b = tsa.Distances.dtw(a);
            expected = [0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 10, 5, 0, 0, 0, 15, 10, 5, 0, 0, 20, 15, 10, 5, 0];
            c = b.getData();
            diff = abs(reshape(c,1,[]) - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testEuclidean(testCase)
            a = tsa.Array([[0, 1, 2, 3]',[ 4, 5, 6, 7]', [8, 9, 10, 11]']);
            b = tsa.Distances.euclidean(a);
            expected = [0, 0, 0, 8, 0, 0, 16, 8, 0];
            c = b.getData();
            diff = abs(reshape(c,1,[]) - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testHamming(testCase)
            a = tsa.Array([[1, 1, 1, 1, 1]', [2, 2, 2, 2, 2]', [3, 3, 3, 3, 3]', [4, 4, 4, 4, 4]', [5, 5, 5, 5, 5]']);
            b = tsa.Distances.hamming(a);
            expected = [[0, 0, 0, 0, 0]', [5, 0, 0, 0, 0]', [5, 5, 0, 0, 0]', [5, 5, 5, 0, 0]', [5, 5, 5, 5, 0]'];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testManhattan(testCase)
            a = tsa.Array([[1, 1, 1, 1, 1]', [2, 2, 2, 2, 2]', [3, 3, 3, 3, 3]', [4, 4, 4, 4, 4]', [5, 5, 5, 5, 5]']);
            b = tsa.Distances.manhattan(a);
            expected = [[0, 0, 0, 0, 0]', [5, 0, 0, 0, 0]', [10, 5, 0, 0, 0]', [15, 10, 5, 0, 0]', [20, 15, 10, 5, 0]'];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
                
        function testSquaredEuclidean(testCase)
            a = tsa.Array([[0, 1, 2, 3]',[ 4, 5, 6, 7]', [8, 9, 10, 11]']);
            b = tsa.Distances.squaredEuclidean(a);
            expected = [0, 0, 0, 64, 0, 0, 256, 64, 0];
            c = b.getData();
            diff = abs(reshape(c,1,[]) - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
    end
end
        