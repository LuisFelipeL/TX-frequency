function signal_TX = modQAM(msg_vector, rrcFilter, sps)
    msg_mod = 2 * msg_vector - 1;
    TX_Sig = reshape(msg_mod,2,[])';
    signal_TX = upfirdn(TX_Sig, rrcFilter, sps);
end