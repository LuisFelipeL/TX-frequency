function z = PAM_burst(auxS,numImg,vidHeight,vidWidth)
    
    %---------------------------------VALORES CODIFICACIÃ“N HAMMING--------------------------------
    n = 7;                                      % Numero de bits de la palabra codigo que se genera
    k = 4;                                      % Numero de bits del mensaje
    parity_matrix = [1 1 0;
                     0 1 1;
                     1 1 1;
                     1 0 1];                    % Matriz de paridad
    G = [ parity_matrix eye(k)];                % Matriz generadora    
    %---------------------------------------------------------------------------------------------

    %---------------------------------VALORES CODIFICACIÓN CANAL - PAM ----------------------------------
    M = 2;                           % Tamaño de la contelación (Numero de modulación a usar)
    Es = (-1)^2*(0.5) + (1)^2*(0.5); % Energia promedio de simbolo (simbolos -1 y 1)
    EbNo = 3;                        % Relación Energia de bit a ruido    
    %---------------------------------------------------------------------------------------------
    %---------------------------------VALORES CODIFICACIÓN CANAL - QAM ----------------------------------
%     M = 4;                           % Tamaño de la contelación (Numero de modulación a usar)
%     Es = 2*(1)^2; % Energia promedio de simbolo (simbolos -1 y 1)
%     EbNo = 3;                        % Relación Energia de bit a ruido
    %------------------------------------------------------------------------------------------------
    
    %---------------------------------VALORES FILTRO COSENO ALZADO--------------------------------
    rolloff = 0.5; % Corte del filtro (Rolloff)
    span = 4;       % Espaciado del filtro (Span)
    [sps, ~, Portadoras] = GenPort(rolloff,numImg);

    rrcFilter = rcosdesign(rolloff, span, sps);
    %---------------------------------------------------------------------------------------------
    
   [Tx,t,rows_msg,columns_msg] = arrayfun(@(x) PAM_tx(x.cdata,G,sps,rrcFilter),auxS,'UniformOutput',false);
    t=t{1};
    rows_msg=rows_msg{1};
    columns_msg=columns_msg{1};

    for i=1:numImg
        Tx{i} = Tx{i}.*cos(2*pi*t*Portadoras(i));
    end

    Signal_Tx = zeros(length(Tx{1}),1);
    for i=1:numImg
        Signal_Tx=Signal_Tx+Tx{i};
    end

    signal_AWGN = add_AWGN(Signal_Tx, Es, k, n, M, EbNo);

    z = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);
    for i=1:numImg
        Signal_Rx = signal_AWGN.*cos(2*pi*t*Portadoras(i));
        z(i).cdata = PAM_rx(Signal_Rx,rrcFilter,sps,span,columns_msg,rows_msg,n,k,vidHeight,vidWidth);
    end
end