function AWGN_Sig = add_AWGN(TX_Sig, Es, k, n, M, EbNo)
    L = length(TX_Sig); %Sample length for the random signal
    mu=0;
    sigma = sqrt( (k * Es) / ( 2 * n * log2(M) * EbNo ));
    noise = sigma * randn(L,1) + mu;
    
    AWGN_Sig = TX_Sig + noise;
end