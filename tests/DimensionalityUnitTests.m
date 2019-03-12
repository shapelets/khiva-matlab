%% Test Class Definition
classdef DimensionalityUnitTests < matlab.unittest.TestCase
    
    % -------------------------------------------------------------------
    % Copyright (c) 2018 Shapelets.io
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
        function testRamerDouglasPeucker(testCase)
           a = khiva.Array(single([[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]', ...
               [0, 0.1, -0.1, 5.0, 6.0, 7.0, 8.1, 9.0, 9.0, 9.0]']));
           b = khiva.Dimensionality.ramerDouglasPeucker(a, 1.0);
           expected = single([[0, 2, 3, 6, 9]', [0, -0.1, 5.0, 8.1, 9.0]']);
           c = b.getData();
           diff = abs(c - expected);
           testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testVisvalingam(testCase)
           a = khiva.Array(single([[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]', ...
               [0, 0.1, -0.1, 5.0, 6.0, 7.0, 8.1, 9.0, 9.0, 9.0]']));
           b = khiva.Dimensionality.visvalingam(a, 5);
           expected = single([[0, 2, 3, 7, 9]', [0, -0.1, 5.0, 9.0, 9.0]']);
           c = b.getData();
           diff = abs(c - expected);
           testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testPaa(testCase)
           a = khiva.Array(single([[0.0, 0.1, -0.1, 5.0, 6.0, 7.0, 8.1, ...
               9.0, 9.0, 9.0]', [0.0, 0.1, -0.1, 5.0, 6.0, 7.0, 8.1, ...
               9.0, 9.0, 9.0]']));
           b = khiva.Dimensionality.paa(a, 5);
           expected = single([[0.05, 2.45, 6.5, 8.55, 9.0]', ...
               [0.05, 2.45, 6.5, 8.55, 9.0]']);
           c = b.getData();
           diff = abs(c - expected);
           testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testSax(testCase)
           a = khiva.Array(single([[0.0, 0.1, -0.1, 5.0, 6.0]', ...
               [7.0, 8.1, 9.0, 9.0, 9.0]']));
           b = khiva.Dimensionality.sax(a, 3);
           expected = [[0.0, 0.1, -0.1, 5.0, 6.0]', ...
               [0.0, 1.0, 2.0, 2.0, 2.0]'];
           c = b.getData();
           diff = abs(c - expected);
           testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testPip(testCase)
           a = khiva.Array(single([[0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, ...
               7.0, 8.0, 9.0]', [0.0, 0.1, -0.1, 5.0, 6.0, 7.0, 8.1, ...
               9.0, 9.0, 9.0]']));
           b = khiva.Dimensionality.pip(a, 6);
           expected = single([[0.0, 2.0, 3.0, 6.0, 7.0, 9.0]', ...
               [0.0, -0.1, 5.0, 8.1, 9.0, 9.0]']);
           c = b.getData();
           diff = abs(c - expected);
           testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testPLABottomUp(testCase)
            a = khiva.Array(single([[0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, ...
                8.0, 9.0]', [0.0, 0.1, -0.1, 5.0, 6.0, 7.0, 8.1, 9.0, ...
                9.0, 9.0]']));
            b = khiva.Dimensionality.plaBottomUp(a, 1);
            expected = single([[0, 1, 2, 3, 4, 7, 8, 9]', ... 
                [0, 0.1, -0.1, 5, 6, 9, 9, 9]']);
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testPLASlidingWindow(testCase)
            a = khiva.Array(single([[0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, ...
                8.0, 9.0]', [0.0, 0.1, -0.1, 5.0, 6.0, 7.0, 8.1, 9.0, ...
                9.0, 9.0]']));
            b = khiva.Dimensionality.plaSlidingWindow(a, 1);
            expected = single([[0, 2, 3, 7, 8, 9]', [0, -0.1, 5, 9, 9, 9]']);
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
    end
end
