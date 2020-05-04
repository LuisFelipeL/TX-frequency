function msg_decoded = destination_hamming(msg_channel, n, k)
    % ------ Inicializaci�n de parametros Hamming ------
    parity_matrix = [ 1 1 0;0 1 1;1 1 1;1 0 1];                  % Matriz de paridad
    parity_verification_matrix = [ eye(n-k) parity_matrix' ];    % Check matriz de paridad
    syndrome = mod(msg_channel * parity_verification_matrix',2); % Sindrome del mensaje recibido del canal
    syndrome_index = bi2de(syndrome);                            % Indice de los errores seg�n el sindrome del mensaje
    
    % ------ Reconstrucci�n Hamming ------
    syndrome_verification_1 = [0 0 0; 
                               1 0 0; 
                               0 1 0; 
                               1 1 0; 
                               0 0 1; 
                               1 0 1; 
                               0 1 1;
                               1 1 1]; % Matriz de verificaci�n del sindrome (No se usa, solo referencia)

    % Matriz con todos los errores posibles (indexados seg�n la matriz de verificaci�n)
    syndrome_verification_2 = [0 0 0 0 0 0 0; 
                               1 0 0 0 0 0 0; 
                               0 1 0 0 0 0 0; 
                               0 0 0 1 0 0 0; 
                               0 0 1 0 0 0 0; 
                               0 0 0 0 0 0 1; 
                               0 0 0 0 1 0 0; 
                               0 0 0 0 0 1 0];
    
    error_position = syndrome_verification_2(syndrome_index(1:end)+1,:); % Obtiene la posici�n del error en bit
    msg_corrected = mod(msg_channel + error_position,2);                 % Corrige los error
    
    % ----- Decodificaci�n -----
    msg_decoded=msg_corrected(:,k:end);
end