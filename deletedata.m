function c=deletedata(data)
% --- ɾ������
button = questdlg('����ɾ����һ��˵����',...
    'ɾ������',...
    '����','ѡ��','ȡ��','ȡ��');
switch button
    case '����'
        delete('speech_database.mat');
        c=cell(0,0);
        msgbox('�ɹ�ɾ������','ɾ������','help');
    case 'ѡ��'
        prompt={'��������Ҫɾ����˵����'};
        name='';
        numlines=1;
        defaultanswer={''};
        answer=inputdlg(prompt,name,numlines,defaultanswer);
        if (~isempty(answer))
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
                save('speech_database.mat','data','speaker_number','-append');
                c=data2cell(data);
                message=strcat('�ɹ�ɾ��˵���ˣ�',answer{1,1});
                msgbox(message,'','help');
            end
        end
    case 'ȡ��'
end
end

