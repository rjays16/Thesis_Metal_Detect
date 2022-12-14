function varargout = main(varargin)


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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

function main_OpeningFcn(hObject, eventdata, handles, varargin)


set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
ah = axes('unit', 'normalized', 'position', [0 0 1 1]);
bg = imread('background.png'); imagesc(bg);

set(ah,'handlevisibility','off','visible','off')

uistack(ah, 'bottom');

handles.output = hObject;

guidata(hObject, handles);


function varargout = main_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;

function pushbutton1_Callback(hObject, eventdata, handles) 
global picture;
set(handles.pushbutton1,'enable','off');
set(handles.pushbutton2,'enable','on');

x = 0;
%% start program 
wb = waitbar(x,'Start Opening Camera');
waitbar(x + 0.2, wb, 'Start Opening Camera...'); 

%% callling function webcam
camera = webcam();
waitbar(x + 0.4, wb, 'Classify Images...');

%% calling deep learning model tool alexnet
alex = alexnet;
layers = alex.Layers;

%% size of layers on alexnet 
layers(23) = fullyConnectedLayer(3);
layers(25) = classificationLayer;


%% images to compare 
allImages = imageDatastore('myImages', 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
[trainingImages, testImages] = splitEachLabel(allImages, 0.8, 'randomize');

waitbar(x + 0.6, wb, 'Read Sizes of Images...');
opts = trainingOptions('sgdm', 'InitialLearnRate', 0.001, 'MaxEpochs', 20, 'MiniBatchSize', 64);

myNet = trainNetwork(trainingImages, layers, opts);

waitbar(x + 0.8, wb, 'Re training Images for classify images');
waitbar(x + 1, wb, 'Done');
delete(wb);

%% start looping webcam 
while true
        %% automatically picture per mili-second and resize into 227    
        picture = camera.snapshot;
        picture = imresize(picture,[227,227]);
        
        %% comparing image neural network and camera snaphot
        testImages = picture;
        predictedLabels = classify(myNet, testImages);
          image(picture);
          drawnow;
          
           %% check if picture is Metal
            if predictedLabels == 'Buckle' || predictedLabels == 'NotBuckle'
              set(handles.edit1, 'ForegroundColor', 'g', 'string', char(hex2dec('2713')));
              %% check if Metal is Buckle
               if predictedLabels == 'Buckle'
                   set(handles.edit2, 'ForegroundColor', 'g', 'string', char(hex2dec('2713')));
                   fig = uifigure;
                   pause('off')
                  message = {'Warning','The Steel Truss of the Bridge buckled'};
                  confirm  = uiconfirm(fig,message,'Warning', 'Icon', 'warning','CloseFcn',@(h,e) close(fig));
                  if(confirm == 'OK')
                      pause('on')
                  end
               else
              set(handles.edit2, 'ForegroundColor', 'r', 'string', 'X');  
                fig = uifigure;
                   pause('off')
                  message = {'Success','The Steel Truss not buckled'};
                  confirm  = uiconfirm(fig,message,'Success', 'Icon', 'success','CloseFcn',@(h,e) close(fig));
                  if(confirm == 'OK')
                      pause('on')
                  end
               end
            else
                %% if this is not a Metal
              set(handles.edit1, 'ForegroundColor', 'r', 'string', 'X');  
              set(handles.edit2, 'ForegroundColor', 'r', 'string', 'X');
            end
end

function pushbutton4_Callback(hObject, eventdata, handles)

close all; clear all; clc; delete(gcp('nocreate'));


function edit1_Callback(hObject, eventdata, handles)


function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    
end

function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)



function edit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)

function edit4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)

function edit5_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');

end

function uipanel2_CreateFcn(hObject, eventdata, handles)


function figure1_SizeChangedFcn(hObject, eventdata, handles)

function pushbutton5_Callback(hObject, eventdata, handles)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on pushbutton4 and none of its controls.
function pushbutton4_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit1, 'ForegroundColor', 'red', 'string', '');
set(handles.edit2, 'ForegroundColor', 'red', 'string', '');
set(handles.pushbutton1,'enable','on');
set(handles.pushbutton2,'enable','off');
clear all; clc;

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all; clear all; clc; delete(gcp('nocreate'));



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
