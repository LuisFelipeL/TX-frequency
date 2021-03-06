function img = QAM_rx(signal_Rx,rrcFilter,sps,span,columns_msg,rows_msg,n,k,rows,columns)      
    %-----------------------------------DEMODULACIÓN QAM--------------------------------------
    signal_RX = demodQAM(signal_Rx,rrcFilter,sps, span);
    %---------------------------------------------------------------------------------------------
    
    %-------------------------------RECONSTRUCCIÓN DEL MENSAJE------------------------------------
    msg_demod = reshape(signal_RX',[],1);
    msg_RX = reshape(msg_demod,columns_msg,rows_msg);
    msg_RX = msg_RX';
    %---------------------------------------------------------------------------------------------

    %-----------------------------------DECODIFICACIÓN HAMMING------------------------------------
    msg_decoded = destination_hamming(msg_RX, n, k);
    %---------------------------------------------------------------------------------------------

    %-----------------------------------CONSTRUCCIÓN DE LA IMAGEN 1---------------------------------
    img = recover_img(msg_decoded, rows ,columns);
    %---------------------------------------------------------------------------------------------
end