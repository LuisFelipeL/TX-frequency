function signal_TX = mod_pam(msg_vector, rrcFilter, sps)
    msg_mod = 2 * msg_vector - 1;
    signal_TX = upfirdn(msg_mod, rrcFilter, sps);
end       