function msg_TX = load_img(image)
    image = double(image);
    binary_image = de2bi(image);
    tR = binary_image';
    rR = reshape(tR,4,2*length(tR));
    msg_TX = rR';
end     