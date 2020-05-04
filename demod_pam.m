function RX_Sig = demod_pam(AWGN_Sig,rrcFilter,sps,span)
    Rx = upfirdn(AWGN_Sig, rrcFilter, 1, sps);
    rxFilt = Rx(span+1:end-span);
    zer = rxFilt < 0;
    une = rxFilt >= 0;
    RX_Sig(zer) = 0;
    RX_Sig(une) = 1;
end