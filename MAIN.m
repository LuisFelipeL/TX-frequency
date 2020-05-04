clear; clc; close all;
disp("+++++++++++++++++++++++++++++++++++")
disp("+               Menú              +")
disp("+++++++++++++++++++++++++++++++++++")
disp("+                                 +")
disp("+     1. Con Modulación 2-PAM     +")
disp("+     2. Con Modulación 4-QAM     +")
disp("+                                 +")
disp("+++++++++++++++++++++++++++++++++++")

while 1
    Cod = input("Opcion: ");
    if Cod == 1
        PAM_video()
        break
    elseif Cod == 2
        QAM_video()
        break
    else
        disp("Opción Incorrecta!!");
    end
end