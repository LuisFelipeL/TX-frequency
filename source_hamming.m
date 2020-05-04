function msg_encode = source_hamming(msg, G)
    % ----- Codificación -----
    msg_encode = mod(msg*G,2); % Mensaje codificado
end