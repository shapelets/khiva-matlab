%% Test Class Definition
classdef ArrayUnitTests < matlab.unittest.TestCase
    
    % -------------------------------------------------------------------
    % Copyright (c) 2018 Grumpy Cat Software S.L.
    %
    % This Source Code Form is subject to the terms of the Mozilla Public
    % License, v. 2.0. If a copy of the MPL was not distributed with this
    % file, You can obtain one at http://mozilla.org/MPL/2.0/.
    % -------------------------------------------------------------------
    
    properties
        lib
    end
    
    methods (TestClassSetup)
        function addLibraryClassToPath(testCase)
            p = path;
            testCase.addTeardown(@path,p);
            addpath ..;
            import tsa.Array.*
            testCase.lib = tsa.Library.instance();
        end
    end
    
    %% Test Method Block
    methods (Test)
        function testSingle(testCase)
            a = tsa.Array(single([1 2 3 4; 5 6 7 8]'));
            b = a.getData();
            testCase.verifyEqual(b,single([1 2 3 4; 5 6 7 8]'));
        end
        
        function testComplex(testCase)
            a = tsa.Array(complex(single([1; 2; 3; 4]), single([5; 6; 7; 8])));
            testCase.verifyEqual(a.getData(),complex(single([1; 2; 3; 4]), single([5; 6; 7; 8])));
        end
        
        function testCreateFromReference(testCase)
            a = tsa.Array(single([1 2 3 4; 5 6 7 8]'));
            b = tsa.Array(a.getReference());
            c = a.getData();
            d = b.getData();
            testCase.verifyEqual(c,d);
        end
    end
end
