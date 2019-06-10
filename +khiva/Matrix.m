classdef Matrix < handle
    %% MATRIX class
    % Khiva Matrix Profile class containing matrix profile methods.

    % -------------------------------------------------------------------
    % Copyright (c) 2019 Shapelets.io
    %
    % This Source Code Form is subject to the terms of the Mozilla Public
    % License, v. 2.0. If a copy of the MPL was not distributed with this
    % file, You can obtain one at http://mozilla.org/MPL/2.0/.
    % -------------------------------------------------------------------

    methods(Static)
        function [discordsDistances, discordsIndices, subsequenceIndices] = ...
                findBestNDiscords(profile, index, m, n, selfJoin)
            %% FINDBESTNDISCORDS
            % This function extracts the best N discords from a previously
            % calculated matrix profile.
            %
            % *profile* A Khiva Array instance pointing to the matrix profile
            % containing the minimum distance of each subsequence.
            %
            % *index* A Khiva Array pointing to the matrix profile index
            % containing where each minimum occurs.
            %
            % *m* Subsequence length value used to calculate the input
            % matrix profile.
            %
            % *n* Number of discords to extract.
            %
            % *selfJoin* Indicates whether the input profile comes from a
            % self join operation or not. It determines whether the mirror
            % similar region is included in the output or not.
            %
            % *discordsDistances* A Khiva Array pointing to the distance of
            % the best N discords.
            %
            % *discordsIndices* A Khiva Array pointing to the indices of the
            % best N discords.
            %
            % *subsequenceIndices* A Khiva Array pointing to the indices of
            % the query sequences that produced the discords reported in
            % the discordsDistances output array.
            discordsDistancesRef = libpointer('voidPtrPtr');
            discordsIndicesRef = libpointer('voidPtrPtr');
            subsequenceIndicesRef = libpointer('voidPtrPtr');
            [~, ~, ~, ~, discordsDistancesRef, discordsIndicesRef, ...
                subsequenceIndicesRef, ~] = calllib('libkhivac', ...
                'find_best_n_discords', profile.getReference(), ...
                index.getReference(), m, n,  ...
                discordsDistancesRef, discordsIndicesRef, ...
                subsequenceIndicesRef, selfJoin);
            discordsDistances = khiva.Array(discordsDistancesRef);
            discordsIndices = khiva.Array(discordsIndicesRef);
            subsequenceIndices = khiva.Array(subsequenceIndicesRef);
        end

        function [motifsDistances, motifsIndices, subsequenceIndices] = ...
                findBestNMotifs(profile, index, m, n, selfJoin)
            %% FINDBESTNMOTIFS
            % This function extracts the best N motifs from a previously
            % calculated matrix profile.
            %
            % *profile* A Khiva Array instance pointing to the matrix profile
            % containing the minimum distance of each subsequence.
            %
            % *index* A Khiva Array pointing to the matrix profile index
            % containing where each minimum occurs.
            %
            % *m* Subsequence length value used to calculate the input
            % matrix profile.
            %
            % *n* Number of motifs to extract.
            %
            % *selfJoin* Indicates whether the input profile comes from a
            % self join operation or not. It determines whether the mirror
            % similar region is included in the output or not.
            %
            % *motifsDistances* A Khiva Array pointing to the distance of
            % the best N motifs.
            %
            % *motifsIndices* A Khiva Array pointing to the indices of the
            % best N motifs.
            %
            % *subsequenceIndices* A Khiva Array pointing to the indices of
            % the query sequences that produced the motifs reported in
            % the motifsDistances output array.
            motifsDistancesRef = libpointer('voidPtrPtr');
            motifsIndicesRef = libpointer('voidPtrPtr');
            subsequenceIndicesRef = libpointer('voidPtrPtr');
            [~, ~, ~, ~, motifsDistancesRef, motifsIndicesRef, ...
                subsequenceIndicesRef, ~] = calllib('libkhivac', ...
                'find_best_n_motifs', profile.getReference(), ...
                index.getReference(), m, n, ...
                motifsDistancesRef, motifsIndicesRef, ...
                subsequenceIndicesRef, selfJoin);
            motifsDistances = khiva.Array(motifsDistancesRef);
            motifsIndices = khiva.Array(motifsIndicesRef);
            subsequenceIndices = khiva.Array(subsequenceIndicesRef);
        end

        function [profile, index] = stomp(tssa, tssb, m)
            %% STOMP
            % STOMP algorithm to calculate the matrix profile between *tssa*
            % and *tssb* using a subsequence length of *m*.
            %
            % [1] Yan Zhu, Zachary Zimmerman, Nader Shakibay Senobari,
            % Chin-Chia Michael Yeh, Gareth Funning, Abdullah Mueen,
            % Philip Brisk and Eamonn Keogh (2016). Matrix Profile II:
            % Exploiting a Novel Algorithm and GPUs to break
            % the one Hundred Million Barrier for Time Series Motifs and Joins.
            % IEEE ICDM 2016.
            %
            % *tssa* is an instance of the Khiva array class, which points
            % to an array stored in the device side. Such array might
            % contain one or multiple time series (one per column).
            %
            % *tssb* is an instance of the Khiva array class, which points
            % to an array stored in the device side. Such array might
            % contain one or multiple time series (one per column).
            %
            % *m* Number of discords to extract.
            %
            % *profile* A Khiva Array instance pointing to the matrix profile
            % containing the minimum distance of each subsequence.
            %
            % *index* A Khiva Array pointing to the matrix profile index
            % containing where each minimum occurs.
            profileRef = libpointer('voidPtrPtr');
            indexRef = libpointer('voidPtrPtr');
            [~, ~, ~, profileRef, indexRef] = calllib('libkhivac', ...
                'stomp', tssa.getReference(), ...
                tssb.getReference(), m, profileRef, indexRef);
            profile = khiva.Array(profileRef);
            index = khiva.Array(indexRef);
        end

        function [profile, index] = stompSelfJoin(tss, m)
            %% STOMPSELFJOIN
            % STOMP algorithm to calculate the matrix profile between *tss*
            % and itself using a subsequence length of 'm'. This method
            % filters the trivial matches.
            %
            % [1] Yan Zhu, Zachary Zimmerman, Nader Shakibay Senobari,
            % Chin-Chia Michael Yeh, Gareth Funning, Abdullah Mueen,
            % Philip Brisk and Eamonn Keogh (2016). Matrix Profile II:
            % Exploiting a Novel Algorithm and GPUs to break
            % the one Hundred Million Barrier for Time Series Motifs and Joins.
            % IEEE ICDM 2016.
            %
            % *tss* is an instance of the Khiva array class, which points
            % to an array stored in the device side. Such array might
            % contain one or multiple time series (one per column).
            %
            % *m* Number of discords to extract.
            %
            % *profile* A Khiva Array instance pointing to the matrix profile
            % containing the minimum distance of each subsequence.
            %
            % *index* A Khiva Array pointing to the matrix profile index
            % containing where each minimum occurs.
            profileRef = libpointer('voidPtrPtr');
            indexRef = libpointer('voidPtrPtr');
            [~, ~, profileRef, indexRef] = calllib('libkhivac', ...
                'stomp_self_join', tss.getReference(), m, profileRef, ...
                indexRef);
            profile = khiva.Array(profileRef);
            index = khiva.Array(indexRef);
        end
        
        function distances = mass(query, tss)
            % Mueen's Algorithm for Similarity Search.
            % 
            % The result has the following structure:
            % - 1st dimension corresponds to the index of the subsequence in
            %   the time series.
            % - 2nd dimension corresponds to the number of queries.
            % - 3rd dimension corresponds to the number of time series.
            % 
            % For example, the distance in the position (1, 2, 3) correspond
            % to the distance of the third query to the fourth time series 
            % for the second subsequence in the time series.
            % 
            % [1] Yan Zhu, Zachary Zimmerman, Nader Shakibay Senobari,
            % Chin-Chia Michael Yeh, Gareth Funning, Abdullah Mueen,
            % Philip Brisk and Eamonn Keogh (2016). Matrix Profile II:
            % Exploiting a Novel Algorithm and GPUs to break
            % the one Hundred Million Barrier for Time Series Motifs and Joins.
            % IEEE ICDM 2016.
            %
            % *query* KHIVA Array whose first dimension is the length of the
            % query time series and the second dimension is the number of
            % queries.
            % 
            % *tss*   KHIVA Array whose first dimension is the length of the
            % time series and the second dimension is the number of time
            % series.
            %
            % *distances* KHIVA Array with the distances.
            distancesRef = libpointer('voidPtrPtr');
            [~, ~, distancesRef] = calllib('libkhivac', ...
                'mass', query.getReference(), tss.getReference(), ...
                distancesRef);
            distances = khiva.Array(distancesRef);
        end
        
        function [distances, indexes] = findBestNOccurrences(query, tss, n)
            % Calculates the N best matches of several queries in several time series.
            %
            % The result has the following structure:
            % - 1st dimension corresponds to the nth best match.
            % - 2nd dimension corresponds to the number of queries.
            % - 3rd dimension corresponds to the number of time series.
            %
            % For example, the distance in the position (1, 2, 3) corresponds to the
            % second best distance of the third query in the fourth time series.
            % The index in the position (1, 2, 3) is the is the index of the
            % subsequence which leads to the second best distance of the third query
            % in the fourth time series.
            %
            % *query* KHIVA Array whose first dimension is the length of the query
            % time series and the second dimension is the number of queries.
            %
            % *tss*   KHIVA Array whose first dimension is the length of the time
            % series and the second dimension is the number of time series.
            %
            % *n*     Number of matches to return.
            %
            % *distances*  KHIVA Arrays with the distances.
            %
            % *indexes*  KHIVA Arrays with the indexes.            
            distancesRef = libpointer('voidPtrPtr');
            indexesRef = libpointer('voidPtrPtr');
            [~, ~, ~, distancesRef, indexesRef] = calllib('libkhivac', ...
                'find_best_n_occurrences', query.getReference(), ...
                tss.getReference(), n, distancesRef, indexesRef);
            distances = khiva.Array(distancesRef);
            indexes = khiva.Array(indexesRef);
        end
    end
end
