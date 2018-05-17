%% Test Class Definition
classdef StatisticsUnitTests < matlab.unittest.TestCase
    
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
            testCase.delta = 1e-6;
        end
    end
    
    %% Test Method Block
    methods (Test)
        function testCovarianceUnbiased(testCase)
            a = tsa.Array([[-2.1, -1, 4.3]',[3, 1.1, 0.12]', [3, 1.1, 0.12]']);
            b = tsa.Statistics.covariance(a, true);
            expected = [11.70999999, -4.286, -4.286, -4.286, 2.14413333, ... 
                2.14413333, -4.286, 2.14413333, 2.14413333];
            c = b.getData();
            diff = abs(reshape(c,1,[]) - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testCovarianceBiased(testCase)
            a = tsa.Array([[-2.1, -1, 4.3]',[3, 1.1, 0.12]', [3, 1.1, 0.12]']);
            b = tsa.Statistics.covariance(a, false);
            expected = [7.80666667, -2.85733333, -2.85733333, -2.85733333, ...
                1.42942222, 1.42942222, -2.85733333, 1.42942222, 1.42942222];
            c = b.getData();
            diff = abs(reshape(c,1,[]) - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        function testMoment(testCase)
            a = tsa.Array([[0, 1, 2, 3, 4, 5]', [0, 1, 2, 3, 4, 5]']);
            b = tsa.Statistics.moment(a, 2);
            expected = [9.166666666, 9.166666666];
            c = b.getData();
            diff = abs(reshape(c,1,[]) - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
            d = tsa.Statistics.moment(a, 4);
            e = d.getData();
            expected = [163.1666666666, 163.1666666666];
            diff = abs(reshape(e,1,[]) - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        function testSampleStdev(testCase)
            a = tsa.Array([[0, 1, 2, 3, 4, 5]', [2, 2, 2, 20, 30, 25]']);
            b = tsa.Statistics.sampleStdev(a);
            expected = [1.870828693, 12.988456413];
            c = b.getData();
            diff = abs(reshape(c,1,[]) - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        function testKurtosis(testCase)
            a = tsa.Array([[0, 1, 2, 3, 4, 5]', [2, 2, 2, 20, 30, 25]']);
            b = tsa.Statistics.kurtosis(a);
            expected = [-1.2, -2.66226722];
            c = b.getData();
            diff = abs(reshape(c,1,[]) - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        function testSkewness(testCase)
            a = tsa.Array([[0, 1, 2, 3, 4, 5]', [2, 2, 2, 20, 30, 25]']);
            b = tsa.Statistics.skewness(a);
            expected = [0.0, 0.236177069879499];
            c = b.getData();
            diff = abs(reshape(c,1,[]) - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        function testQuantile(testCase)
            a = tsa.Array([[0, 1, 2, 3, 4, 5]', [6, 7, 8, 9, 10, 11]']);
            q = tsa.Array([0.1, 0.2]');
            b = tsa.Statistics.quantile(a, q, 1e8);
            expected = [0.5, 1.0, 6.5, 7.0];
            c = b.getData();
            diff = abs(reshape(c,1,[]) - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        function testQuantileCut2(testCase)
            a = tsa.Array([[0, 1, 2, 3, 4, 5]', [6, 7, 8, 9, 10, 11]']);
            b = tsa.Statistics.quantilesCut(a, 2, 1e-8);
            expected = [-1.0e-8, -1.0e-8, -1.0e-8, 2.5, 2.5, 2.5, ...
                2.5, 2.5, 2.5, 5.0, 5.0, 5.0, 6.0, 6.0, 6.0, ...
                8.5, 8.5, 8.5, 8.5, 8.5, 8.5, 11.0, 11.0, 11.0];
            c = b.getData();
            diff = abs(reshape(c,1,[]) - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        function testQuantileCut3(testCase)
            a = tsa.Array([[0, 1, 2, 3, 4, 5]', [6, 7, 8, 9, 10, 11]']);
            b = tsa.Statistics.quantilesCut(a, 3, 1e-8);
            expected = [-1.0e-8, -1.0e-8, 1.6666667, 1.6666667, 3.3333335, ...
                3.3333335, 1.6666667, 1.6666667, 3.3333335, 3.3333335, ...
                5.0, 5.0, 6.0, 6.0, 7.6666665, 7.6666665, 9.333333, ...
                9.333333, 7.6666665, 7.6666665, 9.333333, 9.333333, ...
                11.0, 11.0];
            c = b.getData();
            diff = abs(reshape(c,1,[]) - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        function testQuantileCut7(testCase)
            a = tsa.Array([[0, 1, 2, 3, 4, 5]', [6, 7, 8, 9, 10, 11]']);
            b = tsa.Statistics.quantilesCut(a, 7, 1e-8);
            expected = [-1.0e-8, 0.71428573, 1.4285715, 2.857143, ... 
                        3.5714288, 4.2857146, 0.71428573, 1.4285715, ...
                        2.1428573, 3.5714288, 4.2857146, 5.0, 6.0, ... 
                        6.714286, 7.4285717, 8.857143, 9.571428, ... 
                        10.285714, 6.714286, 7.4285717, 8.142858, ...
                        9.571428, 10.285714, 11.0];
            c = b.getData();
            diff = abs(reshape(c,1,[]) - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
    end
end