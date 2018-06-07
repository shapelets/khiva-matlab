%% Test Class Definition
classdef ArrayUnitTests < matlab.unittest.TestCase
    
    % -------------------------------------------------------------------
    % Copyright (c) 2018 Shapelets.io
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
        function testReal1D(testCase)
            a = khiva.Array([1, 2, 3, 4, 5, 6, 7, 8]');
            expected = [1, 2, 3, 4, 5, 6, 7, 8]';
            b = a.getData();
            testCase.verifyEqual(b, expected);
        end
        
        function testReal2D(testCase)
            a = khiva.Array([[1, 2, 3, 4]', [5, 6, 7, 8]']);
            expected = [[1, 2, 3, 4]', [5, 6, 7, 8]'];
            b = a.getData();
            testCase.verifyEqual(b, expected);
        end
        
        function testReal3D(testCase)
            A(:, :, 1) = [[1, 2]', [3, 4]'];
            A(:, :, 2) = [[5, 6]', [7, 8]'];
            a = khiva.Array(A);
            expected = A;
            b = a.getData();
            testCase.verifyEqual(b, expected);
        end
        
        function testReal4D(testCase)
            A(:, :, 1, 1) = [[1, 2]', [3, 4]'];
            A(:, :, 2, 1) = [[5, 6]', [7, 8]'];
            A(:, :, 1, 2) = [[9, 10]', [11, 12]'];
            A(:, :, 2, 2) = [[13, 14]', [15, 16]'];
            a = khiva.Array(A);
            expected = A;
            b = a.getData();
            testCase.verifyEqual(b, expected);
        end
        
        function testComplex64Of1D(testCase)
            A = single(complex([1, 2, 3, 4]', [5, 6, 7, 8]'));
            a = khiva.Array(A);
            expected = A;
            b = a.getData();
            testCase.verifyEqual(b, expected);
        end
        
        function testComplex64Of2D(testCase)
            A = single(complex([[1, 2, 3, 4]', [9, 10, 11, 12]'], [[5, 6, 7, 8]', [13, 14, 15, 16]']));
            a = khiva.Array(A);
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
            a = khiva.Array(A);
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
            a = khiva.Array(A);
            expected = A;
            b = a.getData();
            testCase.verifyEqual(b, expected);
        end
        
        function testComplex128Of1D(testCase)
            A = complex([1, 2, 3, 4]', [5, 6, 7, 8]');
            a = khiva.Array(A);
            expected = A;
            b = a.getData();
            testCase.verifyEqual(b, expected);
        end
        
        function testComplex128Of2D(testCase)
            A = complex([[1, 2, 3, 4]', [9, 10, 11, 12]'], [[5, 6, 7, 8]', [13, 14, 15, 16]']);
            a = khiva.Array(A);
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
            a = khiva.Array(A);
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
            a = khiva.Array(A);
            expected = A;
            b = a.getData();
            testCase.verifyEqual(b, expected);
        end
        
        function testPlus(testCase)
            a = khiva.Array([1 2 3 4]);
            b = khiva.Array([1 2 3 4]);
            c = a + b;
            expected = [2 4 6 8];
            testCase.verifyEqual(c.getData(), expected);
        end
        
        function testTimes(testCase)
            a = khiva.Array([1 2 3 4]);
            b = khiva.Array([1 2 3 4]);
            c = a .* b;
            expected = [1 4 9 16];
            testCase.verifyEqual(c.getData(), expected);
        end
        
        function testMinus(testCase)
            a = khiva.Array([1 2 3 4]);
            b = khiva.Array([1 2 3 4]);
            c = a - b;
            expected = [0 0 0 0];
            testCase.verifyEqual(c.getData(), expected);
        end
        
        function testRdivide(testCase)
            a = khiva.Array([1 2 3 4]);
            b = khiva.Array([1 2 3 4]);
            c = a ./ b;
            expected = [1 1 1 1];
            testCase.verifyEqual(c.getData(), expected);
        end
        
        function testMod(testCase)
            a = khiva.Array([1 2 3 4]);
            b = khiva.Array([2 2 2 2]);
            c = mod(a, b);
            expected = [1 0 1 0];
            testCase.verifyEqual(c.getData(), expected);
        end
        
        function testPower(testCase)
            a = khiva.Array([1 2 3 4]);
            b = khiva.Array([2 2 2 2]);
            c = a .^ b;
            expected = [1 4 9 16];
            testCase.verifyEqual(c.getData(), expected);
        end
        
        function testLt(testCase)
            a = khiva.Array([1 2 3 4]);
            b = khiva.Array([2 2 2 2]);
            c = a < b;
            expected = [true false false false];
            testCase.verifyEqual(c.getData(), expected);
        end
        
        function testGt(testCase)
            a = khiva.Array([1 2 3 4]);
            b = khiva.Array([2 2 2 2]);
            c = a > b;
            expected = [false false true true];
            testCase.verifyEqual(c.getData(), expected);
        end
        
        function testLe(testCase)
            a = khiva.Array([1 2 3 4]);
            b = khiva.Array([2 2 2 2]);
            c = a <= b;
            expected = [true true false false];
            testCase.verifyEqual(c.getData(), expected);
        end
        
        function testGe(testCase)
            a = khiva.Array([1 2 3 4]);
            b = khiva.Array([2 2 2 2]);
            c = a >= b;
            expected = [false true true true];
            testCase.verifyEqual(c.getData(), expected);
        end
        
        function testEq(testCase)
            a = khiva.Array([1 2 3 4]);
            b = khiva.Array([1 2 3 5]);
            c = a == b;
            expected = [true true true false];
            testCase.verifyEqual(c.getData(), expected);
        end
        
        function testNe(testCase)
            a = khiva.Array([1 2 3 4]);
            b = khiva.Array([1 2 3 5]);
            c = a ~= b;
            expected = [false false false true];
            testCase.verifyEqual(c.getData(), expected);
        end
        
        function testAnd(testCase)
            a = khiva.Array([true true true true]);
            b = khiva.Array([true false true false]);
            c = a & b;
            expected = [true false true false];
            testCase.verifyEqual(c.getData(), expected);
        end
        
        function testOr(testCase)
            a = khiva.Array([true true true true]);
            b = khiva.Array([true false true false]);
            c = a | b;
            expected = [true true true true];
            testCase.verifyEqual(c.getData(), expected);
        end
        
        function testXor(testCase)
            a = khiva.Array([true true true true]);
            b = khiva.Array([true false true false]);
            c = xor(a, b);
            expected = [false true false true];
            testCase.verifyEqual(c.getData(), expected);
        end
        
        function testBitshift(testCase)
            a = khiva.Array(int32([2 4 6 8]));
            b = bitshift(a, 1);
            expected = int32([4 8 12 16]);
            testCase.verifyEqual(b.getData(), expected);
        end
        
        function testBitsra(testCase)
            a = khiva.Array(int32([2 4 6 8]));
            b = bitsra(a, 1);
            expected = int32([1 2 3 4]);
            testCase.verifyEqual(b.getData(), expected);
        end
        
        function testCtranspose(testCase)
            a = khiva.Array([0-1i 2+1i; 4+2i 0-2i]);
            b = a';
            expected = [0+1i 4-2i; 2-1i 0+2i];
            testCase.verifyEqual(b.getData(), expected);
        end
        
        function testTranspose(testCase)
            a = khiva.Array([1 2; 3 4]);
            b = a';
            expected = [1 3; 2 4];
            testCase.verifyEqual(b.getData(), expected);
        end
        
        function testCol(testCase)
            a = khiva.Array([1 2; 3 4]);
            b = a.col(0);
            expected = [1 3]';
            testCase.verifyEqual(b.getData(), expected);
        end
        
        function testCols(testCase)
            a = khiva.Array([1 2 3; 4 5 6]);
            b = a.cols(0, 1);
            expected = [1 2; 4 5];
            testCase.verifyEqual(b.getData(), expected);
        end
        
        function testRow(testCase)
            a = khiva.Array([1 2; 3 4]);
            b = a.row(0);
            expected = [1 2];
            testCase.verifyEqual(b.getData(), expected);
        end
        
        function testRows(testCase)
            a = khiva.Array([1 2; 3 4; 5 6]);
            b = a.rows(0, 1);
            expected = [1 2; 3 4];
            testCase.verifyEqual(b.getData(), expected);
        end
        
        function testMtimes(testCase)
            a = khiva.Array([1 2 3 4]');
            b = khiva.Array([1 2 3 4]);
            c = a * b;
            expected = [1 2 3 4; 2 4 6 8; 3 6 9 12; 4 8 12 16];
            testCase.verifyEqual(c.getData(), expected);
        end
        
        function testCopy(testCase)
            a = khiva.Array([1 2 3 4]);
            b = copy(a);
            c = a.eq(b);
            expected = [true, true, true, true];
            testCase.verifyEqual(c.getData(), expected);
        end
        
        function testAs(testCase)
            a = khiva.Array(int32([1 2 3 4]));
            b = a.as(khiva.Dtype.u32);
            expectedData = uint32([1 2 3 4]);
            expectedType = khiva.Dtype.u32;
            testCase.verifyEqual(b.getData(), expectedData);
            testCase.verifyEqual(b.getType(), expectedType);
        end
    end
end
