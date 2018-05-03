%% Test Class Definition
classdef PolynomialUnitTests < matlab.unittest.TestCase
    
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
        %function testPolyfit1(testCase)
        %   x = tsa.Array(single([0, 1, 2, 3, 4, 5]'));
        %   y = tsa.Array(single([0, 1, 2, 3, 4, 5]'));
        %   b = tsa.Polynomial.polyfit(x, y, 1);
        %   expected = single([1.0, 0.0]);
        %   c = b.getData();
        %   diff = abs(c - expected);
        %   testCase.verifyLessThanOrEqual(diff, testCase.delta);
        %end
        
        %function testPolyfit3(testCase)
        %   x = tsa.Array(single([0, 1, 2, 3, 4, 5]'));
        %   y = tsa.Array(single([0.0, 0.8, 0.9, 0.1, -0.8, -1.0]'));
        %   b = tsa.Polynomial.polyfit(x, y, 3);
        %   expected = single([0.08703704, -0.81349206, 1.69312169, -0.03968254]);
        %   c = b.getData();
        %   diff = abs(c - expected);
        %   testCase.verifyLessThanOrEqual(diff, testCase.delta);
        %end
        
        function testRoots(testCase)
            a = tsa.Array([5, -20, 5, 50, -20, -40]');
            b = tsa.Polynomial.roots(a);
            expected = complex([2, 2, 2, -1, -1]', [0, 0, 0, 0, 0]');
            c = b.getData();
            diff = c - expected;
            testCase.verifyLessThanOrEqual(diff, 1e-2);
        end
    end
end
