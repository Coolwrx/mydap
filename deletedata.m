function c=deletedata(data)
% --- ɾ������
button = questdlg('����ɾ����һ��˵����',...
    'ɾ������',...
    '����','ѡ��','ȡ��','ȡ��');
switch button
    case '����'
        delete('speech_database.dat');
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
                save('speech_database.dat','data','speaker_number','-append');
                len=length(data);
                for i=1:len
                    c(i,1)={i};
                    c(i,2)={data(i).name};
                end
                message=strcat('�ɹ�ɾ��˵���ˣ�',answer{1,1});
                msgbox(message,'','help');
            end
        end
    case 'ȡ��'
end
end

