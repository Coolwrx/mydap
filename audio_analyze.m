function audio_analyze(handles)
    plot(handles.axes1,handles.Sample,'g');%����ʱ����
    plot(handles.axes2,fft(handles.Sample),'r');
    set(handles.axes1,'color','k');
    set(handles.axes2,'color','k');