classdef Clustering < handle
    %% CLUSTERING class
    % Khiva Clustering class containing several clustering methods.
    
    % -------------------------------------------------------------------
    % Copyright (c) 2018 Shapelets.io
    %
    % This Source Code Form is subject to the terms of the Mozilla Public
    % License, v. 2.0. If a copy of the MPL was not distributed with this
    % file, You can obtain one at http://mozilla.org/MPL/2.0/.
    % -------------------------------------------------------------------
    
    methods(Static)
        function [centroids, labels] = kMeans(array, k, tolerance, ...
            maxIterations)
            %% KMEANS
            % Calculates the K-Means algorithm.
            %
            % [1] S. Lloyd. 1982. Least squares quantization in PCM. IEEE
            % Transactions on Information Theory, 28, 2, Pages 129-137.
            %
            % *array* is an instance of the Khiva array class, which points
            % to an array stored in the device side. Such array might
            % contain one or multiple time series (one per column).
            %
            % *k* The number of means to be computed.
            %
            % *tolerance* The error tolerance to stop the computation of
            % the centroids.
            %
            % *maxIterations* The maximum number of iterations allowed.
            centroidsRef = libpointer('voidPtrPtr');
            labelsRef = libpointer('voidPtrPtr');
            [~, ~, centroidsRef, labelsRef, ~, ~] = calllib('libkhivac', 'k_means', ...
                array.getReference(), k, centroidsRef, labelsRef, tolerance, ...
                maxIterations);
            centroids = khiva.Array(centroidsRef);
            labels = khiva.Array(labelsRef);
        end
        
        function [centroids, labels] = kShape(array, k, tolerance, ...
            maxIterations)
            %% KSHAPE
            % Calculates the K-Shape algorithm.
            %
            % [1] John Paparrizos and Luis Gravano. 2016. k-Shape:
            % Efficient and Accurate Clustering of Time Series. SIGMOD Rec.
            % 45, 1 (June 2016), 69-76.
            %
            % *array* is an instance of the Khiva array class, which points
            % to an array stored in the device side. Such array might
            % contain one or multiple time series (one per column).
            %
            % *k* The number of means to be computed.
            %
            % *tolerance* The error tolerance to stop the computation of
            % the centroids.
            %
            % *maxIterations* The maximum number of iterations allowed.
            centroidsRef = libpointer('voidPtrPtr');
            labelsRef = libpointer('voidPtrPtr');
            [~, ~, centroidsRef, labelsRef, ~, ~] = calllib('libkhivac', 'k_shape', ...
                array.getReference(), k, centroidsRef, labelsRef, tolerance, ...
                maxIterations);
            centroids = khiva.Array(centroidsRef);
            labels = khiva.Array(labelsRef);
        end
    end
end