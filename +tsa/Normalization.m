classdef Normalization < handle
    %% NORMALIZATION class
    % TSA Normalization class containing different normalization methods.
    
    % -------------------------------------------------------------------
    % Copyright (c) 2018 Grumpy Cat Software S.L.
    %
    % This Source Code Form is subject to the terms of the Mozilla Public
    % License, v. 2.0. If a copy of the MPL was not distributed with this
    % file, You can obtain one at http://mozilla.org/MPL/2.0/.
    % -------------------------------------------------------------------
    
    methods(Static)
        function zn = zNorm(array, epsilon)
            %% ZNORM
            % Calculates a new set of timeseries with zero mean and
            % standard deviation one.
            %
            % *array* is an instance of the TSA array class, which points
            % to an array stored in the device side. Such array might
            % contain one or multiple time series (one per column).
            result = libpointer('voidPtrPtr');
            [~, ~, result] = calllib('libtsac', 'znorm', ...
                array.getReference(), epsilon, result);
            zn = tsa.Array(result);
        end
        
        function znip = zNormInPlace(array, epsilon)
            %% ZNORMINPLACE
            % Adjusts the time series in the given input and performs
            % z-norm inplace (without allocating further memory).
            %
            % *array* is an instance of the TSA array class, which points
            % to an array stored in the device side. Such array might
            % contain one or multiple time series (one per column).
            calllib('libtsac', 'znorm_in_place', ...
                array.getReference(), epsilon);
            znip = array;
        end
    end
end