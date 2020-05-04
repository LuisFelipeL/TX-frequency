function PAM_video()
    vidObj = VideoReader('Video.mp4');
    vidHeight = vidObj.Height;
    vidWidth = vidObj.Width;
    FrameRate = vidObj.FrameRate;
    NumFrames = vidObj.NumFrames;
    numImg = input("Seleccione el numero de imagenes para cada rafaga:");
    
    s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);
    
    for i = 1:NumFrames
        s(i).cdata = readFrame(vidObj);
    end
    
    figure
    currAxes = axes;
    for i= 1:NumFrames
        image(s(i).cdata,'Parent',currAxes)
        currAxes.Visible = 'off';
        pause(1/FrameRate);
    end
    
    AuxS = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);
    for i = 1:NumFrames
        AuxS(i).cdata = zeros(vidHeight,vidWidth,3);
    end
    
    
    figure    
    currAxes = axes;
    for i=1:floor(NumFrames/numImg) % Numero total de rafagas
        
        if i==1 % Primera Rafaga
            AuxS(1:numImg) = PAM_burst(s(1:numImg),numImg,vidHeight,vidWidth);
            pasado = numImg;
            
            for j = 1:numImg
                image(AuxS(j).cdata,'Parent',currAxes)
                currAxes.Visible = 'off';
                pause(1/FrameRate);
            end
                    
        else % siguientes Rafagas
            inicio = pasado + 1;
            final = pasado + numImg;
%              if final > NumFrames
%                  final = NumFrames;
%                  numImg = final - inicio;
%              end
            AuxS(inicio:final) = PAM_burst(s(inicio:final),numImg,vidHeight,vidWidth);
            pasado = final;
        
            for j = inicio:final
                image(AuxS(j).cdata,'Parent',currAxes)
                currAxes.Visible = 'off';
                pause(1/FrameRate);
            end            

        end
    end
    
%     figure
%     currAxes = axes;
%     for i= 1:NumFrames
%         image(AuxS(i).cdata,'Parent',currAxes)
%         currAxes.Visible = 'off';
%         pause(1/FrameRate);
%     end
end
