%% Test Class Definition
classdef DistancesUnitTests < matlab.unittest.TestCase
    
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
        function testDtw(testCase)
            a = khiva.Array([[1, 1, 1, 1, 1]', [2, 2, 2, 2, 2]', [3, 3, 3, 3, 3]', [4, 4, 4, 4, 4]', [5, 5, 5, 5, 5]']);
            b = khiva.Distances.dtw(a);
            expected = [0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 10, 5, 0, 0, 0, 15, 10, 5, 0, 0, 20, 15, 10, 5, 0];
            c = b.getData();
            diff = abs(reshape(c,1,[]) - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testDtw2(testCase)
            a = khiva.Array([[1, 1, 1, 1, 1]', [2, 2, 2, 2, 2]', [3, 3, 3, 3, 3]', [4, 4, 4, 4, 4]', [5, 5, 5, 5, 5]']);
            b = khiva.Distances.dtw(a);
            expected = [0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 10, 5, 0, 0, 0, 15, 10, 5, 0, 0, 20, 15, 10, 5, 0];
            c = b.getData();
            diff = abs(reshape(c,1,[]) - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testEuclidean(testCase)
            a = khiva.Array([[0, 1, 2, 3]',[ 4, 5, 6, 7]', [8, 9, 10, 11]']);
            b = khiva.Distances.euclidean(a);
            expected = [0, 0, 0, 8, 0, 0, 16, 8, 0];
            c = b.getData();
            diff = abs(reshape(c,1,[]) - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testHamming(testCase)
            a = khiva.Array([[1, 1, 1, 1, 1]', [2, 2, 2, 2, 2]', [3, 3, 3, 3, 3]', [4, 4, 4, 4, 4]', [5, 5, 5, 5, 5]']);
            b = khiva.Distances.hamming(a);
            expected = [[0, 0, 0, 0, 0]', [5, 0, 0, 0, 0]', [5, 5, 0, 0, 0]', [5, 5, 5, 0, 0]', [5, 5, 5, 5, 0]'];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testManhattan(testCase)
            a = khiva.Array([[1, 1, 1, 1, 1]', [2, 2, 2, 2, 2]', [3, 3, 3, 3, 3]', [4, 4, 4, 4, 4]', [5, 5, 5, 5, 5]']);
            b = khiva.Distances.manhattan(a);
            expected = [[0, 0, 0, 0, 0]', [5, 0, 0, 0, 0]', [10, 5, 0, 0, 0]', [15, 10, 5, 0, 0]', [20, 15, 10, 5, 0]'];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end

        function testSBD(testCase)
            a = khiva.Array([[1, 2, 3, 4, 5]',[ 1, 1, 0, 1, 1]', [10, 12, 0, 0, 1]']);
            b = khiva.Distances.sbd(a);
            expected = [0, 0, 0, 0.505025, 0, 0, 0.458583, 0.564093, 0];
            c = b.getData();
            diff = abs(reshape(c,1,[]) - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
                
        function testSquaredEuclidean(testCase)
            a = khiva.Array([[0, 1, 2, 3]',[ 4, 5, 6, 7]', [8, 9, 10, 11]']);
            b = khiva.Distances.squaredEuclidean(a);
            expected = [0, 0, 0, 64, 0, 0, 256, 64, 0];
            c = b.getData();
            diff = abs(reshape(c,1,[]) - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
    end
end
        