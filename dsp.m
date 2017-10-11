function varargout = dsp(varargin)
% DSP MATLAB code for dsp.fig
%      DSP, by itself, creates a new DSP or raises the existing
%      singleton*.
%
%      H = DSP returns the handle to a new DSP or the handle to
%      the existing singleton*.
%
%      DSP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DSP.M with the given input arguments.
%
%      DSP('Property','Value',...) creates a new DSP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dsp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dsp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dsp

% Last Modified by GUIDE v2.5 10-Oct-2017 22:53:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dsp_OpeningFcn, ...
                   'gui_OutputFcn',  @dsp_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before dsp is made visible.
function dsp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dsp (see VARARGIN)

% Choose default command line output for dsp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dsp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dsp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in record_radiobutton.
function record_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to record_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of record_radiobutton


% --- Executes on button press in file_radiobutton.
function file_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to file_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of file_radiobutton



function filepath_edit_Callback(hObject, eventdata, handles)
% hObject    handle to filepath_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filepath_edit as text
%        str2double(get(hObject,'String')) returns contents of filepath_edit as a double


% --- Executes during object creation, after setting all properties.
function filepath_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filepath_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sample_frequency_popupmenu.
function sample_frequency_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to sample_frequency_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sample_frequency_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sample_frequency_popupmenu


% --- Executes during object creation, after setting all properties.
function sample_frequency_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sample_frequency_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in file_choose_pushbutton.
function file_choose_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to file_choose_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.wav;*.mp3;*.flac','��Ƶ�ļ�(*.wav,*.mp3,*.flac)'},'ѡ���ļ�');%����ѡ���ļ�����
%�ж��ļ�Ϊ��
if isequal(filename,0)||isequal(pathname,0)
    return
else
    handles.Filepath=[pathname,filename];
    set(handles.filepath_edit,'string',handles.Filepath);%��ʾ�ļ���
    [handles.Sample,handles.Fs]=audioread(handles.Filepath);%��ȡ��Ƶ�ļ�
    %��������ƵΪ˫��������ʹ��һ��ͨ��
    samplesize=size(handles.Sample);
    if samplesize(2)>1
        handles.Sample=handles.Sample(:,1);
    end
    handles.inputtype=2;%���뷽ʽΪ��Ϊ2
    handles.player=audioplayer(handles.Sample,handles.Fs);
    guidata(hObject,handles);%����handles
    set(handles.play_pushbutton,'enable','on');
    set(handles.play_stop_pushbutton,'enable','on');
    feval(@wave_select_listbox_Callback,handles.wave_select_listbox,eventdata,handles);
    %����wave_select_listbox_Callback,handles����
end


% --- Executes on button press in record_start_pushbutton.
function record_start_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to record_start_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sample_frequency_list=get(handles.sample_frequency_popupmenu,'string');%��ȡ�б�
sample_frequency_value=get(handles.sample_frequency_popupmenu,'value');%��ȡ�������
sample_frequency=str2double(sample_frequency_list{sample_frequency_value});%��ȡѡ��������
%list����Ϊcell����ת��
handles.Fs=sample_frequency;
handles.recObj=audiorecorder(sample_frequency,16,1);%����һ��¼����
record(handles.recObj);%��ʼ¼��
handles.inputtype=1;%������Ƶ��ʽ��Ϊ1
guidata(hObject,handles);
set(handles.record_start_pushbutton,'enable','off');
set(handles.record_stop_pushbutton,'enable','on');

% --- Executes on button press in play_pushbutton.
function play_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to play_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
play(handles.player);%��ʼ����
playblocking(handles.player);%���Ž����Զ�ֹͣ


% --- Executes on button press in record_stop_pushbutton.
function record_stop_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to record_stop_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stop(handles.recObj);%ֹͣ¼��
set(handles.play_pushbutton,'enable','on');
set(handles.play_stop_pushbutton,'enable','on');
set(handles.record_start_pushbutton,'enable','on');
set(handles.record_stop_pushbutton,'enable','off');
handles.Sample=getaudiodata(handles.recObj);%��ȡ¼��
handles.player=audioplayer(handles.Sample,handles.Fs);%����һ��������
guidata(hObject,handles);
feval(@wave_select_listbox_Callback,handles.wave_select_listbox,eventdata,handles);
%����wave_select_listbox_Callback,handles����
% --- Executes during object deletion, before destroying properties.


% --- Executes on button press in play_stop_pushbutton.
function play_stop_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to play_stop_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stop(handles.player);%ֹͣ����


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(hObject,'tag')
    case 'record_radiobutton'
        set(handles.sample_frequency_popupmenu,'enable','on');
        set(handles.record_start_pushbutton,'enable','on');
        set(handles.record_stop_pushbutton,'enable','off');
        set(handles.filepath_edit,'enable','off');
        set(handles.file_choose_pushbutton,'enable','off');
        set(handles.play_pushbutton,'enable','off');
        set(handles.play_stop_pushbutton,'enable','off');
    case 'file_radiobutton'
        set(handles.sample_frequency_popupmenu,'enable','off');
        set(handles.record_start_pushbutton,'enable','off');
        set(handles.record_stop_pushbutton,'enable','off');
        set(handles.filepath_edit,'enable','on');
        set(handles.file_choose_pushbutton,'enable','on');
        set(handles.play_pushbutton,'enable','off');
        set(handles.play_stop_pushbutton,'enable','off');
end


% --- Executes on selection change in wave_select_listbox.
function wave_select_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to wave_select_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns wave_select_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from wave_select_listbox
wavetype=get(hObject,'value');
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

% --- Executes during object creation, after setting all properties.
function wave_select_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wave_select_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
