%% Test Class Definition
classdef DimensionalityUnitTests < matlab.unittest.TestCase
    
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
        function testRamerDouglasPeucker(testCase)
           a = tsa.Array(single([[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]', ...
               [0, 0.1, -0.1, 5.0, 6.0, 7.0, 8.1, 9.0, 9.0, 9.0]']));
           b = tsa.Dimensionality.ramerDouglasPeucker(a, 1.0);
           expected = single([[0, 2, 3, 6, 9]', [0, -0.1, 5.0, 8.1, 9.0]']);
           c = b.getData();
           diff = abs(c - expected);
           testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testVisvalingam(testCase)
           a = tsa.Array(single([[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]', ...
               [0, 0.1, -0.1, 5.0, 6.0, 7.0, 8.1, 9.0, 9.0, 9.0]']));
           b = tsa.Dimensionality.visvalingam(a, 5);
           expected = single([[0, 2, 5, 7, 9]', [0, -0.1, 7.0, 9.0, 9.0]']);
           c = b.getData();
           diff = abs(c - expected);
           testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testPaa(testCase)
           a = tsa.Array(single([[0.0, 0.1, -0.1, 5.0, 6.0, 7.0, 8.1, ...
               9.0, 9.0, 9.0]', [0.0, 0.1, -0.1, 5.0, 6.0, 7.0, 8.1, ...
               9.0, 9.0, 9.0]']));
           b = tsa.Dimensionality.paa(a, 5);
           expected = single([[0.05, 2.45, 6.5, 8.55, 9.0]', ...
               [0.05, 2.45, 6.5, 8.55, 9.0]']);
           c = b.getData();
           diff = abs(c - expected);
           testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testSax(testCase)
           a = tsa.Array(single([[0.05, 2.45, 6.5, 8.55, 9.0]', ...
               [0.05, 2.45, 6.5, 8.55, 9.0]']));
           b = tsa.Dimensionality.sax(a, 3);
           expected = int32([[0, 0, 1, 2, 2]', [0, 0, 1, 2, 2]']);
           c = b.getData();
           diff = abs(c - expected);
           testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testPip(testCase)
           a = tsa.Array(single([[0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, ...
               7.0, 8.0, 9.0]', [0.0, 0.1, -0.1, 5.0, 6.0, 7.0, 8.1, ...
               9.0, 9.0, 9.0]']));
           b = tsa.Dimensionality.pip(a, 6);
           expected = single([[0.0, 2.0, 4.0, 5.0, 6.0, 9.0]', ...
               [0.0, -0.1, 6.0, 7.0, 8.1, 9.0]']);
           c = b.getData();
           diff = abs(c - expected);
           testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
    end
end
