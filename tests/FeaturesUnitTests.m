%% Test Class Definition
classdef FeaturesUnitTests < matlab.unittest.TestCase
    
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
        emptyVector
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
            testCase.emptyVector = single([1 2]);
            testCase.emptyVector = testCase.emptyVector(testCase.emptyVector > 2)';
        end
    end
    
    %% Test Method Block
    methods (Test)
        function testAbsEnergy(testCase)
            a = tsa.Array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]');
            b = tsa.Features.absEnergy(a);
            expected = 385;
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testAbsoluteSumOfChanges(testCase)
            a = tsa.Array([[0; 1; 2; 3], [4; 6; 8; 10], [11; 14; 17; 20]]);
            b = tsa.Features.absoluteSumOfChanges(a);
            expected = [3 6 9];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(3), testCase.delta);
        end
        
        function testAggregatedAutocorrelationMean(testCase)
            a = tsa.Array([[1; 2; 3; 4; 5; 6], [7; 8; 9; 10; 11; 12]]);
            b = tsa.Features.aggregatedAutocorrelation(a, 0);
            expected = [-0.6571428571428571 -0.6571428571428571];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta);
        end
        
        function testAggregatedAutocorrelationMedian(testCase)
            a = tsa.Array([[1; 2; 3; 4; 5; 6], [7; 8; 9; 10; 11; 12]]);
            b = tsa.Features.aggregatedAutocorrelation(a, 1);
            expected = [-0.54285717010498047 -0.54285717010498047];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta);
        end
        
        function testAggregatedAutocorrelationMin(testCase)
            a = tsa.Array([[1; 2; 3; 4; 5; 6], [7; 8; 9; 10; 11; 12]]);
            b = tsa.Features.aggregatedAutocorrelation(a, 2);
            expected = [-2.142857142857143 -2.142857142857143];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta);
        end
        
        function testAggregatedAutocorrelationMax(testCase)
            a = tsa.Array([[1; 2; 3; 4; 5; 6], [7; 8; 9; 10; 11; 12]]);
            b = tsa.Features.aggregatedAutocorrelation(a, 3);
            expected = [0.6 0.6];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta);
        end
        
        function testAggregatedAutocorrelationStdev(testCase)
            a = tsa.Array([[1; 2; 3; 4; 5; 6], [7; 8; 9; 10; 11; 12]]);
            b = tsa.Features.aggregatedAutocorrelation(a, 4);
            expected = [0.9744490855905009 0.9744490855905009];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta);
        end
        
        function testAggregatedAutocorrelationVar(testCase)
            a = tsa.Array([[1; 2; 3; 4; 5; 6], [7; 8; 9; 10; 11; 12]]);
            b = tsa.Features.aggregatedAutocorrelation(a, 5);
            expected = [0.9495510204081633 0.9495510204081633];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta);
        end
        
        function testAggregatedLinearTrendMean(testCase)
            a = tsa.Array([2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5]');
            [slope, intercept, rvalue, pvalue, stdrrest] = ...
                tsa.Features.aggregatedLinearTrend(a, 3, 0);
            expectedSlope = 1;
            slopeHost = slope.getData();
            diffSlope = abs(slopeHost - expectedSlope);
            expectedIntercept = 2;
            interceptHost = intercept.getData();
            diffIntercept = abs(interceptHost - expectedIntercept);
            expectedRvalue = 1;
            rvalueHost = rvalue.getData();
            diffRvalue = abs(rvalueHost - expectedRvalue);
            expectedPvalue = 0;
            pvalueHost = pvalue.getData();
            diffPvalue = abs(pvalueHost - expectedPvalue);
            expectedStdrrest = 0;
            stdrrestHost = stdrrest.getData();
            diffStdrrest = abs(stdrrestHost - expectedStdrrest);
            testCase.verifyLessThanOrEqual(diffSlope, testCase.delta);
            testCase.verifyLessThanOrEqual(diffIntercept, testCase.delta);
            testCase.verifyLessThanOrEqual(diffRvalue, testCase.delta);
            testCase.verifyLessThanOrEqual(diffPvalue, testCase.delta);
            testCase.verifyLessThanOrEqual(diffStdrrest, testCase.delta);
        end
        
        function testAggregatedLinearTrendMin(testCase)
            a = tsa.Array([2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5]');
            [slope, intercept, rvalue, pvalue, stdrrest] = ...
                tsa.Features.aggregatedLinearTrend(a, 3, 2);
            expectedSlope = 1;
            slopeHost = slope.getData();
            diffSlope = abs(slopeHost - expectedSlope);
            expectedIntercept = 2;
            interceptHost = intercept.getData();
            diffIntercept = abs(interceptHost - expectedIntercept);
            expectedRvalue = 1;
            rvalueHost = rvalue.getData();
            diffRvalue = abs(rvalueHost - expectedRvalue);
            expectedPvalue = 0;
            pvalueHost = pvalue.getData();
            diffPvalue = abs(pvalueHost - expectedPvalue);
            expectedStdrrest = 0;
            stdrrestHost = stdrrest.getData();
            diffStdrrest = abs(stdrrestHost - expectedStdrrest);
            testCase.verifyLessThanOrEqual(diffSlope, testCase.delta);
            testCase.verifyLessThanOrEqual(diffIntercept, testCase.delta);
            testCase.verifyLessThanOrEqual(diffRvalue, testCase.delta);
            testCase.verifyLessThanOrEqual(diffPvalue, testCase.delta);
            testCase.verifyLessThanOrEqual(diffStdrrest, testCase.delta);
        end
        
        function testApproximateEntropy(testCase)
            a = tsa.Array([[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]', ...
                [11, 12, 13, 14, 15, 16, 17, 18, 19, 20]']);
            b = tsa.Features.approximateEntropy(a, 4, 0.5);
            expected = [0.13484281753639338 0.13484281753639338];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta);
        end
        
        function testAutoCorrelation(testCase)
            a = tsa.Array([[0; 1; 2; 3], [10; 11; 12; 13]]);
            b = tsa.Features.autoCorrelation(a, 4, false);
            expected = single([[1; 0.25; -0.3; -0.45], ...
                [1; 0.25; -0.3; -0.45]]);
            c = b.getData();
            diff = abs(c - expected);
            values = diff(diff > testCase.delta);
            testCase.verifyEqual(values, testCase.emptyVector);
        end
        
        function testAutoCovariance(testCase)
            a = tsa.Array([[0; 1; 2; 3], [10; 11; 12; 13]]);
            b = tsa.Features.autoCovariance(a, false);
            expected = single([[1.25; 0.3125; -0.375; -0.5625], ...
                [1.25; 0.3125; -0.375; -0.5625]]);
            c = b.getData();
            diff = abs(c - expected);
            values = diff(diff > testCase.delta);
            testCase.verifyEqual(values, testCase.emptyVector);
        end
        
        function testBinnedEntropy(testCase)
            a = tsa.Array([[1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ...
                11, 12, 13, 14, 15, 16, 17, 18, 19, 20]', ...
                [1, 1, 3, 10, 5, 6, 1, 8, 9, 10, 11, 1, 13, ...
                14, 10, 16, 17, 10, 19, 20]']);
            b = tsa.Features.binnedEntropy(a, 5);
            expected = [1.6094379124341005 1.5614694247763998];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta);
        end
        
        function testC3(testCase)
            a = tsa.Array([[0, 1, 2, 3, 4, 5]', [6, 7, 8, 9, 10, 11]']);
            b = tsa.Features.c3(a, 2);
            expected = [7.5 586.5];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta);
        end
        
        function testCidCe(testCase)
            a = tsa.Array([[0, 1, 2, 3, 4, 5]', [6, 7, 8, 9, 10, 11]']);
            b = tsa.Features.cidCe(a, false);
            expected = [2.23606797749979 2.23606797749979];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta);
        end
        
        function testCountAboveMean(testCase)
            a = tsa.Array([[0, 1, 2, 3, 4, 5]', [6, 7, 8, 9, 10, 11]']);
            b = tsa.Features.countAboveMean(a);
            expected = uint32([3 3]);
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta);
        end
        
        function testCountBelowMean(testCase)
            a = tsa.Array([[0, 1, 2, 3, 4, 5]', [6, 7, 8, 9, 10, 11]']);
            b = tsa.Features.countBelowMean(a);
            expected = uint32([3 3]);
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta);
        end
        
        function testCrossCorrelation(testCase)
            xss = tsa.Array([1; 2; 3; 4]);
            yss = tsa.Array([4; 6; 8; 10; 12]);
            b = tsa.Features.crossCorrelation(xss, yss, false);
            expected = single([0.790569415; 0.790569415; 0.079056941; ...
                -0.395284707; -0.474341649]);
            c = b.getData();
            diff = abs(c - expected);
            values = diff(diff > testCase.delta);
            testCase.verifyEqual(values, testCase.emptyVector);
        end
        
        function testCrossCovariance(testCase)
            xss = tsa.Array([[0; 1; 2; 3], [10; 11; 12; 13]]);
            yss = tsa.Array([[4; 6; 8; 10; 12], [14; 16; 18; 20; 22]]);
            b = tsa.Features.crossCovariance(xss, yss, false);
            expected = zeros([5, 2, 2, 1], 'single');
            expected(:,:,1) = [[2.5; 2.5; 0.25; -1.25; -1.5], [2.5; 2.5; 0.25; -1.25; -1.5]];
            expected(:,:,2) = [[2.5; 2.5; 0.25; -1.25; -1.5], [2.5; 2.5; 0.25; -1.25; -1.5]];
            c = b.getData();
            diff = abs(c - expected);
            values = diff(diff > testCase.delta);
            testCase.verifyEqual(values, testCase.emptyVector);
        end
        
        function testCwtCoefficients(testCase)
            a = tsa.Array([[0.1, 0.2, 0.3]', [0.1, 0.2, 0.3]']);
            w = tsa.Array(int32([1; 2; 3]));
            b = tsa.Features.cwtCoefficients(a, w, 2, 2);
            expected = [0.26517161726951599 0.26517161726951599];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta);
        end
        
        function testEnergyRatioByChunks(testCase)
            a = tsa.Array([[0, 1, 2, 3, 4, 5]', [6, 7, 8, 9, 10, 11]']);
            b = tsa.Features.energyRatioByChunks(a, 2, 0);
            expected = [0.090909091 0.330376940];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta);
            b = tsa.Features.energyRatioByChunks(a, 2, 1);
            expected = [0.909090909 0.669623060];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta);
        end
        
        function testFftAggregated(testCase)
            a = tsa.Array([[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]', ...
                [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]']);
            b = tsa.Features.fftAggregated(a);
            expected = single([[1.135143; 2.368324; 1.248777; 3.642666], ...
                [1.135143; 2.368324; 1.248777; 3.642666]]);
            c = b.getData();
            diff = abs(c - expected);
            values = diff(diff > testCase.delta);
            testCase.verifyEqual(values, testCase.emptyVector);
        end
        
        function testFftCoefficient(testCase)
            a = tsa.Array([[0, 1, 2, 3, 4, 5]', [6, 7, 8, 9, 10, 11]']);
            [real, imag, absolute, angle] = tsa.Features.fftCoefficient(a, 0);
            expectedReal = [15 51];
            realHost = real.getData();
            diffReal = abs(realHost - expectedReal);
            expectedImag = [0 0];
            imagHost = imag.getData();
            diffImag = abs(imagHost - expectedImag);
            expectedAbsolute = [15 51];
            absoluteHost = absolute.getData();
            diffAbsolute = abs(absoluteHost - expectedAbsolute);
            expectedAngle = [0 0];
            angleHost = angle.getData();
            diffAngle = abs(angleHost - expectedAngle);
            testCase.verifyLessThanOrEqual(diffReal, testCase.delta);
            testCase.verifyLessThanOrEqual(diffImag, testCase.delta);
            testCase.verifyLessThanOrEqual(diffAbsolute, testCase.delta);
            testCase.verifyLessThanOrEqual(diffAngle, testCase.delta);
        end
        
        function testFirstLocationOfMaximum(testCase)
            a = tsa.Array([[5, 4, 3, 5, 0, 1, 5, 3, 2, 1]', ...
                [2, 4, 3, 5, 2, 5, 4, 3, 5, 2]']);
            b = tsa.Features.firstLocationOfMaximum(a);
            expected = [0.0 0.3];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta);
        end
        
        function testFirstLocationOfMinimum(testCase)
            a = tsa.Array([[5, 4, 3, 0, 0, 1]', [5, 4, 3, 0, 2, 1]']);
            b = tsa.Features.firstLocationOfMinimum(a);
            expected = [0.5 0.5];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta);
        end
        
        % Commented because this function fails just in Matlab. It is not
        % failing in python, neither in Java. It is failing when using the
        % lls solver of tsa which uses the svd function of ArrayFire. It
        % fails exactly at the point where svd is used.
        %function testFriedrichCoefficients(testCase)
        %    a = tsa.Array([[0, 1, 2, 3, 4, 5]', [0, 1, 2, 3, 4, 5]']);
        %    b = tsa.Features.friedrichCoefficients(a, 4, 2);
        %    expected = [[-0.0009912563255056738, -0.0027067768387496471, ...
        %        -0.00015192681166809052, 0.10512571036815643, ...
        %        0.89872437715530396]', [-0.0009912563255056738, ...
        %        -0.0027067768387496471, -0.00015192681166809052, ...
        %        0.10512571036815643, 0.89872437715530396]'];
        %    c = b.getData();
        %    testCase.verifyEqual(c, expected);
        %end
        
        function testHasDuplicates(testCase)
            a = tsa.Array([[5, 4, 3, 0, 0, 1]', [5, 4, 3, 0, 2, 1]']);
            b = tsa.Features.hasDuplicates(a);
            expected = [true false];
            c = b.getData();
            testCase.verifyEqual(c(1), expected(1));
            testCase.verifyEqual(c(2), expected(2));
        end
        
        function testHasDuplicateMax(testCase)
            a = tsa.Array([[5, 4, 3, 0, 5, 1]', [5, 4, 3, 0, 2, 1]']);
            b = tsa.Features.hasDuplicateMax(a);
            expected = [true false];
            c = b.getData();
            testCase.verifyEqual(c(1), expected(1));
            testCase.verifyEqual(c(2), expected(2));
        end
        
        function testHasDuplicateMin(testCase)
            a = tsa.Array([[5, 4, 3, 0, 0, 1]', [5, 4, 3, 0, 2, 1]']);
            b = tsa.Features.hasDuplicateMin(a);
            expected = [true false];
            c = b.getData();
            testCase.verifyEqual(c(1), expected(1));
            testCase.verifyEqual(c(2), expected(2));
        end
        
        function testIndexMaxQuantile(testCase)
            a = tsa.Array([[5, 4, 3, 0, 0, 1]', [5, 4, 0, 0, 2, 1]']);
            b = tsa.Features.indexMaxQuantile(a, 0.5);
            expected = [0.333333333 0.333333333];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta);
        end
        
        function testKurtosis(testCase)
            a = tsa.Array([[0, 1, 2, 3, 4, 5]', [2, 2, 2, 20, 30, 25]']);
            b = tsa.Features.kurtosis(a);
            expected = [-1.2 -2.66226722];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta * 1e2);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta * 1e2);
        end
        
        function testLargeStandardDeviation(testCase)
            a = tsa.Array([[-1, -1, -1, 1, 1, 1]', [4, 6, 8, 4, 5, 4]']);
            b = tsa.Features.largeStandardDeviation(a, 0.4);
            expected = [true false];
            c = b.getData();
            testCase.verifyEqual(c(1), expected(1));
            testCase.verifyEqual(c(2), expected(2));
        end
        
        function testLastLocationOfMaximum(testCase)
            a = tsa.Array([[0, 4, 3, 5, 5, 1]', [0, 4, 3, 2, 5, 1]']);
            b = tsa.Features.lastLocationOfMaximum(a);
            expected = [0.8333333333333334 0.8333333333333334];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta);
        end
        
        function testLastLocationOfMinimum(testCase)
            a = tsa.Array([[0, 4, 3, 5, 5, 1, 0, 4]', ...
                [3, 2, 5, 1, 4, 5, 1, 2]']);
            b = tsa.Features.lastLocationOfMinimum(a);
            expected = [0.875 0.875];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff(1), testCase.delta);
            testCase.verifyLessThanOrEqual(diff(2), testCase.delta);
        end
        
        function testLength(testCase)
            a = tsa.Array([[0, 4, 3, 5, 5, 1]', [0, 4, 3, 2, 5, 1]']);
            b = tsa.Features.length(a);
            expected = int32([6 6]);
            c = b.getData();
            testCase.verifyEqual(c(1), expected(1));
            testCase.verifyEqual(c(2), expected(2));
        end
        
        function testLinearTrend(testCase)
            a = tsa.Array([[0, 4, 3, 5, 5, 1]', [2, 4, 1, 2, 5, 3]']);
            [slope, intercept, rvalue, pvalue, stdrrest] = ...
                tsa.Features.linearTrend(a);
            expectedSlope = [0.2857142857142857 0.2571428571428572];
            slopeHost = slope.getData();
            diffSlope = abs(slopeHost - expectedSlope);
            expectedIntercept = [2.2857142857142856 2.1904761904761907];
            interceptHost = intercept.getData();
            diffIntercept = abs(interceptHost - expectedIntercept);
            expectedRvalue = [0.2548235957188128 0.3268228676411533];
            rvalueHost = rvalue.getData();
            diffRvalue = abs(rvalueHost - expectedRvalue);
            expectedPvalue = [0.6260380997892747 0.5272201945463578];
            pvalueHost = pvalue.getData();
            diffPvalue = abs(pvalueHost - expectedPvalue);
            expectedStdrrest = [0.5421047417431507 0.37179469135129783];
            stdrrestHost = stdrrest.getData();
            diffStdrrest = abs(stdrrestHost - expectedStdrrest);
            testCase.verifyLessThanOrEqual(diffSlope, testCase.delta);
            testCase.verifyLessThanOrEqual(diffIntercept, testCase.delta);
            testCase.verifyLessThanOrEqual(diffRvalue, testCase.delta);
            testCase.verifyLessThanOrEqual(diffPvalue, testCase.delta);
            testCase.verifyLessThanOrEqual(diffStdrrest, testCase.delta);
        end
        
        function testLongestStrikeAboveMean(testCase)
            a = tsa.Array([[20, 20, 20, 1, 1, 1, 20, 20, 20, 20, 1, 1, ...
                1, 1, 1, 1, 1, 1, 20, 20]', [20, 20, 20, 1, 1, 1, 20, 20, ...
                20, 1, 1, 1, 1, 1, 1, 1, 1, 1, 20, 20]']);
            b = tsa.Features.longestStrikeAboveMean(a);
            expected = [4 3];
            c = b.getData();
            testCase.verifyEqual(c(1), expected(1));
            testCase.verifyEqual(c(2), expected(2));
        end
        
        function testLongestStrikeBelowMean(testCase)
            a = tsa.Array([[20, 20, 20, 1, 1, 1, 20, 20, 20, 20, 1, 1, ...
                1, 1, 1, 1, 1, 1, 20, 20]', [20, 20, 20, 1, 1, 1, 20, 20, ...
                20, 1, 1, 1, 1, 1, 1, 1, 1, 1, 20, 20]']);
            b = tsa.Features.longestStrikeBelowMean(a);
            expected = [8 9];
            c = b.getData();
            testCase.verifyEqual(c(1), expected(1));
            testCase.verifyEqual(c(2), expected(2));
        end
        
        %function testMaxLangevinFixedPoint(testCase)
        %    a = tsa.Array([[0, 1, 2, 3, 4, 5]', [0, 1, 2, 3, 4, 5]']);
        %    a.print();
        %    a.getType()
        %    b = tsa.Features.maxLangevinFixedPoint(a, 7, 2);
        %    b.print();
        %    expected = [4.562970585 4.562970585];
        %    c = b.getData();
        %    diff = abs(c - expected);
        %    testCase.verifyLessThanOrEqual(diff, testCase.delta);
        %end
        
        function testMaximum(testCase)
            a = tsa.Array([[20, 20, 20, 18, 25, 19, 20, 20, 20, 20, 40, ...
                30, 1, 50, 1, 1, 5, 1, 20, 20]', [20, 20, 20, 2, 19, ...
                1, 20, 20, 20, 1, 15, 1, 30, 1, 1, 18, 4, 1, 20, 20]']);
            b = tsa.Features.maximum(a);
            expected = [50 30];
            c = b.getData();
            testCase.verifyEqual(c, expected);
        end
        
        function testMean(testCase)
            a = tsa.Array([[20, 20, 20, 18, 25, 19, 20, 20, 20, 20, 40, ...
                30, 1, 50, 1, 1, 5, 1, 20, 20]', [20, 20, 20, 2, 19, ...
                1, 20, 20, 20, 1, 15, 1, 30, 1, 1, 18, 4, 1, 20, 20]']);
            b = tsa.Features.mean(a);
            expected = [18.55 12.7];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testMeanAbsoluteChange(testCase)
            a = tsa.Array([[0, 1, 2, 3, 4, 5]', [8, 10, 12, 14, 16, 18]']);
            b = tsa.Features.meanAbsoluteChange(a);
            expected = [5/6 10/6];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testMeanChange(testCase)
            a = tsa.Array([[0, 1, 2, 3, 4, 5]', [8, 10, 12, 14, 16, 18]']);
            b = tsa.Features.meanChange(a);
            expected = [5/6 10/6];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testMeanSecondDerivativeCentral(testCase)
            a = tsa.Array([[1, 3, 7, 4, 8]', [2, 5, 1, 7, 4]']);
            b = tsa.Features.meanSecondDerivativeCentral(a);
            expected = [1/5 -3/5];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testMedian(testCase)
            a = tsa.Array([[20, 20, 20, 18, 25, 19, 20, 20, 20, 20, 40, ...
                30, 1, 50, 1, 1, 5, 1, 20, 20]', [20, 20, 20, 2, 19, ...
                1, 20, 20, 20, 1, 15, 1, 30, 1, 1, 18, 4, 1, 20, 20]']);
            b = tsa.Features.median(a);
            expected = [20 18.5];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testMinimum(testCase)
            a = tsa.Array([[20, 20, 20, 18, 25, 19, 20, 20, 20, 20, 40, ...
                30, 1, 50, 13, 15, 5, 16, 20, 20]', [20, 20, 20, 2, 19, ...
                4, 20, 20, 20, 4, 15, 6, 30, 7, 9, 18, 4, 10, 20, 20]']);
            b = tsa.Features.minimum(a);
            expected = [1 2];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testNumberCrossingM(testCase)
            a = tsa.Array([[1, 2, 1, 1, -3, -4, 7, 8, 9, 10, -2, 1, -3, ...
                5, 6, 7, -10]', [1, 2, 1, 1, -3, -4, 7, 8, 9, 10, -2, 1, ...
                -3, 5, 6, 7, -10]']);
            b = tsa.Features.numberCrossingM(a, 0);
            expected = [7 7];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testNumberPeaks(testCase)
            a = tsa.Array([[3, 0, 0, 4, 0, 0, 13]', [3, 0, 0, 4, 0, 0, 13]']);
            b = tsa.Features.numberPeaks(a, 2);
            expected = [1 1];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testPartialAutocorrelation(testCase)
            numel = 3000;
            step = 1 / (numel - 1);
            input = 0:step:step * (numel - 1);
            input = [input', input'];
            a = tsa.Array(single(input));
            lags = tsa.Array(int32(0:9)');
            b = tsa.Features.partialAutocorrelation(a, lags);
            expected = [[1.0, 0.9993331432342529, -0.0006701064994559, ...
                -0.0006701068487018, -0.0008041285327636, ...
                -0.0005360860959627, -0.0007371186511591, ...
                -0.0004690756904893, -0.0008041299879551, ...
                -0.0007371196406893]', [1.0, 0.9993331432342529, ...
                -0.0006701064994559, -0.0006701068487018, -0.0008041285327636, ...
                -0.0005360860959627, -0.0007371186511591, -0.0004690756904893, ...
                -0.0008041299879551, -0.0007371196406893]'];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta * 1e3);
        end
        
        function testPercentageOfReoccurringDatapointsToAllDatapoints(testCase)
            a = tsa.Array([[3, 0, 0, 4, 0, 0, 13]', [3, 0, 0, 4, 0, 0, 13]']);
            b = tsa.Features.percentageOfReoccurringDatapointsToAllDatapoints(a, false);
            expected = [0.25 0.25];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testPercentageOfReoccurringValuesToAllValues(testCase)
            a = tsa.Array([[1, 1, 2, 3, 4, 4, 5, 6]', [1, 2, 2, 3, 4, 5, 6, 7]']);
            b = tsa.Features.percentageOfReoccurringValuesToAllValues(a, false);
            expected = [4/8 2/8];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testQuantile(testCase)
            a = tsa.Array([[0, 0, 0, 0, 3, 4, 13]', [0, 0, 0, 0, 3, 4, 13]']);
            ps = tsa.Array(single(0.6));
            b = tsa.Features.quantile(a, ps, 1e8);
            expected = [1.79999999 1.79999999];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testRangeCount(testCase)
            a = tsa.Array([[3, 0, 0, 4, 0, 0, 13]', [3, 0, 5, 4, 0, 0, 13]']);
            b = tsa.Features.rangeCount(a, 2, 12);
            expected = [2 3];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testRatioBeyondRSigma(testCase)
            a = tsa.Array([[3, 0, 0, 4, 0, 0, 13]', [3, 0, 0, 4, 0, 0, 13]']);
            b = tsa.Features.ratioBeyondRSigma(a, 0.5);
            expected = [0.7142857142857143 0.7142857142857143];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testRatioValueNumberToTimeSeriesLength(testCase)
            a = tsa.Array([[3, 0, 0, 4, 0, 0, 13]', [3, 5, 0, 4, 6, 0, 13]']);
            b = tsa.Features.ratioValueNumberToTimeSeriesLength(a);
            expected = [4/7 6/7];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testSampleEntropy(testCase)
            a = tsa.Array([[3, 0, 0, 4, 0, 0, 13]', [3, 0, 0, 4, 0, 0, 13]']);
            b = tsa.Features.sampleEntropy(a);
            expected = [1.2527629 1.2527629];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testSkewness(testCase)
            a = tsa.Array([[3, 0, 0, 4, 0, 0, 13]', [3, 0, 0, 4, 0, 0, 13]']);
            b = tsa.Features.skewness(a);
            expected = [2.038404735373753 2.038404735373753];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testSpktWelchDensity(testCase)
            a = tsa.Array([[0, 1, 1, 3, 4, 5, 6, 7, 8, 9]', ...
                [0, 1, 1, 3, 4, 5, 6, 7, 8, 9]']);
            b = tsa.Features.spktWelchDensity(a, 0);
            expected = [3.3333334922790527 3.3333334922790527];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testStandardDeviation(testCase)
            a = tsa.Array([[20, 20, 20, 18, 25, 19, 20, 20, 20, 20, 40, ...
                30, 1, 50, 1, 1, 5, 1, 20, 20]', [20, 20, 20, 2, 19, 1, ...
                20, 20, 20, 1, 15, 1, 30, 1, 1, 18, 4, 1, 20, 20]']);
            b = tsa.Features.standarDeviation(a);
            expected = [12.363150892875165 9.51367436903324];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testSumOfReoccurringDatapoints(testCase)
            a = tsa.Array([[3, 3, 0, 4, 0, 13, 13]', [3, 3, 0, 4, 0, 13, 13]']);
            b = tsa.Features.sumOfReoccurringDatapoints(a, false);
            expected = [32 32];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testSumOfReoccurringValues(testCase)
            a = tsa.Array([[4, 4, 6, 6, 7]', [4, 7, 7, 8, 8]']);
            b = tsa.Features.sumOfReoccurringValues(a, false);
            expected = [10 15];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testSumValues(testCase)
            a = tsa.Array([[1, 2, 3, 4.1]', [-1.2, -2, -3, -4]']);
            b = tsa.Features.sumValues(a);
            expected = [10.1 -10.2];
            c = b.getData();
            diff = abs(c - expected);
            testCase.verifyLessThanOrEqual(diff, testCase.delta);
        end
        
        function testSymmetryLooking(testCase)
            a = tsa.Array([[20, 20, 20, 18, 25, 19, 20, 20, 20, 20, 40, ...
                30, 1, 50, 1, 1, 5, 1, 20, 20]', [20, 20, 20, 2, 19, 1, ...
                20, 20, 20, 1, 15, 1, 30, 1, 1, 18, 4, 1, 20, 20]']);
            b = tsa.Features.symmetryLooking(a, 0.1);
            expected = [true false];
            c = b.getData();
            testCase.verifyEqual(c, expected);
        end
        
        function testTimeReversalAsymmetryStatistic(testCase)
            a = tsa.Array([[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, ...
                15, 16, 17, 18, 19, 20]', [20, 20, 20, 2, 19, 1, 20, 20, ...
                20, 1, 15, 1, 30, 1, 1, 18, 4, 1, 20, 20]']);
            b = tsa.Features.timeReversalAsymmetryStatistic(a, 2);
            expected = [1052 -150.625];
            c = b.getData();
            testCase.verifyEqual(c, expected);
        end
        
        function testValueCount(testCase)
            a = tsa.Array([[20, 20, 20, 18, 25, 19, 20, 20, 20, 20, 40, ...
                30, 1, 50, 1, 1, 5, 1, 20, 20]', [20, 20, 20, 2, 19, 1, ...
                20, 20, 20, 1, 15, 1, 30, 1, 1, 18, 4, 1, 20, 20]']);
            b = tsa.Features.valueCount(a, 20);
            expected = uint32([9 8]);
            c = b.getData();
            testCase.verifyEqual(c, expected);
        end
        
        function testVariance(testCase)
            a = tsa.Array([[1, 1, -1, -1]', [1, 2, -2, -1]']);
            b = tsa.Features.variance(a);
            expected = [1 2.5];
            c = b.getData();
            testCase.verifyEqual(c, expected);
        end
        
        function testVarianceLargerThanStandardDeviation(testCase)
            a = tsa.Array([[20, 20, 20, 18, 25, 19, 20, 20, 20, 20, 40, ...
                30, 1, 50, 1, 1, 5, 1, 20, 20]', [20, 20, 20, 2, 19, 1, ...
                20, 20, 20, 1, 15, 1, 30, 1, 1, 18, 4, 1, 20, 20]']);
            b = tsa.Features.varianceLargerThanStandardDeviation(a);
            expected = [true true];
            c = b.getData();
            testCase.verifyEqual(c, expected);
        end
    end
end
