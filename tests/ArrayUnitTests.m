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
        function testReal1D(testCase)
            a = tsa.Array([1, 2, 3, 4, 5, 6, 7, 8]');
            expected = [1, 2, 3, 4, 5, 6, 7, 8]';
            b = a.getData();
            testCase.verifyEqual(b, expected);
        end
        
        function testReal2D(testCase)
            a = tsa.Array([[1, 2, 3, 4]', [5, 6, 7, 8]']);
            expected = [[1, 2, 3, 4]', [5, 6, 7, 8]'];
            b = a.getData();
            testCase.verifyEqual(b, expected);
        end
        
        function testReal3D(testCase)
            A(:, :, 1) = [[1, 2]', [3, 4]'];
            A(:, :, 2) = [[5, 6]', [7, 8]'];
            a = tsa.Array(A);
            expected = A;
            b = a.getData();
            testCase.verifyEqual(b, expected);
        end
        
        function testReal4D(testCase)
            A(:, :, 1, 1) = [[1, 2]', [3, 4]'];
            A(:, :, 2, 1) = [[5, 6]', [7, 8]'];
            A(:, :, 1, 2) = [[9, 10]', [11, 12]'];
            A(:, :, 2, 2) = [[13, 14]', [15, 16]'];
            a = tsa.Array(A);
            expected = A;
            b = a.getData();
            testCase.verifyEqual(b, expected);
        end
        
        function testComplex64Of1D(testCase)
            A = single(complex([1, 2, 3, 4]', [5, 6, 7, 8]'));
            a = tsa.Array(A);
            expected = A;
            b = a.getData();
            testCase.verifyEqual(b, expected);
        end
        
        function testComplex64Of2D(testCase)
            A = single(complex([[1, 2, 3, 4]', [9, 10, 11, 12]'], [[5, 6, 7, 8]', [13, 14, 15, 16]']));
            a = tsa.Array(A);
            expected = A;
            b = a.getData();
            testCase.verifyEqual(b, expected);
        end
        
        function testComplex64Of3D(testCase)
            real(:, :, 1) = single([[1, 2]', [3, 4]']);
            real(:, :, 2) = single([[5, 6]', [7, 8]']);
            imag(:, :, 1) = single([[1, 2]', [3, 4]']);
            imag(:, :, 2) = single([[5, 6]', [7, 8]']);
            A = single(complex(real, imag));
            a = tsa.Array(A);
            expected = A;
            b = a.getData();
            testCase.verifyEqual(b, expected);
        end
        
        function testComplex64Of4D(testCase)
            real(:, :, 1, 1) = [[1, 2]', [3, 4]'];
            real(:, :, 2, 1) = [[5, 6]', [7, 8]'];
            real(:, :, 1, 2) = [[9, 10]', [11, 12]'];
            real(:, :, 2, 2) = [[13, 14]', [15, 16]'];
            imag(:, :, 1, 1) = [[1, 2]', [3, 4]'];
            imag(:, :, 2, 1) = [[5, 6]', [7, 8]'];
            imag(:, :, 1, 2) = [[9, 10]', [11, 12]'];
            imag(:, :, 2, 2) = [[13, 14]', [15, 16]'];
            A = single(complex(real, imag));
            a = tsa.Array(A);
            expected = A;
            b = a.getData();
            testCase.verifyEqual(b, expected);
        end
        
        function testComplex128Of1D(testCase)
            A = complex([1, 2, 3, 4]', [5, 6, 7, 8]');
            a = tsa.Array(A);
            expected = A;
            b = a.getData();
            testCase.verifyEqual(b, expected);
        end
        
        function testComplex128Of2D(testCase)
            A = complex([[1, 2, 3, 4]', [9, 10, 11, 12]'], [[5, 6, 7, 8]', [13, 14, 15, 16]']);
            a = tsa.Array(A);
            expected = A;
            b = a.getData();
            testCase.verifyEqual(b, expected);
        end
        
        function testComplex128Of3D(testCase)
            real(:, :, 1) = [[1, 2]', [3, 4]'];
            real(:, :, 2) = [[5, 6]', [7, 8]'];
            imag(:, :, 1) = [[1, 2]', [3, 4]'];
            imag(:, :, 2) = [[5, 6]', [7, 8]'];
            A = single(complex(real, imag));
            a = tsa.Array(A);
            expected = A;
            b = a.getData();
            testCase.verifyEqual(b, expected);
        end
        
        function testComplex128Of4D(testCase)
            real(:, :, 1, 1) = [[1, 2]', [3, 4]'];
            real(:, :, 2, 1) = [[5, 6]', [7, 8]'];
            real(:, :, 1, 2) = [[9, 10]', [11, 12]'];
            real(:, :, 2, 2) = [[13, 14]', [15, 16]'];
            imag(:, :, 1, 1) = [[1, 2]', [3, 4]'];
            imag(:, :, 2, 1) = [[5, 6]', [7, 8]'];
            imag(:, :, 1, 2) = [[9, 10]', [11, 12]'];
            imag(:, :, 2, 2) = [[13, 14]', [15, 16]'];
            A = complex(real, imag);
            a = tsa.Array(A);
            expected = A;
            b = a.getData();
            testCase.verifyEqual(b, expected);
        end
        
        function testCreateFromReference(testCase)
            a = tsa.Array(single([1 2 3 4; 5 6 7 8]'));
            b = tsa.Array(a.getReference());
            c = a.getData();
            d = b.getData();
            testCase.verifyEqual(c, d);
        end
    end
end
