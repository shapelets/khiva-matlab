classdef Distances < handle
    %% Distances class
    % TSA Distances class containing distances methods.
    
    % -------------------------------------------------------------------
    % Copyright (c) 2018 Grumpy Cat Software S.L.
    %
    % This Source Code Form is subject to the terms of the Mozilla Public
    % License, v. 2.0. If a copy of the MPL was not distributed with this
    % file, You can obtain one at http://mozilla.org/MPL/2.0/.
    % -------------------------------------------------------------------
    
    methods(Static)
        function e = euclidean(array)
            %% EUCLIDEAN
            % Calculates euclidean distances between time series.
            %
            % *array* is an instance of the TSA array class, which points
            % to an array stored in the device side. Such array might
            % contain one or multiple time series (one per column).
            result = libpointer('voidPtrPtr');
            [~, result] = calllib('libtsac', 'euclidean', ...
                array.getReference(), result);
            e = tsa.Array(result);
        end
        
        function se = squaredEuclidean(array)
            %% SQUAREDEUCLIDEAN
            % Calculates non squared version of the euclidean distance.
            %
            % *array* is an instance of the TSA array class, which points
            % to an array stored in the device side. Such array might
            % contain one or multiple time series (one per column).
            result = libpointer('voidPtrPtr');
            [~, result] = calllib('libtsac', 'squared_euclidean', ...
                array.getReference(), result);
            se = tsa.Array(result);
        end
        function d = dtw(array)
            %% DTW
            % Calculates the Dynamic Time Warping Distance.
            %
            % *array* is an instance of the TSA array class, which points
            % to an array stored in the device side. Such array might
            % contain one or multiple time series (one per column).
            result = libpointer('voidPtrPtr');
            [~, result] = calllib('libtsac', 'dtw', ...
                array.getReference(), result);
            d = tsa.Array(result);
        end
    end
end