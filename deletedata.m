function deletedata(data)
% --- ɾ������
button = questdlg('����ɾ����һ��˵����',...
    'ɾ������',...
    '����','ѡ��','����');
if strcmp(button,'����')
    delete('speech_database.dat');
    msgbox('�ɹ�ɾ������','ɾ������','help');
else
    prompt={'��������Ҫɾ����˵����'};
    name='ѡ��ɾ�����';
    numlines=1;
    defaultanswer={''};
    answer=inputdlg(prompt,name,numlines,defaultanswer);
    nspeaker=length(data);
    names=cell(1,nspeaker);
    for i=1:nspeaker
        names{1,i}=data(i).name;
    end
    [a,b]=ismember(answer{1,1},names);
    if a==0
        warndlg('˵���˲�����','����');
    else
        data(b)=[];
        speaker_number=length(data);
        save('speech_database.dat','data','speaker_number','-append');
        message=strcat('�ɹ�ɾ��˵���ˣ�',answer{1,1});
        msgbox(message,'ѡ��ɾ�����','help');
    end
end
end

