function varargout = dsp(varargin)
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

% --- Executes just before dsp is made visible.
function dsp_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for dsp
handles.output = hObject;

% ����Ĭ����ɫ
set(gcf,'defaultAxesColor','k',...
    'defaultAxesXColor','[0.5,0.5,0.5]', ...
    'defaultAxesYColor','[0.5,0.5,0.5]', ...
    'defaultAxesZColor','[0.5,0.5,0.5]', ...
    'defaultAxesGridColor','w');

% ��ʼ��
handles.Sample=[];
handles.index=0;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = dsp_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


function record_radiobutton_Callback(hObject, eventdata, handles)

function file_radiobutton_Callback(hObject, eventdata, handles)

% --- ��ʾ�ļ�·��
function filepath_edit_Callback(hObject, eventdata, handles)

function filepath_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function fs_popupmenu_Callback(hObject, eventdata, handles)

function fs_popupmenu_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- �ļ�������Ƶ
function file_choose_pushbutton_Callback(hObject, eventdata, handles)
[filename,pathname]=uigetfile({'*.wav;*.mp3;*.flac','��Ƶ�ļ�(*.wav,*.mp3,*.flac)'},'ѡ���ļ�');%����ѡ���ļ�����
% �ж��ļ�Ϊ��
if isempty(filename)||isempty(pathname)
    return
else
    handles.Filepath=[pathname,filename];
    set(handles.filepath_edit,'string',handles.Filepath);% ��ʾ�ļ���
    [handles.Sample,handles.Fs]=audioread(handles.Filepath);% ��ȡ��Ƶ�ļ�
    % ��������ƵΪ˫��������ʹ��һ��ͨ��
    samplesize=size(handles.Sample);
    if samplesize(2)>1
        handles.Sample=handles.Sample(:,1);
    end
    handles.player=audioplayer(handles.Sample,handles.Fs);
    setplayer(eventdata,handles);
end
 guidata(hObject,handles);

% --- ¼����ť
function record_start_pushbutton_Callback(hObject, eventdata, handles)
fs_list=get(handles.fs_popupmenu,'string');% ��ȡ�б�
fs_value=get(handles.fs_popupmenu,'value');% ��ȡ�������
fs=str2double(fs_list{fs_value});% ��ȡѡ��������
% list����Ϊcell����ת��
handles.Fs=fs;

handles.recObj=audiorecorder(fs,16,1);% ����һ��¼����
record(handles.recObj);% ��ʼ¼��

set(hObject,'enable','off');
set(handles.record_stop_pushbutton,'enable','on');

guidata(hObject,handles);

% --- ֹͣ¼����ť
function record_stop_pushbutton_Callback(hObject, eventdata, handles)
stop(handles.recObj);% ֹͣ¼��
handles.Sample=getaudiodata(handles.recObj);% ��ȡ¼��
handles.index=handles.index+1;
handles.player=audioplayer(handles.Sample,handles.Fs);
setplayer(eventdata,handles);

set(handles.play_pushbutton,'enable','on');
set(handles.play_stop_pushbutton,'enable','on');
set(handles.record_start_pushbutton,'enable','on');
set(hObject,'enable','off');

guidata(hObject,handles);

% --- ����������
function setplayer(eventdata,handles)
% ����player�ص�����
set(handles.player,'StartFcn',{@playstart_Callback,handles}, ...
        'StopFcn',{@playstop_Callback,handles});
% plot wave
feval(@wave_select_listbox_Callback,handles.wave_select_listbox,eventdata,handles);

% --- ���Ű�ť
function play_pushbutton_Callback(hObject, eventdata, handles)
play(handles.player);% ��ʼ����

% --- ֹͣ���Ű�ť
function play_stop_pushbutton_Callback(hObject, eventdata, handles)
stop(handles.player);% ֹͣ����
set(handles.play_pushbutton,'enable','on');

% --- ���뷽ʽ��ť��
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
switch get(hObject,'tag')
    case 'record_radiobutton'
        set(handles.fs_popupmenu,'enable','on');
        set(handles.record_start_pushbutton,'enable','on');
        set(handles.record_stop_pushbutton,'enable','off');
        set(handles.filepath_edit,'enable','off');
        set(handles.file_choose_pushbutton,'enable','off');
        set(handles.play_pushbutton,'enable','off');
        set(handles.play_stop_pushbutton,'enable','off');
    case 'file_radiobutton'
        set(handles.fs_popupmenu,'enable','off');
        set(handles.record_start_pushbutton,'enable','off');
        set(handles.record_stop_pushbutton,'enable','off');
        set(handles.filepath_edit,'enable','on');
        set(handles.file_choose_pushbutton,'enable','on');
        set(handles.play_pushbutton,'enable','off');
        set(handles.play_stop_pushbutton,'enable','off');
end

% --- ����ѡ����
function wave_select_listbox_Callback(hObject, eventdata, handles)
wavetype=get(hObject,'value');
if ~isempty(handles.Sample)
    audio_analyze(wavetype,handles);
end

% --- Executes during object creation, after setting all properties.
function wave_select_listbox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- ���ſ�ʼ
function playstart_Callback(hObject,eventdata,handles)
set(handles.play_pushbutton,'enable','off');
set(handles.play_stop_pushbutton,'enable','on');

% --- ���Ž���
function playstop_Callback(hObject,eventdata,handles)
set(handles.play_pushbutton,'enable','on');
set(handles.play_stop_pushbutton,'enable','off');