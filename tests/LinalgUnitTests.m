%% Test Class Definition
classdef LinalgUnitTests < matlab.unittest.TestCase
    
    % -------------------------------------------------------------------
    % Copyright (c) 2018 Grumpy Cat Software S.L.
    %
    % This Source Code Form is subject to the terms of the Mozilla Public
    % License, v. 2.0. If a copy of the MPL was not distributed with this
    % file, You can obtain one at http://mozilla.org/MPL/2.0/.
    % -------------------------------------------------------------------
    
    methods (TestClassSetup)
        function addLibraryClassToPath(testCase)
            p = path;
            testCase.addTeardown(@path,p);
            addpath ..;
        end
    end
    
    %% Test Method Block
    methods (Test)
        %function testLls(testCase)
        %   a = tsa.Array(single([[4 3]', [-1 -2]']));
        %   b = tsa.Array(single([3 1]'));
        %   c = tsa.Linalg.lls(a, b);
        %   expected = single([1 1]);
        %   d = c.getData();
        %   testCase.verifyEqual(d, expected);
        %end
    end
end
