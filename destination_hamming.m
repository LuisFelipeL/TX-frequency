function msg_decoded = destination_hamming(msg_channel, n, k)
    % ------ Inicialización de parametros Hamming ------
    parity_matrix = [ 1 1 0;0 1 1;1 1 1;1 0 1];                  % Matriz de paridad
    parity_verification_matrix = [ eye(n-k) parity_matrix' ];    % Check matriz de paridad
    syndrome = mod(msg_channel * parity_verification_matrix',2); % Sindrome del mensaje recibido del canal
    syndrome_index = bi2de(syndrome);                            % Indice de los errores según el sindrome del mensaje
    
    % ------ Reconstrucción Hamming ------
    syndrome_verification_1 = [0 0 0; 
                               1 0 0; 
                               0 1 0; 
                               1 1 0; 
                               0 0 1; 
                               1 0 1; 
                               0 1 1;
                               1 1 1]; % Matriz de verificación del sindrome (No se usa, solo referencia)

    % Matriz con todos los errores posibles (indexados según la matriz de verificación)
    syndrome_verification_2 = [0 0 0 0 0 0 0; 
                               1 0 0 0 0 0 0; 
                               0 1 0 0 0 0 0; 
                               0 0 0 1 0 0 0; 
                               0 0 1 0 0 0 0; 
                               0 0 0 0 0 0 1; 
                               0 0 0 0 1 0 0; 
                               0 0 0 0 0 1 0];
    
    error_position = syndrome_verification_2(syndrome_index(1:end)+1,:); % Obtiene la posición del error en bit
    msg_corrected = mod(msg_channel + error_position,2);                 % Corrige los error
    
    % ----- Decodificación -----
    msg_decoded=msg_corrected(:,k:end);
end