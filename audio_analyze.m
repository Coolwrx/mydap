function audio_analyze(wavetype,handles)
sample_length=length(handles.Sample);
t=(0:sample_length-1)/handles.Fs;
nfft=pow2(nextpow2(sample_length));%fft���ȣ������㷨ȡ2���ݴη�����ٶ�
switch wavetype
    case 1
        %ʱ����
        plot(handles.axes1,t,handles.Sample,'g');
        xlabel(handles.axes1,'ʱ��(s)');
    case 2
        %��Ƶ����
        fft_sample=fft(handles.Sample,nfft);
        y=abs(fft_sample/nfft);%����fft��ֵ
        %����fft�õ�����ԳƵ������ַ�������ֵΪʱ���һ�루����0��ֱ��������
        y0=fftshift(y);%ѭ����λ��ȡ�м�Ϊ0
        %The fftshift function rearranges the output from fft with a circular shift to produce a 0-centered periodogram.
        f0=(-nfft/2:nfft/2-1)*(handles.Fs/nfft);
        plot(handles.axes1,f0,y0,'r');
        xlabel(handles.axes1,'Ƶ��(Hz)');
    case 3
        %��Ƶ����(DB)
        fft_sample=fft(handles.Sample,nfft);
        y=abs(fft_sample/nfft);
        y1=20*log10(y);
        y2=y1(1:nfft/2+1);%ȡƵ��һ��
        y2(2:end-1)=2*y2(2:end-1);%ֱ���������ֲ���,������2
        f=handles.Fs*(0:(nfft/2))/nfft;
        plot(handles.axes1,f,y2,'y');
        xlabel(handles.axes1,'Ƶ��(Hz)');
    case 4
        %��Ƶ����
        fft_sample=fft(handles.Sample,nfft);
        f0=(-nfft/2:nfft/2-1)*(handles.Fs/nfft);
        ph_y0=fftshift(fft_sample);
        phase=unwrap(angle(ph_y0));%�������䷶ΧΪ[-pi,pi]
        plot(handles.axes1,f0,phase,'b');
        xlabel(handles.axes1,'Ƶ��(Hz)');
    case 5
        %�ٲ�Ƶ��ͼ
        axes(handles.axes1);
        hammingwin=2^floor(log2(sample_length))/8;
        spectrogram(handles.Sample,hammingwin,hammingwin/2,sample_length,handles.Fs);
        set(colorbar,'Color','[0.5,0.5,0.5]');
    case 6
        %��ѹ����
        audio_db=20*log10(abs(handles.Sample));%����ѹ
        plot(handles.axes1,t,audio_db,'c');
        xlabel(handles.axes1,'ʱ��(s)');
        ylabel(handles.axes1,'��ѹ(DB)');
end
set(handles.axes1,'Color','k','XColor','[0.5,0.5,0.5]','YColor','[0.5,0.5,0.5]','ZColor','[0.5,0.5,0.5]');
grid on;
    