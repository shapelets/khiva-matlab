%% Test Class Definition
classdef ClusteringUnitTests < matlab.unittest.TestCase
    
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
            testCase.delta = 1e-3;
        end
    end
    
    %% Test Method Block
    methods (Test)
        function testKmeans(testCase)
            a = khiva.Array([[0, 1, 2, 3]', [6, 7, 8, 9]', [2, -2, 4, -4]', ...
                [8, 5, 3, 1]', [15, 10, 5, 0]', [7, -7, 1, -1]']);
            [centroids, ~] = khiva.Clustering.kMeans(a, 3, 1e-10, 100);
            expected = [0.0, 0.1667, 0.3333, 0.5, 1.5, -1.5, 0.8333, -0.8333, ...
                4.8333, 3.6667, 2.6667, 1.6667];
            c = centroids.getData();
            diff = abs(reshape(c,1,[]) - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
                 
        function testKshape(testCase)
            a = khiva.Array([[1, 2, 3, 4, 5, 6, 7]', ...
                     [0, 10, 4, 5, 7, -3, 0.0]', ...
                     [-1, 15, -12, 8, 9, 4, 5]', ...
                     [2, 8, 7, -6, -1, 2, 9]', ...
                     [-5, -5, -6, 7, 9, 9, 0]']);
            [centroids, labels] = khiva.Clustering.kShape(a, 3, 1e-10, 100);
            expectedCentroids = [-0.5234, 0.1560, -0.3627, -1.2764, -0.7781, ...
                0.9135, 1.8711, -0.7825, 1.5990,  0.1701,  0.4082,  0.8845, ...
                -1.4969, -0.7825, -0.6278, 1.3812, -2.0090, 0.5022, ...
                0.6278, 0,  0.1256];
            expectedLabels = uint32([0, 1, 2, 0, 0]');
            c = centroids.getData();
            l = labels.getData();
            diff = abs(reshape(c,1,[]) - expectedCentroids);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
            testCase.verifyEqual(l, expectedLabels);
        end
    end
end
        