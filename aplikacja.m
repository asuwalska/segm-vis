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

% Last Modified by GUIDE v2.5 02-Jan-2019 18:25:28

% Begin initialization code - DO NOT EDIT
global pressed
pressed = false;

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

[file,path] = uiputfile({'*.fig'}); % wy�wietla okno dialogowe do zapisu zdj�cia
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
buttons_list = [handles.numberLayer, handles.numSeg, handles.surface_3D_img_seg, handles.surface_3D_img, handles.surface_3D_seg, handles.show_image_all, handles.show_seg_all];
set(buttons_list,'Value',0);
axes(handles.axes2);

if get(handles.montage_image,'Value') == 1
    if size(file_img,1) ~= 0
        set(handles.axes2,'visible', 'off');
        MontageImage(file_img);
    else
        set(handles.axes2,'visible', 'off');
        msgbox('Read images!');
    end
else
    set(handles.montage_image,'Value',0);
    set(handles.axes2,'visible', 'off');
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
buttons_list = [handles.numberLayer, handles.numSeg, handles.montage_image, handles.surface_3D_img, handles.surface_3D_seg, handles.show_image_all, handles.show_seg_all];
set(buttons_list,'Value',0);
axes(handles.axes2);

if get(handles.surface_3D_img_seg, 'Value') == 1
    if (size(file_img,1) ~= 0 && size(seg,1) ~= 0)
        set(handles.axes2,'visible', 'off');
        c = uisetcolor('Color of image');
        a = uisetcolor('Color of segmentation');
        Surface3D(seg, file_img, a, c, 1, 0.1);
        set(handles.axes2,'visible', 'off');
    else
        set(handles.axes2,'visible', 'off');
        msgbox('Read images and segmentation!');
    end
else
    set(handles.surface_3D_img_seg,'Value',0);
    set(handles.axes2,'visible', 'off');
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
buttons_list = [handles.numberLayer, handles.numSeg, handles.surface_3D_img_seg, handles.montage_image, handles.surface_3D_seg, handles.show_image_all, handles.show_seg_all];
set(buttons_list,'Value',0);
axes(handles.axes2);

if get(handles.surface_3D_img, 'Value') == 1
    if size(file_img,1) ~= 0
        set(handles.axes2,'visible', 'off');
        c = uisetcolor('Color of image');
        Surface3D(file_img, [], c, 0, 0.1);
        set(handles.axes2,'visible', 'off');
    else
        set(handles.axes2,'visible', 'off');
        msgbox('Read images!');
    end
else
    set(handles.surface_3D_img,'Value',0);
    set(handles.axes2,'visible', 'off');
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
buttons_list = [handles.numberLayer, handles.numSeg, handles.surface_3D_img_seg, handles.surface_3D_img, handles.montage_image, handles.show_image_all, handles.show_seg_all];
set(buttons_list,'Value',0);
axes(handles.axes2);

if get(handles.surface_3D_seg, 'Value') == 1
    if size(seg,1) ~= 0
        set(handles.axes2,'visible', 'off');
        c = uisetcolor('Color of segmentation')
        Surface3D(seg, [], c, c, 1, 0); 
    else
        set(handles.axes2,'visible', 'off');
        msgbox('Read segmentation!');
    end
else
    set(handles.surface_3D_seg,'Value',0);
    set(handles.axes2,'visible', 'off');
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
buttons_list = [handles.numberLayer, handles.numSeg, handles.numberLayer, handles.surface_3D_img_seg, handles.surface_3D_img, handles.surface_3D_seg, handles.montage_image, handles.show_seg_all];
set(buttons_list,'Value',0);
set(handles.axes2,'visible', 'off');

if get(handles.show_image_all, 'Value') == 1
    if size(file_img,1) ~= 0
       figure();
       imshow3D(file_img,[]);
    else
        set(handles.axes2,'visible', 'off');
        msgbox('Read images!');
    end
else
    set(handles.show_image_all,'Value',0);
    set(handles.axes2,'visible', 'off');
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
buttons_list = [handles.numberLayer, handles.numSeg, handles.surface_3D_img_seg, handles.surface_3D_img, handles.surface_3D_seg, handles.show_image_all, handles.montage_image];
set(buttons_list,'Value',0);
set(handles.axes2,'visible', 'off');

if get(handles.show_seg_all, 'Value') == 1
    if size(seg,1) ~= 0
        figure();
        imshow3D(seg,[]);
    else
        set(handles.axes2,'visible', 'off');
        msgbox('Read segmentation!');
    end
else
    set(handles.show_seg_all,'Value',0);
    set(handles.axes2,'visible', 'off'); 
end

% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)
% hObject    handle to read_file_images (see GCBO)
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
buttons_list = [handles.numSeg, handles.show_image_all, handles.surface_3D_img_seg, handles.surface_3D_img, handles.surface_3D_seg, handles.montage_image, handles.show_seg_all];
set(buttons_list,'Value',0);


if get(handles.numberLayer, 'Value') == 1
     numberOfLayer = get(handles.edit3, 'String')

     numberOfLayer = str2num(numberOfLayer);

     if(isempty(numberOfLayer))
        set(handles.axes2,'visible', 'off');
        msgbox('Enter the layer number!');
        button = [handles. numberLayer];
        set(button,'Value',0);

     else
         if size(file_img,1) ~= 0 
             if numberOfLayer > 0 && numberOfLayer < size(file_img,3)
                 imshow(file_img(:,:,numberOfLayer),[]);
             else
                 set(handles.axes2,'visible', 'off');
                 msgbox({['B��d! Wprowad� poprawny zakres:']...
                        ['1 : ',num2str(size(file_img,3))]})
                 set(handles.numberLayer,'Value',0);
                 set(handles.axes2,'visible', 'off');
             end
             
         else
            set(handles.axes2,'visible', 'off');
            msgbox('Read images!');
         end
     end
else
    set(handles.numberLayer,'Value',0);
    set(handles.axes2,'visible', 'off');
end
    



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


% --- Executes on button press in numSeg.
function numSeg_Callback(hObject, eventdata, handles)
% hObject    handle to numSeg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of numSeg
global seg

cla(handles.axes2,'reset');   
set(gca,'Color',[0.83 0.82 0.78])
buttons_list = [handles.numberLayer, handles.show_image_all, handles.surface_3D_img_seg, handles.surface_3D_img, handles.surface_3D_seg, handles.montage_image, handles.show_seg_all];
set(buttons_list,'Value',0);

if get(handles.numSeg, 'Value') == 1
     numberOfLayer = get(handles.edit4, 'String')

     numberOfLayer = str2num(numberOfLayer);

     if(isempty(numberOfLayer))
        set(handles.axes2,'visible', 'off');
        msgbox('Enter the layer number!');
        button = [handles. numSeg];
        set(button,'Value',0);

     else
         if size(seg,1) ~= 0
             if numberOfLayer > 0 && numberOfLayer < size(seg,3)
                    imshow(seg(:,:,numberOfLayer),[]);
             else
                 set(handles.axes2,'visible', 'off');
                 msgbox({['B��d! Wprowad� poprawny zakres:']...
                 ['1 : ',num2str(size(seg,3))]})
                 set(handles.numSeg,'Value',0);
                 set(handles.axes2,'visible', 'off');
             end
         else
            set(handles.axes2,'visible', 'off');
            msgbox('Read segmentation!');
         end
     end
else
    set(handles.numSeg,'Value',0);
    set(handles.axes2,'visible', 'off');
end


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over surface_3D_img_seg.


