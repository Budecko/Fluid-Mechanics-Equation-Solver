function energyEquation()

    % Input text for user to choose either uniform or nonuniform equation
    inputText = ['Do you need equation for steady uniform flow ', ...
        '(enter 1) or for steady nonuniform flow (enter 2)? '];
    
    option = str2double(input(inputText, 's'));
    
    % Check if number is entered
    if isnan(option)
        disp('You didn''t enter a number.'); % You didn't enter a number
        return;
    end
    
    % If user entered a number which is neither option 1 nor option 2
    if ~ismember(option, 1:2)
        disp('You didn''t choose any option.');
        return;
    end
    
    inputText2 = ['Choose you want to calculate: pressure (enter 1), ', ...
        'velocity (enter 2) or height (enter 3): '];
    
    inputRo = 'Input density (kg/m^3): ';
    
    % Input text for initial parameters
    inputInitP1 = 'Input initial pressure (Pa): ';
    inputInitV1 = 'Input initial velocity (m/s): ';
    inputInitH1 = 'Input initial height (m): ';
    
    % Input text for final parameters
    inputFinalP2 = 'Input final pressure (Pa): ';
    inputFinalV2 = 'Input final velocity (m/s): ';
    inputFinalH2 = 'Input final height (m): ';
    
    % Input text for mass flow
    inputMassFlow = 'Input mass flow (kg/s): ';
    
    % Input text for parameters used to calculate power generated
    % by pump
    inputHp = 'Input pump head (m): ';
    inputEfficiencyEtaP = 'Input pump efficiency (range 0-1): ';
    
    % Input text for parameters used to calculate power generated
    % by turbine
    inputHt = 'Input turbine head (m): ';
    inputEfficiencyEtaT = ['Input efficiency of turbine (range 0-1): '];
    
    % Input text for parameters used to calculate power head loss
    inputK = 'Input loss coefficient: ';
    inputVloss = 'Input loss velocity: ';
    
    g = 9.81; % Acceleration due to gravity

    option2 = str2double(input(inputText2, 's'));

    if isnan(option2)
        disp('You didn''t enter a number.'); % You didn't enter a number
        return;
    end
    
    if ~ismember(option2, 1:3)
        disp('You didn''t choose any option.');
        return;
    end
    
    inputText4 = ['Do you want to input pump head (enter 1), ', ...
        'turbine head (enter 2) or neither of them (enter 0)? '];
    
    option4 = str2double(input(inputText4, 's'));
    
    % Check if user entered a number
    if isnan(option4)
        disp('You didn''t enter a number.'); % You didn't enter a number
        return;
    end
    
    % Check if entered number is either 0, 1 or 2
    if ~ismember(option4, 0:2)
        disp('You didn''t choose any option.');
        return;
    end
    
    inputText3 = ['Choose what you want to calculate - ', ...
        'initial (enter 1) or final (enter 2) value: '];
    
    option3 = str2double(input(inputText3, 's'));
    
    % Check if user entered a number
    if isnan(option3)
        disp('You didn''t enter a number.'); % You didn't enter a number
        return;
    end
    
    % Check if entered number is either 1 or 2
    if ~ismember(option3, 1:2)
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
    % inputInitP1 will be 'Input final pressure (Pa): ', inputFinalP2
    % will be 'Input initial pressure (Pa): ', and so on.
    if option3 == 1
        [inputInitP1, inputFinalP2] = swap(inputInitP1, inputFinalP2);
        [inputInitV1, inputFinalV2] = swap(inputInitV1, inputFinalV2);
        [inputInitH1, inputFinalH2] = swap(inputInitH1, inputFinalH2);
        
        textInitFinal = 'Initial';
    end

    [values, isCorrect] = getValues(inputRo, ...
        inputInitP1, inputInitV1, inputInitH1);
    
    if ~isCorrect
        return;
    end
    
    % Get density, initial pressure, initial velocity and initial
    % height from vector of values, respectively
    ro = values(1); p1 = values(2); v1 = values(3); h1 = values(4);
    
    H = 0; W = 0; textPumpTurbine = '';
    
    switch option4
        case 1 % Pump head
            [values, isCorrect] = getValues(inputMassFlow, ...
                inputHp, inputEfficiencyEtaP);
            
            if ~isCorrect
                return;
            end
            
            mFlow = values(1); H = values(2); Eta = values(3);
            W = mFlow * g * H / Eta; % Power generated by pump
            
            textPumpTurbine = 'pump';
            
        case 2 % Turbine head
            [values, isCorrect] = getValues(inputMassFlow, ...
                inputHt, inputEfficiencyEtaT);
            
            if ~isCorrect
                return;
            end
            
            mFlow = values(1); H = values(2); Eta = values(3);
            W = mFlow * g * H * Eta; % Power generated by turbine
            
            textPumpTurbine = 'turbine';     
    end
    
    [values, isCorrect] = getValues(inputK, inputVloss);
    
    if ~isCorrect
        return;
    end
    
    K = values(1); Vloss = values(2);
    Hl = K * Vloss ^ 2 / (2 * g); % Head loss
    
    if W
        fprintf('Power generated by %s is %.2f W.\n', textPumpTurbine, W);
    end
    fprintf('Head loss is %.2f m.\n', Hl);
    
    % Steady uniform and steady nonuniform flow equations are so similar.
    % Latter equation contains kinetic energy correction factors alpha1
    % and alpha2, respectively.
    alpha1 = 1; alpha2 = 1;

    if option == 2
        inputAlpha1 = 'Input kinetic energy correction factor alpha1: ';
        inputAlpha2 = 'Input kinetic energy correction factor alpha2: ';
        
        [values, isCorrect] = getValues(inputAlpha1, inputAlpha2);
        
        if ~isCorrect
            return;
        end
        
        alpha1 = values(1); alpha2 = values(2);
    end
    
    % Left side of equation
    leftSide = H + alpha1 * v1 ^ 2 / (2 * g) + p1 / (ro * g) + h1;
    
    switch option2
        case 1 % Pressure
            [values, isCorrect] = getValues(inputFinalV2, inputFinalH2);
            
            if ~isCorrect
                return;
            end
            
            % Get velocity and height, respectively
            v2 = values(1); h2 = values(2);
            
            % Temporary variable
            temp = leftSide - (H + Hl + h2 + alpha2 * v2 ^ 2 / (2 * g));
            
            % Get pressure
            p2 = temp * ro * g;
            
            fprintf('%s pressure is %.2f Pa.\n', textInitFinal, p2);
            
        case 2 % Velocity
            [values, isCorrect] = getValues(inputFinalP2, inputFinalH2);
            
            if ~isCorrect
                return;
            end
            
            % Get pressure and height, respectively
            p2 = values(1); h2 = values(2);
            
            % Temporary variable
            temp = leftSide - (H + Hl + h2 + p2 / (ro * g));
            
            % Get velocity
            v2 = sqrt(temp * 2 * g / alpha2);
            
            fprintf('%s velocity is %.2f m/s.\n', textInitFinal, v2);
            
        case 3 % Height
            [values, isCorrect] = getValues(inputFinalP2, inputFinalV2);
            
            if ~isCorrect
                return;
            end
            
            % Get final pressure and final velocity, respectively
            p2 = values(1); v2 = values(2);
            
            % Temporary variable
            temp = H + Hl + p2 / (ro * g) + alpha2 * v2 ^ 2 / (2 * g);
            
            % Get height
            h2 = leftSide - (temp);
            
            fprintf('%s height is %.2f m.\n', textInitFinal, h2);
    end
end