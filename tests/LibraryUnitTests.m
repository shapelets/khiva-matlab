%% Test Class Definition
classdef LibraryUnitTests < matlab.unittest.TestCase
    
    % -------------------------------------------------------------------
    % Copyright (c) 2018 Shapelets.io
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
            testCase.lib = khiva.Library.instance();
        end
    end
    
    %% Test Method Block
    methods (Test)
        function testSetBackend(testCase)
            % Storing current backend and device
            prevBackend = testCase.lib.getBackend();
            prevDevice = testCase.lib.getDeviceId();
            
            backends = testCase.lib.getBackends();
            cuda = bitand(backends,int32(khiva.Backend.KHIVA_BACKEND_CUDA));
            cpu = bitand(backends,int32(khiva.Backend.KHIVA_BACKEND_CPU));
            opencl = bitand(backends,int32(khiva.Backend.KHIVA_BACKEND_OPENCL));
            if cuda
                testCase.lib.setBackend(khiva.Backend.KHIVA_BACKEND_CUDA);
                backend = testCase.lib.getBackend();
                testCase.verifyEqual(backend, khiva.Backend.KHIVA_BACKEND_CUDA);
            end
            if cpu
                testCase.lib.setBackend(khiva.Backend.KHIVA_BACKEND_CPU);
                backend = testCase.lib.getBackend();
                testCase.verifyEqual(backend, khiva.Backend.KHIVA_BACKEND_CPU);
            end
            if opencl
                testCase.lib.setBackend(khiva.Backend.KHIVA_BACKEND_OPENCL);
                backend = testCase.lib.getBackend();
                testCase.verifyEqual(backend, khiva.Backend.KHIVA_BACKEND_OPENCL);
            end
            
            % Restoring the previous backend
            testCase.lib.setBackend(prevBackend);
            testCase.lib.setDevice(prevDevice);
        end
        
        function testSetDevice(testCase)
            % Storing current backend and device
            prevBackend = testCase.lib.getBackend();
            prevDevice = testCase.lib.getDeviceId();
            
            backends = testCase.lib.getBackends();
            cuda = bitand(backends,int32(khiva.Backend.KHIVA_BACKEND_CUDA));
            cpu = bitand(backends,int32(khiva.Backend.KHIVA_BACKEND_CPU));
            opencl = bitand(backends,int32(khiva.Backend.KHIVA_BACKEND_OPENCL));
            if cuda
                testCase.lib.setBackend(khiva.Backend.KHIVA_BACKEND_CUDA);
                for i = 0:testCase.lib.getDeviceCount()-1
                    testCase.lib.setDevice(i);
                    device = testCase.lib.getDeviceId();
                    testCase.verifyEqual(device, i);
                end
            end
            if cpu
                testCase.lib.setBackend(khiva.Backend.KHIVA_BACKEND_CPU);
                for i = 0:testCase.lib.getDeviceCount()-1
                    testCase.lib.setDevice(i);
                    device = testCase.lib.getDeviceId();
                    testCase.verifyEqual(device, i);
                end
            end
            if opencl
                testCase.lib.setBackend(khiva.Backend.KHIVA_BACKEND_OPENCL);
                for i = 0:testCase.lib.getDeviceCount()-1
                    testCase.lib.setDevice(i);
                    device = testCase.lib.getDeviceId();
                    testCase.verifyEqual(device, i);
                end
            end
            
            % Restoring the previous backend
            testCase.lib.setBackend(prevBackend);
            testCase.lib.setDevice(prevDevice);
        end
        
        function version(testCase)
            v = testCase.lib.version();
            testCase.verifyEqual(v, '0.0.1');
        end
    end
end
