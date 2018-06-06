%% Test Class Definition
classdef RegularizationUnitTests < matlab.unittest.TestCase
    
    % -------------------------------------------------------------------
    % Copyright (c) 2018 Shapelets.io
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
            testCase.delta = 1e-6;
        end
    end
    
    %% Test Method Block
    methods (Test)
        function testGroupBySingleColumn(testCase)
           a = khiva.Array(single([[0, 1, 1, 2, 2, 3]', [0, 3, 3, 1, 1, 2]']));
           b = khiva.Regularization.groupBy(a, 0, 1, 1);
           expected = single([0, 3, 1, 2]');
           c = b.getData();
           diff = abs(c - expected);
           testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testGroupByDoubleKeyColumn(testCase)
           a = khiva.Array(single([[0, 1, 1, 2, 2, 3]', [1, 2, 2, 3, 3, 4]', ...
               [0, 3, 3, 1, 1, 2]']));
           b = khiva.Regularization.groupBy(a, 0, 2, 1);
           expected = single([0, 3, 1, 2]');
           c = b.getData();
           diff = abs(c - expected);
           testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testGroupByDoubleKeyColumn2(testCase)
           a = khiva.Array(single([[0, 0, 1, 1, 1]', [0, 1, 0, 0, 1]', ...
               [1, 2, 3, 4, 5]']));
           b = khiva.Regularization.groupBy(a, 0, 2, 1);
           expected = single([1, 2, 3.5, 5]');
           c = b.getData();
           diff = abs(c - expected);
           testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testGroupByDoubleKeyDoubleValueColumn(testCase)
           a = khiva.Array(single([[0, 0, 0, 2, 2]', [2, 2, 2, 4, 4]', ...
               [0, 1, 2, 3, 4]', [1, 1, 1, 1, 1]']));
           b = khiva.Regularization.groupBy(a, 0, 2, 2);
           expected = single([[1, 3.5]', [1, 1]']);
           c = b.getData();
           diff = abs(c - expected);
           testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
    end
end
