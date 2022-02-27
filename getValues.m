function [values, isCorrect] = getValues(varargin)
    values = - ones(nargin, 1);

    for i = 1:nargin
        val = str2double(input(varargin{i}, 's'));
        if isnan(val)
            disp('Last entrance is not a number.');
            isCorrect = 0;
            return;
        end
        values(i) = val;
    end
    
    isCorrect = 1;
end