function [sps, Fmax, Centros] = GenPort(rolloff,numImg)    
    Bw = (1+rolloff);
    sps = ceil(2 * numImg * Bw);
    Fmax = numImg * Bw;
    x = ones([1 numImg],"double")*(Bw/2);
    y = linspace(0,Fmax-Bw,numImg);
    Centros = x + y;
end