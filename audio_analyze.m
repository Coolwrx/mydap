function audio_analyze(sample,fs,ax,handles)
% --- plot wave
wavetype=get(handles.wave_select_listbox,'value');
if ~isempty(sample)
    sample_length=length(sample);
    t=(0:sample_length-1)/fs;
    nfft=pow2(nextpow2(sample_length));% fft��������2fftȡ2���ݴη�����ٶ�
    switch wavetype
        case 1
            % --- ʱ����
            plot(ax,t,sample);
            xlabel(ax,'ʱ��(s)');
        case 2
            % --- Ƶ����Ӧ����
            fft_sample=fft(sample,nfft);
            y=abs(fft_sample)/nfft;
            % ����fft�õ�����ԳƵ������ַ�������ֵΪʱ���һ�루����0��ֱ��������
            y0=fftshift(y);% ѭ����λ��ȡ�м�Ϊ0
            f0=(-nfft/2:nfft/2-1)*(fs/nfft);
            plot(ax,f0,y0);
            xlabel(ax,'Ƶ��(Hz)');
            ylabel(ax,'��ֵ');
        case 4
            % --- ������
            fft_sample=fft(sample,nfft);
            y=abs(fft_sample).^2/nfft;% Parseval����������
            y1=10*log10(y);
            y2=y1(1:nfft/2+1);% ȡƵ��һ��
            y2(2:end-1)=2*y2(2:end-1);% ֱ���������ֲ���,������2
            f=fs*(0:(nfft/2))/nfft;
            plot(ax,f,y2);
            xlabel(ax,'Ƶ��(Hz)');
            ylabel(ax,'���ܶ�(DB/Hz)');
        case 3
            % --- ��Ƶ����
            fft_sample=fft(sample,nfft);
            f0=(-nfft/2:nfft/2-1)*(fs/nfft);
            ph_y0=fftshift(fft_sample);
            phase=unwrap(angle(ph_y0));% ����������䷶Χ��pi����
            plot(ax,f0,phase);
            xlabel(ax,'Ƶ��(Hz)');
        case 5
            % --- �ٲ�Ƶ��ͼ
            axes(ax);
            spectrogram(sample,1024,512,nfft,fs);
            %hammingwin=2^floor(log2(sample_length))/8;
            %spectrogram(sample,hammingwin,hammingwin/2,nfft,fs);
            colorbar(ax);
            %colormap(hot);
            %colorbar(handles.axes2,'off');
        case 6
            % --- ��ѹ����
            audio_db=20*log10(abs(sample));% ����ѹ
            plot(ax,t,audio_db);
            xlabel(ax,'ʱ��(s)');
            ylabel(ax,'��ѹ(DB)');
    end
end
    