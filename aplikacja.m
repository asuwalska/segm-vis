function varargout = aplikacja(varargin)
% APLIKACJA MATLAB code for aplikacja.fig
%      APLIKACJA, by itself, creates a new APLIKACJA or raises the existing
%      singleton*.
%
%      H = APLIKACJA returns the handle to a new APLIKACJA or the handle to
%      the existing singleton*.
%
%      APLIKACJA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APLIKACJA.M with the given input arguments.
%
%      APLIKACJA('Property','Value',...) creates a new APLIKACJA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before aplikacja_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to aplikacja_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help aplikacja

% Last Modified by GUIDE v2.5 23-Dec-2018 21:45:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @aplikacja_OpeningFcn, ...
                   'gui_OutputFcn',  @aplikacja_OutputFcn, ...
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


% --- Executes just before aplikacja is made visible.
function aplikacja_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to aplikacja (see VARARGIN)

% Choose default command line output for aplikacja
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes aplikacja wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = aplikacja_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function read_image_seg_Callback(hObject, eventdata, handles)
% hObject    handle to read_image_seg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global seg

[file_seg,path] = uigetfile();

 currentValue = char(get(handles.text7,'String'));
%  newValue = sprintf('%s\n%s', currentValue, file_seg);
 newValue=[currentValue; {file_seg}];
 set(handles.text7, 'String', newValue);

file_seg = strcat(path,file_seg);
seg = load(file_seg); %% Structure
seg = struct2cell(seg)
seg = seg{1,1};

% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[file,path] = uiputfile({'*.fig'}); % wyœwietla okno dialogowe do zapisu zdjêcia
nazwa = fullfile (path,file);
new = figure('Visible','on');
copyobj(handles.axes2,new);
saveas(gca, nazwa,'fig');

% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function read_file_images_Callback(hObject, eventdata, handles)
% hObject    handle to read_file_images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global file_img name_img

[name_img,path] = uigetfile();

 currentValue = char(get(handles.text7,'String'));
%  newValue = sprintf('%s\n%s', currentValue, name_img);
 newValue=[currentValue; {name_img}];
 set(handles.text7, 'String', newValue);

file_img = strcat(path,name_img);
file_img = load(file_img); %% Structure
file_img = struct2cell(file_img)
file_img = file_img{1,1};



% --- Executes on button press in montage_image.
function montage_image_Callback(hObject, eventdata, handles)
% hObject    handle to montage_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of montage_image

global file_img

cla(handles.axes2,'reset');
set(gca,'Color',[0.83 0.82 0.78])
buttons_list = [handles.surface_3D_img_seg, handles.surface_3D_img, handles.surface_3D_seg, handles.show_image_all, handles.show_seg_all];
set(buttons_list,'Value',0);
axes(handles.axes2);


if size(file_img,1) ~= 0
    MontageImage(file_img);
else
    set(handles.axes2,'visible', 'off');
    msgbox('Read images!');
end


% --- Executes on button press in surface_3D_img_seg.
function surface_3D_img_seg_Callback(hObject, eventdata, handles)
% hObject    handle to surface_3D_img_seg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of surface_3D_img_seg

global file_img seg

cla(handles.axes2,'reset');
set(gca,'Color',[0.83 0.82 0.78])
buttons_list = [handles.montage_image, handles.surface_3D_img, handles.surface_3D_seg, handles.show_image_all, handles.show_seg_all];
set(buttons_list,'Value',0);
axes(handles.axes2);


if (size(file_img,1) ~= 0 && size(seg,1) ~= 0)
    Surface3D(seg, file_img, 'red', 'blue');
    set(handles.axes2,'visible', 'off');
else
    set(handles.axes2,'visible', 'off');
    msgbox('Read images and segmentation!');
end

% --- Executes on button press in surface_3D_img.
function surface_3D_img_Callback(hObject, eventdata, handles)
% hObject    handle to surface_3D_img (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of surface_3D_img
global file_img

cla(handles.axes2,'reset');
set(gca,'Color',[0.83 0.82 0.78])
buttons_list = [handles.surface_3D_img_seg, handles.montage_image, handles.surface_3D_seg, handles.show_image_all, handles.show_seg_all];
set(buttons_list,'Value',0);
axes(handles.axes2);


if size(file_img,1) ~= 0
    Surface3D(file_img, [], 'blue');
    set(handles.axes2,'visible', 'off');
else
    set(handles.axes2,'visible', 'off');
    msgbox('Read images!');
end


% --- Executes on button press in surface_3D_seg.
function surface_3D_seg_Callback(hObject, eventdata, handles)
% hObject    handle to surface_3D_seg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of surface_3D_seg

global seg

cla(handles.axes2,'reset');
set(gca,'Color',[0.83 0.82 0.78])
buttons_list = [handles.surface_3D_img_seg, handles.surface_3D_img, handles.montage_image, handles.show_image_all, handles.show_seg_all];
set(buttons_list,'Value',0);
axes(handles.axes2);

if size(seg,1) ~= 0
    Surface3D(seg, [], 'blue'); 
else
    set(handles.axes2,'visible', 'off');
    msgbox('Read segmentation!');
end




% --- Executes on button press in show_image_all.
function show_image_all_Callback(hObject, eventdata, handles)
% hObject    handle to show_image_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of show_image_all

global file_img

cla(handles.axes2,'reset');
set(gca,'Color',[0.83 0.82 0.78])
buttons_list = [handles.numberLayer, handles.surface_3D_img_seg, handles.surface_3D_img, handles.surface_3D_seg, handles.montage_image, handles.show_seg_all];
set(buttons_list,'Value',0);
set(handles.axes2,'visible', 'off');

if size(file_img,1) ~= 0
   figure();
   imshow3D(file_img,[]);
else
    set(handles.axes2,'visible', 'off');
    msgbox('Read images!');
end





% --- Executes on button press in show_seg_all.
function show_seg_all_Callback(hObject, eventdata, handles)
% hObject    handle to show_seg_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of show_seg_all
global seg

cla(handles.axes2,'reset');
set(gca,'Color',[0.83 0.82 0.78])
buttons_list = [handles.surface_3D_img_seg, handles.surface_3D_img, handles.surface_3D_seg, handles.show_image_all, handles.montage_image];
set(buttons_list,'Value',0);
set(handles.axes2,'visible', 'off');


if size(seg,1) ~= 0
    figure();
    imshow3D(seg,[]);
else
    set(handles.axes2,'visible', 'off');
    msgbox('Read segmentation!');
end


% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function read_folder_images_Callback(hObject, eventdata, handles)
% hObject    handle to read_folder_images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveVideo_Callback(hObject, eventdata, handles)
% hObject    handle to saveVideo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

MakeVideo('video', 'MPEG-4')



function LoadFiles_Callback(hObject, eventdata, handles)
% hObject    handle to LoadFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LoadFiles as text
%        str2double(get(hObject,'String')) returns contents of LoadFiles as a double



% --- Executes during object creation, after setting all properties.
function LoadFiles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LoadFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function text6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in numberLayer.
function numberLayer_Callback(hObject, eventdata, handles)
% hObject    handle to numberLayer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of numberLayer
    
global file_img

cla(handles.axes2,'reset');   
set(gca,'Color',[0.83 0.82 0.78])
buttons_list = [handles.show_image_all, handles.surface_3D_img_seg, handles.surface_3D_img, handles.surface_3D_seg, handles.montage_image, handles.show_seg_all];
set(buttons_list,'Value',0);

 numberOfLayer = get(handles.edit3, 'String')
 
 numberOfLayer = str2num(numberOfLayer);
 
 if(isempty(numberOfLayer))
    set(handles.axes2,'visible', 'off');
    msgbox('Enter the layer number!');
    button = [handles. numberLayer];
    set(button,'Value',0);
    
 else
    rr = size(file_img); % nie dzia³a size ???????!!!!!!!!!! dlaczego -.-

%     if (numberOfLayer == 0 || numberOfLayer > rr(3))
%         set(handles.axes2,'visible', 'off');
% %         msgbox('Incorrect range');
%         button = [handles. numberLayer];
%         set(button,'Value',0);
% 
%     else 
       imshow(file_img(:,:,numberOfLayer),[]);
%     end
    
 end
    



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');

end
