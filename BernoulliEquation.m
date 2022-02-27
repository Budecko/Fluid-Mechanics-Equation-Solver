function BernoulliEquation()
    inputText = ['Choose you want to calculate - density (enter 1), ', ...
        'pressure (enter 2), velocity (enter 3) or height (enter 4): '];
    
    % Input text for initial parameters
    inputInitRo1 = 'Input initial density (kg/m^3): ';
    inputInitP1 = 'Input initial pressure (Pa): ';
    inputInitV1 = 'Input initial velocity (m/s): ';
    inputInitH1 = 'Input initial height (m): ';
    
    % Input text for final parameters
    inputFinalRo2 = 'Input final density (kg/m^3): ';
    inputFinalP2 = 'Input final pressure (Pa): ';
    inputFinalV2 = 'Input final velocity (m/s): ';
    inputFinalH2 = 'Input final height (m): ';
    
    g = 9.81; % Acceleration due to gravity

    % User enters parameter to calculate
    option = str2double(input(inputText, 's'));

    % Check if user entered a number
    if isnan(option)
        disp('You didn''t enter a number.'); % You didn't enter a number
        return;
    end
    
    % Check if entered number is either 1 or 2 or 3 or 4
    if ~ismember(option, 1:4)
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
        [inputInitP1, inputFinalP2] = swap(inputInitP1, inputFinalP2);
        [inputInitV1, inputFinalV2] = swap(inputInitV1, inputFinalV2);
        [inputInitH1, inputFinalH2] = swap(inputInitH1, inputFinalH2);
        
        textInitFinal = 'Initial';
    end

    [values, isCorrect] = getValues(inputInitRo1, ...
        inputInitP1, inputInitV1, inputInitH1);
    
    if ~isCorrect
        return;
    end
    
    ro1 = values(1); p1 = values(2); v1 = values(3); h1 = values(4);
    leftSide = p1 + ro1 * (v1 ^ 2 / 2 + g * h1); % Left side of equation
    
    switch option
        case 1 % Density
            [values, isCorrect] = getValues(inputFinalP2, ...
                inputFinalV2, inputFinalH2);
            
            if ~isCorrect
                return;
            end
            
            % Get pressure, velocity and height, respectively
            p2 = values(1); v2 = values(2); h2 = values(3);
            
            % Get density
            ro2 = (leftSide - p2) / (v2 ^ 2 / 2 + g * h2);
            
            fprintf('%s density is %.2f kg/m^3.\n', textInitFinal, ro2);
            
        case 2 % Pressure
            [values, isCorrect] = getValues(inputFinalRo2, ...
                inputFinalV2, inputFinalH2);
            
            if ~isCorrect
                return;
            end
            
            % Get density, velocity and height, respectively
            ro2 = values(1); v2 = values(2); h2 = values(3);
            
            % Get pressure
            p2 = leftSide - ro2 * (v2 ^ 2 / 2 + g * h2);
            
            fprintf('%s pressure is %.2f Pa.\n', textInitFinal, p2);
            
        case 3 % Velocity
            [values, isCorrect] = getValues(inputFinalRo2, ...
                inputFinalP2, inputFinalH2);
            
            if ~isCorrect
                return;
            end
            
            % Get density, pressure and height, respectively
            ro2 = values(1); p2 = values(2); h2 = values(3);
            
            % Get velocity
            v2 = sqrt(2 * (leftSide - p2 - ro2 * g * h2) / ro2);
            
            fprintf('%s velocity is %.2f m/s.\n', textInitFinal, v2);
            
        case 4 % Height
            [values, isCorrect] = getValues(inputFinalRo2, ...
                inputFinalP2, inputFinalV2);
            
            if ~isCorrect
                return;
            end
            
            % Get density, pressure and velocity, respectively
            ro2 = values(1); p2 = values(2); v2 = values(3);
            
            % Get height
            h2 = (leftSide - p2 - ro2 * v2 ^ 2 / 2) / (ro2 * g);
            
            fprintf('%s height is %.2f m.\n', textInitFinal, h2);
    end
end