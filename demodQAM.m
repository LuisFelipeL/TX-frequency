function RX_Sig = demodQAM(AWGN_Sig,rrcFilter,sps,span)
    Rx = upfirdn(AWGN_Sig, rrcFilter, 1, sps);
    rxFilt(:,1) = Rx(span+1:end-span,1);
    rxFilt(:,2) = Rx(span+1:end-span,2);
    rxFilt = reshape(rxFilt',[],1);
    zer = rxFilt < 0;
    une = rxFilt >= 0;
    RX_Sig(zer) = 0;
    RX_Sig(une) = 1;
end