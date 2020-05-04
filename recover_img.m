function I = recover_img(msg_decoded,rows,columns)
    rR_destination = msg_decoded';
    tR_destination = reshape(rR_destination,8,length(rR_destination)/2);
    bin_destination = tR_destination';
    Y = bi2de(bin_destination);
    Y1 = reshape(Y(1:rows*columns),rows,columns);
    Y2 = reshape(Y(rows*columns+1:2*rows*columns),rows,columns);
    Y3 = reshape(Y(2*rows*columns+1:end),rows,columns);
    I(:,:,1) = Y1;
    I(:,:,2) = Y2;
    I(:,:,3) = Y3;
    I = uint8(I);
end 