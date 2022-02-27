function momentumEquation()
    % Input text for mass flow
    inputMassFlow = 'Input mass flow (kg/s): ';
    
    % Input text for initial parameters
    inputInitV1X = 'Input x-component of initial velocity (m/s): ';
    inputInitV1Y = 'Input y-component of initial velocity (m/s): ';
    inputInitV1Z = 'Input z-component of initial velocity (m/s): ';
    
    % Input text for final parameters
    inputFinalV2X = 'Input x-component of final velocity (m/s): ';
    inputFinalV2Y = 'Input y-component of final velocity (m/s): ';
    inputFinalV2Z = 'Input z-component of final velocity (m/s): ';
    
    [values, isCorrect] = getValues(inputMassFlow, ...
        inputInitV1X, inputInitV1Y, inputInitV1Z, ...
        inputFinalV2X, inputFinalV2Y, inputFinalV2Z);
    
    if ~isCorrect
        return;
    end
    
    % Mass flow
    mFlow = values(1);
    
    % Get initial and final velocity components, respectively
    v1X = values(2); v1Y = values(3); v1Z = values(4);
    v2X = values(5); v2Y =values(6); v2Z = values(7);
    
    F1X = mFlow * (v2X - v1X); % X-component of pressure force vector
    F1Y = mFlow * (v2Y - v1Y); % Y-component of pressure force vector
    F1Z = mFlow * (v2Z - v1Z); % Z-component of pressure force vector
    
    forceVec = [F1X; F1Y; F1Z]; % Pressure force vector
    
    % Get pressure force value
    force = 0;
    for i = 1:size(forceVec)
        force = force + forceVec(i) ^ 2;
    end
    force = sqrt(force); % Pressure force value
    
    % Print results
    fprintf('X-component of pressure force vector is %.2f N.\n', F1X);
    fprintf('Y-component of pressure force vector is %.2f N.\n', F1Y);
    fprintf('Z-component of pressure force vector is %.2f N.\n', F1Z);
    fprintf('Pressure force is %.2f N.\n', force);
end