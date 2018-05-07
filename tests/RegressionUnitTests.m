%% Test Class Definition
classdef RegressionUnitTests < matlab.unittest.TestCase
    
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
            import tsa.Backend.*
            import tsa.Library.*
            testCase.lib = tsa.Library.instance();
            testCase.delta = 1e-6;
        end
    end
    
    %% Test Method Block
    methods (Test)
        function testLinear(testCase)
            a = tsa.Array([0.24580423, 0.59642861, 0.35879163, 0.37891011,...
                0.02445137, 0.23830957, 0.38793433, 0.68054104, ...
                0.83934083, 0.76073689]');
            b = tsa.Array([0.2217416, 0.06344161, 0.77944375, 0.72174137,...
                0.19413884, 0.51146167, 0.06880307, 0.39414268, ...
                0.98172767, 0.30490851]');
            [slope, intercept, rvalue, pvalue, stderrest] = ... 
                tsa.Regression.linear(a, b);
            slope = slope.getData();
            intercept = intercept.getData()
            rvalue = rvalue.getData()
            pvalue = pvalue.getData()
            stderrest = stderrest.getData()
            
            testCase.verifyLessThanOrEqual(slope(1) - 0.344864266, testCase.delta);
            testCase.verifyLessThanOrEqual(intercept(1) - 0.268578232, testCase.delta);
            testCase.verifyLessThanOrEqual(rvalue(1) - 0.283552942, testCase.delta);
            testCase.verifyLessThanOrEqual(pvalue(1) -  0.427239418, testCase.delta);
            testCase.verifyLessThanOrEqual(stderrest(1) - 0.412351891, testCase.delta);
        end
        
        function testLinearMultipleTimeSeries(testCase)
            a = tsa.Array([[0.24580423, 0.59642861, 0.35879163, 0.37891011,...
                0.02445137, 0.23830957, 0.38793433, 0.68054104, ...
                0.83934083, 0.76073689]',[0.24580423, 0.59642861, ... 
                0.35879163, 0.37891011, 0.02445137, 0.23830957, 0.38793433,...
                0.68054104, 0.83934083, 0.76073689]']);
            b = tsa.Array([[0.2217416, 0.06344161, 0.77944375, 0.72174137,...
                0.19413884, 0.51146167, 0.06880307, 0.39414268, ...
                0.98172767, 0.30490851]',[0.2217416, 0.06344161, 0.77944375, 0.72174137,...
                0.19413884, 0.51146167, 0.06880307, 0.39414268, ...
                0.98172767, 0.30490851]']);
            [slope, intercept, rvalue, pvalue, stderrest] = ... 
                tsa.Regression.linear(a, b);
            slope = slope.getData();
            intercept = intercept.getData()
            rvalue = rvalue.getData()
            pvalue = pvalue.getData()
            stderrest = stderrest.getData()
            
            testCase.verifyLessThanOrEqual(slope(1) - 0.344864266, ... 
                testCase.delta);
            testCase.verifyLessThanOrEqual(intercept(1) - 0.268578232, testCase.delta);
            testCase.verifyLessThanOrEqual(rvalue(1) - 0.283552942, testCase.delta);
            testCase.verifyLessThanOrEqual(pvalue(1) -  0.427239418, testCase.delta);
            testCase.verifyLessThanOrEqual(stderrest(1) - 0.412351891, testCase.delta);
            testCase.verifyLessThanOrEqual(slope(2) - 0.344864266, testCase.delta);
            testCase.verifyLessThanOrEqual(intercept(2) - 0.268578232, testCase.delta);
            testCase.verifyLessThanOrEqual(rvalue(2) - 0.283552942, testCase.delta);
            testCase.verifyLessThanOrEqual(pvalue(2) -  0.427239418, testCase.delta);
            testCase.verifyLessThanOrEqual(stderrest(2) - 0.412351891, testCase.delta);
        end
    end
end