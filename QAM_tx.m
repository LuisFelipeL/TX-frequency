function [signal_TX,t,rows_msg,columns_msg,msg_vector] = QAM_tx(name_img,G,sps,rrcFilter)
    msg_TX = load_img(name_img);

    %------------------------------------CODIFICACIÓN HAMMING-------------------------------------
    msg_encode = source_hamming(msg_TX, G);
    %---------------------------------------------------------------------------------------------

    %-------------------------------------VECTOR MENSAJE------------------------------------------
    [rows_msg, columns_msg] = size(msg_encode);
    msg_vector = reshape(msg_encode',[],1);
    %---------------------------------------------------------------------------------------------

    %-------------------------------------MODULACIÓN QAM------------------------------------------
    signal_TX = modQAM(msg_vector, rrcFilter, sps);
    %---------------------------------------------------------------------------------------------

    %----------------------------------Time specifications-------------------------------
    Fs = sps;            % samples per second
    t = 0:1/Fs:length(signal_TX)/Fs-1/Fs; 
    t=t'; %t es el tiempo de simbolo
    % -----------------------------------------------------------------------------------
end