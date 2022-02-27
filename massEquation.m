function massEquation()
    inputText = ['Choose you want to calculate: density (enter 1), ', ...
        'area (enter 2), velocity (enter 3): '];
    
    % Input text for initial parameters
    inputInitRo1 = 'Input initial density (kg/m^3): ';
    inputInitD1 = 'Input initial diameter (m): ';
    inputInitV1 = 'Input initial velocity (m/s): ';
    
    % Input text for final parameters
    inputFinalRo2 = 'Input final density (kg/m^3): ';
    inputFinalD2 = 'Input final diameter (m): ';
    inputFinalV2 = 'Input final velocity (m/s): ';
    
    option = str2double(input(inputText, 's'));
    
    if isnan(option)
        disp('You didn''t enter a number.'); % You didn't enter a number
        return;
    end
    
    if ~ismember(option, 1:3)
        disp('You didn''t choose any option.');
        return;
    end
    
    inputText2 = ['Choose what you want to calculate - ', ...
        'initial (enter 1) or final (enter 2) value: '];
    
    option2 = str2double(input(inputText2, 's'));
    
    % Check if user entered a number
    if isnan(option2)
        disp('You didn''t enter a number.'); % You didn't enter a number
        return;
    end
    
    % Check if entered number is either 1 or 2
    if ~ismember(option2, 1:2)
        disp('You didn''t choose any option.');
        return;
    end
    
    % In case that initial value needs to be calculated, this variable will
    % be 'Initial'. This variable is used in printing result.
    textInitFinal = 'Final';
    
    % IF statement below executes only if user want initial value to be
    % calculated. Originaly, I implemented calculation only for final
    % values. Later I added option to calculate initial value. In order not
    % to change vast majority of code below, I implemented function
    % [out1, out2] = swap(in1, in2) which writes value of in2 to out1 and
    % value of in1 to out2. Eg. let a = 2, b = 3. In this case function
    % [a, b] = swap(a, b) gives a = 3, b = 2. In IF statement below,
    % inputInitRo1 will be 'Input final density (kg/m^3): ', inputFinalRo2
    % will be 'Input initial density (kg/m^3): ', and so on.
    if option2 == 1
        [inputInitRo1, inputFinalRo2] = swap(inputInitRo1, inputFinalRo2);
        [inputInitD1, inputFinalD2] = swap(inputInitD1, inputFinalD2);
        [inputInitV1, inputFinalV2] = swap(inputInitV1, inputFinalV2);
        
        textInitFinal = 'Initial';
    end
    
    [values, isCorrect] = getValues(inputInitRo1, ...
        inputInitD1, inputInitV1);
    
    if ~isCorrect
        return;
    end
    
    ro1 = values(1); d1 = values(2); V1 = values(3);
    A1 = pi * d1 ^ 2 / 4; % Area
    leftSide = ro1 * A1 * V1; % Left side of equation
    
    switch option
        case 1 % Density
            [values, isCorrect] = getValues(inputFinalD2, inputFinalV2);

            if ~isCorrect
                return;
            end
            
            % Get diameter and velocity, respectively
            d2 = values(1); V2 = values(2);
            
            % Get area
            A2 = pi * d2 ^ 2 / 4;
            
            % Get density
            ro2 = leftSide / (A2 * V2);
            
            fprintf('%s density is %.2f kg/m^3.\n', textInitFinal, ro2);
            
        case 2 % Area
            [values, isCorrect] = getValues(inputFinalRo2, inputFinalV2);

            if ~isCorrect
                return;
            end
            
            % Get density and velocity, respectively
            ro2 = values(1); V2 = values(2);
            
            % Get area
            A2 = leftSide / (ro2 * V2);
            
            % Get diameter
            d2 = sqrt(4 * A2 / pi);
            
            fprintf('%s diameter is %.2f m^2.\n', textInitFinal, d2);
            fprintf('%s area is %.2f m^2.\n', textInitFinal, A2);
            
        case 3 % Velocity
            [values, isCorrect] = getValues(inputFinalRo2, inputFinalD2);

            if ~isCorrect
                return;
            end
            
            % Get density and diameter, respectively
            ro2 = values(1); d2 = values(2);
            
            % Get area
            A2 = pi * d2 ^ 2 / 4;
            
            % Get velocity
            V2 = leftSide / (ro2 * A2);
            
            fprintf('%s velocity is %.2f m/s.\n', textInitFinal, V2);
    end
end