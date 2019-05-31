function varargout = Main_VP(varargin)
% MAIN_VP MATLAB code for Main_VP.fig
%      MAIN_VP, by itself, creates a new MAIN_VP or raises the existing
%      singleton*.
%
%      H = MAIN_VP returns the handle to a new MAIN_VP or the handle to
%      the existing singleton*.
%
%      MAIN_VP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_VP.M with the given input arguments.
%
%      MAIN_VP('Property','Value',...) creates a new MAIN_VP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_VP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_VP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main_VP

<<<<<<< HEAD
% <<<<<<< HEAD
% % Last Modified by GUIDE v2.5 31-May-2019 18:47:28
% =======
% % Last Modified by GUIDE v2.5 31-May-2019 18:07:16
% >>>>>>> edbba30d95e6179d88dc158129f31866e5fa58d5

=======
>>>>>>> 586eee18a473097eb5165e65387abd873a0a8eec
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_VP_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_VP_OutputFcn, ...
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


% --- Executes just before Main_VP is made visible.
function Main_VP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main_VP (see VARARGIN)

% Choose default command line output for Main_VP
handles.output = hObject;



%to clear x,y ticklabels in axes handles 
axes(handles.axes1);
set(gca,'XtickLabel',[],'YtickLabel',[]);

%to set axes handles not to show ticks on axes
axes(handles.axes2);
set(gca,'XtickLabel',[],'YtickLabel',[]);


set(handles.ColorSpace_radio, 'value', 0);
set(handles.Hist_radio, 'value', 0);
set(handles.Morph_radio, 'value', 0);




set(handles.ColSpace_uibuttongroup, 'visible', 'off');
set(handles.Hist_buttongroup, 'visible', 'off');
set(handles.Morph_uibuttongroup, 'visible', 'off');

set(handles.Basic_uibuttongroup,'visible','off');
set(handles.EdgLine_uibuttongroup,'visible','off');
set(handles.uibuttongroup_tab3,'visible','off');
set(handles.FeatureMatching_uibuttongroup,'visible','off');
set(handles.Contour_uibuttongroup,'visible','off');
set(handles.ObjectDetect_uibuttongroup,'visible','off');
set(handles.CC_uibuttongroup,'visible','off');
set(handles.FeatureMatching_uibuttongroup, 'visible', 'off');

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes Main_VP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Main_VP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Reset_pushbutton.
function Reset_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Reset_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Load_pushbutton.
function Load_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Load_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Function to get image
[filename, pathname] = uigetfile({'*.jpg;*.tif;*.bmp;*.jpeg;*.png;*.gif','All Image Files';'*.*','All Files'}, 'Select an Image');
fileName = fullfile(pathname, filename);

% read image
img = imread(fileName);

axes(handles.axes1);
imshow(img);

handles.img = img;
guidata(hObject, handles);

set(handles.Apply_pushbutton,'Enable','on'); % set process button vissibility on

% --- Executes on button press in Image_radio.
function Image_radio_Callback(hObject, eventdata, handles)
% hObject    handle to Image_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Image_radio


% --- Executes on button press in Video_radio.
function Video_radio_Callback(hObject, eventdata, handles)
% hObject    handle to Video_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Video_radio


% --- Executes on button press in Apply_pushbutton.
function Apply_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Apply_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% for General tab
if get(handles.Filter_uibuttongroup, 'Value') == true
    
    set(handles.histPanel,'visible','off'); % to make histogram panel off
    % For Noise
    if get(handles.noiseRadio,'Value') == true
        % for salt and pepper
        if get(handles.saltRadio, 'Value') == true
            %get the noise density value
            nDen = str2double(get(handles.saltDensityEdit, 'String'));
            img_out = imnoise(img,'salt & pepper', nDen); % add noise
            % show output image
            axes(handles.axes2);
            imshow(img_out);
            handles.img_out = img_out; guidata(hObject,handles);
        
        % for gaussian noise
        elseif get(handles.gaussianRadio, 'Value') == true
            %get mean and variance
            gMean = str2double(get(handles.meanEdit, 'String')); 
            gVar = str2double(get(handles.varianceEdit, 'String'));
            img_out = imnoise(img,'gaussian',gMean,gVar);
            % show output image
            axes(handles.axes2);
            imshow(img_out);
            handles.img_out = img_out; guidata(hObject,handles);
        end
    end
end




% --- Executes on button press in Save_pushbutton.
function Save_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Save_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imgout = handles.axes2;
[a b] =uiputfile();
filename = strcat(b,a);
imwrite(imgout,filename);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in Filter_popupmenu.
function Filter_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to Filter_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a= get(handles.Filter_popupmenu, 'value')
if (a==1)
    set(handles.LPF_uibuttongroup, 'visible', 'on')
else
    set(handles.HPF_uibuttongroup, 'visible', 'on')
end

% Hints: contents = cellstr(get(hObject,'String')) returns Filter_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Filter_popupmenu


% --- Executes during object creation, after setting all properties.
function Filter_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Filter_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Basic_pushbutton.
function Basic_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Basic_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Basic_uibuttongroup,'visible','on');
set(handles.EdgLine_uibuttongroup,'visible','off');
set(handles.uibuttongroup_tab3,'visible','off');
set(handles.FeatureMatching_uibuttongroup,'visible','off');
set(handles.Contour_uibuttongroup,'visible','off');
set(handles.ObjectDetect_uibuttongroup,'visible','off');
set(handles.CC_uibuttongroup,'visible','off');
set(handles.FeatureMatching_uibuttongroup, 'visible', 'off');



% --- Executes on button press in Edg_Line_pushbutton.
function Edg_Line_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Edg_Line_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.EdgLine_uibuttongroup,'visible','on');
set(handles.Basic_uibuttongroup,'visible','off');
set(handles.uibuttongroup_tab3,'visible','off');
set(handles.FeatureMatching_uibuttongroup,'visible','off');
set(handles.Contour_uibuttongroup,'visible','off');
set(handles.ObjectDetect_uibuttongroup,'visible','off');
set(handles.CC_uibuttongroup,'visible','off');
set(handles.EdgLine_uibuttongroup,'position',get(handles.Basic_uibuttongroup,'position'));


% --- Executes on button press in Filter_pushbutton.
function Filter_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Filter_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup_tab3,'visible','on');
set(handles.Basic_uibuttongroup,'visible','off');
set(handles.EdgLine_uibuttongroup,'visible','off');
set(handles.FeatureMatching_uibuttongroup,'visible','off');
set(handles.Contour_uibuttongroup,'visible','off');
set(handles.ObjectDetect_uibuttongroup,'visible','off');
set(handles.CC_uibuttongroup,'visible','off');
set(handles.uibuttongroup_tab3,'position',get(handles.Basic_uibuttongroup,'position'));



% --- Executes on button press in FeatMatch_pushbutton.
function FeatMatch_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to FeatMatch_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.FeatureMatching_uibuttongroup,'visible','on');
set(handles.Basic_uibuttongroup,'visible','off');
set(handles.EdgLine_uibuttongroup,'visible','off');
set(handles.uibuttongroup_tab3,'visible','off');
set(handles.Contour_uibuttongroup,'visible','off');
set(handles.ObjectDetect_uibuttongroup,'visible','off');
set(handles.CC_uibuttongroup,'visible','off');
set(handles.FeatureMatching_uibuttongroup,'position',get(handles.Basic_uibuttongroup,'position'));


% --- Executes on button press in Contour_pushbutton.
function Contour_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Contour_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Contour_uibuttongroup,'visible','on');
set(handles.Basic_uibuttongroup,'visible','off');
set(handles.EdgLine_uibuttongroup,'visible','off');
set(handles.uibuttongroup_tab3,'visible','off');
set(handles.FeatureMatching_uibuttongroup,'visible','off');
set(handles.ObjectDetect_uibuttongroup,'visible','off');
set(handles.CC_uibuttongroup,'visible','off');
set(handles.Contour_uibuttongroup,'position',get(handles.Basic_uibuttongroup,'position'));



% --- Executes on button press in ObjectDetect_pushbutton.
function ObjectDetect_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ObjectDetect_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ObjectDetect_uibuttongroup,'visible','on');
set(handles.Basic_uibuttongroup,'visible','off');
set(handles.EdgLine_uibuttongroup,'visible','off');
set(handles.uibuttongroup_tab3,'visible','off');
set(handles.FeatureMatching_uibuttongroup,'visible','off');
set(handles.Contour_uibuttongroup,'visible','off');
set(handles.CC_uibuttongroup,'visible','off');
set(handles.ObjectDetect_uibuttongroup,'position',get(handles.Basic_uibuttongroup,'position'));


% --- Executes on button press in Calib_pushbutton.
function Calib_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Calib_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.CC_uibuttongroup,'visible','on');
set(handles.Basic_uibuttongroup,'visible','off');
set(handles.EdgLine_uibuttongroup,'visible','off');
set(handles.uibuttongroup_tab3,'visible','off');
set(handles.FeatureMatching_uibuttongroup,'visible','off');
set(handles.Contour_uibuttongroup,'visible','off');
set(handles.ObjectDetect_uibuttongroup,'visible','off');
set(handles.CC_uibuttongroup,'position',get(handles.Basic_uibuttongroup,'position'));



function HP_edit_Callback(hObject, eventdata, handles)
% hObject    handle to HP_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
edit=get(hObject, 'string');
set(hObject.HP_slider, 'value', 'str2num');
guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of HP_edit as text
%        str2double(get(hObject,'String')) returns contents of HP_edit as a double


% --- Executes during object creation, after setting all properties.
function HP_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HP_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function HP_slider_Callback(hObject, eventdata, handles)
% hObject    handle to HP_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider=get(hObject, 'value');
set(handles.HP_edit ,'string', num2str(slider));
guidata(hObject, handles);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function HP_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HP_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function LP_edit_Callback(hObject, eventdata, handles)
% hObject    handle to LP_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
edit=get(hObject, 'string');
set(hObject.LP_slider, 'value', 'str2num');
guidata(hObject, handles);



% Hints: get(hObject,'String') returns contents of LP_edit as text
%        str2double(get(hObject,'String')) returns contents of LP_edit as a double


% --- Executes during object creation, after setting all properties.
function LP_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LP_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function LP_slider_Callback(hObject, eventdata, handles)
% hObject    handle to LP_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider=get(hObject, 'value');
set(handles.LP_edit ,'string', num2str(slider));
guidata(hObject, handles);


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function LP_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LP_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in FeatExtract_popupmenu.
function FeatExtract_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to FeatExtract_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = get(handles.FeatExtract_popupmenu,'Value')
switch contents
    case 1
        set(handles.Surf_uibuttongroup,'visible','on');

end

% Hints: contents = cellstr(get(hObject,'String')) returns FeatExtract_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FeatExtract_popupmenu


% --- Executes during object creation, after setting all properties.
function FeatExtract_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FeatExtract_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Dilate_pushbutton.
function Dilate_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Dilate_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Erode_pushbutton.
function Erode_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Erode_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Open_pushbutton.
function Open_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Open_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Close_pushbutton.
function Close_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Close_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Dis_pushbutton.
function Dis_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Dis_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Equal_pushbutton.
function Equal_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Equal_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in RGB2gray.
function RGB2gray_Callback(hObject, eventdata, handles)
% hObject    handle to RGB2gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in RGB2Ycbcr.
function RGB2Ycbcr_Callback(hObject, eventdata, handles)
% hObject    handle to RGB2Ycbcr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in RGB2HSV.
function RGB2HSV_Callback(hObject, eventdata, handles)
% hObject    handle to RGB2HSV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Noise_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Noise_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
edit=get(hObject, 'string');
set(hObject.slider3, 'value', 'str2num');
guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of Noise_edit as text
%        str2double(get(hObject,'String')) returns contents of Noise_edit as a double


% --- Executes during object creation, after setting all properties.
function Noise_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Noise_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Noise_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Noise_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider=get(hObject, 'value');
set(handles.Noise_edit ,'string', num2str(slider));
guidata(hObject, handles);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Noise_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Noise_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in Contour_popupmenu.
function Contour_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to Contour_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Contour_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Contour_popupmenu


% --- Executes during object creation, after setting all properties.
function Contour_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Contour_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CC_pushbutton.
function CC_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to CC_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%let's gather 2d image points
[imagePoints, boardSize, ~] = detectCheckerboardPoints(handles.chk_images);

% get the size of square from user in mm
squareSize = str2double(get(handles.CC_edit,'String'));

%get 3d world points
worldPoints = generateCheckerboardPoints(boardSize, squareSize);
% Calibrate the camera
handles.cameraParams = estimateCameraParameters(imagePoints, worldPoints);

axes(handles.axes2);  showExtrinsics(handles.cameraParams);
guidata(hObject,handles); %% to save data in global structure "handles"

function CC_edit_Callback(hObject, eventdata, handles)
% hObject    handle to CC_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CC_edit as text
%        str2double(get(hObject,'String')) returns contents of CC_edit as a double


% --- Executes during object creation, after setting all properties.
function CC_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CC_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in EdgLine_popupmenu.
function EdgLine_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to EdgLine_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns EdgLine_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from EdgLine_popupmenu


% --- Executes during object creation, after setting all properties.
function EdgLine_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EdgLine_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LinDetThresh_edit_Callback(hObject, eventdata, handles)
% hObject    handle to LinDetThresh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LinDetThresh_edit as text
%        str2double(get(hObject,'String')) returns contents of LinDetThresh_edit as a double


% --- Executes during object creation, after setting all properties.
function LinDetThresh_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LinDetThresh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Canny_pushbutton.
function Canny_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Canny_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
count = get(handles.EdgDetThresh_edit,'String');
count = num2str(count);


% --- Executes on button press in Log_pushbutton.
function Log_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Log_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
count = get(handles.EdgDetThresh_edit,'String');
count = num2str(count);


% --- Executes on button press in Robert_pushbutton.
function Robert_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Robert_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
count = get(handles.EdgDetThresh_edit,'String');
count = num2str(count);


% --- Executes on button press in Sobel_pushbutton.
function Sobel_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Sobel_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
count = get(handles.EdgDetThresh_edit,'String');
count = num2str(count);


% --- Executes on button press in ZeroCross_pushbutton.
function ZeroCross_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ZeroCross_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
count = get(handles.EdgDetThresh_edit,'String');
count = num2str(count);


% --- Executes on button press in Prewit_pushbutton.
function Prewit_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Prewit_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
count = get(handles.EdgDetThresh_edit,'String');
count = num2str(count);



function EdgDetThresh_edit_Callback(hObject, eventdata, handles)
% hObject    handle to EdgDetThresh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EdgDetThresh_edit as text
%        str2double(get(hObject,'String')) returns contents of EdgDetThresh_edit as a double


% --- Executes during object creation, after setting all properties.
function EdgDetThresh_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EdgDetThresh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FeatExtThresh_edit_Callback(hObject, eventdata, handles)
% hObject    handle to FeatExtThresh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FeatExtThresh_edit as text
%        str2double(get(hObject,'String')) returns contents of FeatExtThresh_edit as a double


% --- Executes during object creation, after setting all properties.
function FeatExtThresh_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FeatExtThresh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FeatExtNumFeat_edit_Callback(hObject, eventdata, handles)
% hObject    handle to FeatExtNumFeat_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FeatExtNumFeat_edit as text
%        str2double(get(hObject,'String')) returns contents of FeatExtNumFeat_edit as a double


% --- Executes during object creation, after setting all properties.
function FeatExtNumFeat_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FeatExtNumFeat_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Load1FeatMatch_pushbutton.
function Load1FeatMatch_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Load1FeatMatch_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Load2FeatMatch_pushbutton.
function Load2FeatMatch_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Load2FeatMatch_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in MatchFeat_pushbutton.
function MatchFeat_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to MatchFeat_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Logo_pushbutton.
function Logo_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Logo_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%make a duplicate of image
img_out = img;

% add logo at bottom right
img_out(end-rows+1:end,end-cols+1:end) = alphaResize.*double(img_logo) + ...
    (1-alphaResize).*double(img_out(end-rows+1:end,end-cols+1:end));

% show output image
axes(handles.axes2);
imshow(img_out);
handles.img_out = img_out; guidata(hObject,handles);
            


% --- Executes on button press in pushbutton37.
function pushbutton37_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


<<<<<<< HEAD

=======
>>>>>>> 586eee18a473097eb5165e65387abd873a0a8eec
% --- Executes on button press in Hist_radio.
function Hist_radio_Callback(hObject, eventdata, handles)
% hObject    handle to Hist_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ColSpace_uibuttongroup, 'visible', 'off');
set(handles.Hist_buttongroup, 'visible', 'on');
set(handles.Morph_uibuttongroup, 'visible', 'off');

set(handles.ColorSpace_radio, 'value', 0);
set(handles.Hist_radio, 'value', 1);
set(handles.Morph_radio, 'value', 0);


% Hint: get(hObject,'Value') returns toggle state of Hist_radio


% --- Executes on button press in ColorSpace_radio.
function ColorSpace_radio_Callback(hObject, eventdata, handles)
% hObject    handle to ColorSpace_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ColSpace_uibuttongroup, 'visible', 'on');
set(handles.Hist_buttongroup, 'visible', 'off');
set(handles.Morph_uibuttongroup, 'visible', 'off');

set(handles.ColorSpace_radio, 'value', 1);
set(handles.Hist_radio, 'value', 0);
set(handles.Morph_radio, 'value', 0);





% Hint: get(hObject,'Value') returns toggle state of ColorSpace_radio


% --- Executes on button press in Morph_radio.
function Morph_radio_Callback(hObject, eventdata, handles)
% hObject    handle to Morph_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ColSpace_uibuttongroup, 'visible', 'off');
set(handles.Hist_buttongroup, 'visible', 'off');
set(handles.Morph_uibuttongroup, 'visible', 'on');

set(handles.ColorSpace_radio, 'value', 0);
set(handles.Hist_radio, 'value', 0);
set(handles.Morph_radio, 'value', 1);

<<<<<<< HEAD
% Hint: get(hObject,'Value') returns toggle state of Morph_radio
=======
>>>>>>> 586eee18a473097eb5165e65387abd873a0a8eec

% --- Executes on button press in pushbuttonchecker.
function pushbuttonchecker_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonchecker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ask user to input checkerboard images
[names, path] = uigetfile('*.*','Select checkerboard images', 'MultiSelect', 'on');
% % return from this call, if no file is selected
if isnumeric(names)
    return
end

% % convert char to cell, if only one file is selected
if ~iscellstr(names)
    names = cellstr(names);
end
image_count = length(names); %total number of images

%let's make an array of filenames
for i = 1 : image_count
    current_file_name = strcat(path, names{i});
    handles.chk_images{i} = current_file_name;
end
guidata(hObject,handles); %% to save data in global structure "handles"


% --- Executes on button press in pushbutton39.
function pushbutton39_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name, path] = uigetfile('*.*','Select image 1', 'MultiSelect', 'off');
% % return from this call, if no file is selected
if isnumeric(name)
    return
end

filename = strcat(path, name);
I = imread(filename);
handles.img1 = undistortImage(I, handles.cameraParams);
guidata(hObject,handles); %% to save data in global structure "handles"

% --- Executes on button press in pushbutton40.
function pushbutton40_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name, path] = uigetfile('*.*','Select image 1', 'MultiSelect', 'off');
% % return from this call, if no file is selected
if isnumeric(name)
    return
end

filename = strcat(path, name);
I = imread(filename);
%let's undistort the image
handles.img2 = undistortImage(I, handles.cameraParams);

guidata(hObject,handles); %% to save data in global structure "handles"

% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I1 = handles.img1;
I2 = handles.img2;
cameraParams = handles.cameraParams;

% Detect feature points
imagePoints1 = detectMinEigenFeatures(rgb2gray(I1), 'MinQuality', 0.1);

% Visualize detected points
figure
imshow(I1, 'InitialMagnification', 50);
title('150 Strongest Corners from the First Image');
hold on
plot(selectStrongest(imagePoints1, 150));

% Create the point tracker
tracker = vision.PointTracker('MaxBidirectionalError', 1, 'NumPyramidLevels', 5);

% Initialize the point tracker
imagePoints1 = imagePoints1.Location;
initialize(tracker, imagePoints1, I1);

% Track the points
[imagePoints2, validIdx] = step(tracker, I2);
matchedPoints1 = imagePoints1(validIdx, :);
matchedPoints2 = imagePoints2(validIdx, :);

% Visualize correspondences
figure
showMatchedFeatures(I1, I2, matchedPoints1, matchedPoints2);
title('Tracked Features');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Estimate the fundamental matrix
[E, epipolarInliers] = estimateEssentialMatrix(...
    matchedPoints1, matchedPoints2, cameraParams, 'Confidence', 99.99);

% Find epipolar inliers
inlierPoints1 = matchedPoints1(epipolarInliers, :);
inlierPoints2 = matchedPoints2(epipolarInliers, :);

% Display inlier matches
figure
showMatchedFeatures(I1, I2, inlierPoints1, inlierPoints2);
title('Epipolar Inliers');

[orient, loc] = relativeCameraPose(E, cameraParams, inlierPoints1, inlierPoints2);

% Detect dense feature points. Use an ROI to exclude points close to the
% image edges.
roi = [30, 30, size(I1, 2) - 30, size(I1, 1) - 30];
imagePoints1 = detectMinEigenFeatures(rgb2gray(I1), 'ROI', roi, ...
    'MinQuality', 0.001);

% Create the point tracker
tracker = vision.PointTracker('MaxBidirectionalError', 1, 'NumPyramidLevels', 5);

% Initialize the point tracker
imagePoints1 = imagePoints1.Location;
initialize(tracker, imagePoints1, I1);

% Track the points
[imagePoints2, validIdx] = step(tracker, I2);
matchedPoints1 = imagePoints1(validIdx, :);
matchedPoints2 = imagePoints2(validIdx, :);

% Compute the camera matrices for each position of the camera
% The first camera is at the origin looking along the Z-axis. Thus, its
% rotation matrix is identity, and its translation vector is 0.
camMatrix1 = cameraMatrix(cameraParams, eye(3), [0 0 0]);

% Compute extrinsics of the second camera
[R, t] = cameraPoseToExtrinsics(orient, loc);
camMatrix2 = cameraMatrix(cameraParams, R, t);

% Compute the 3-D points
points3D = triangulate(matchedPoints1, matchedPoints2, camMatrix1, camMatrix2);

% Get the color of each reconstructed point
numPixels = size(I1, 1) * size(I1, 2);
allColors = reshape(I1, [numPixels, 3]);
colorIdx = sub2ind([size(I1, 1), size(I1, 2)], round(matchedPoints1(:,2)), ...
    round(matchedPoints1(:, 1)));
color = allColors(colorIdx, :);

% Create the point cloud
ptCloud = pointCloud(points3D, 'Color', color);
% Display the 3-D Point Cloud
% Use the plotCamera function to visualize the locations and orientations of the camera, and the pcshow function to visualize the point cloud.

% Visualize the camera locations and orientations
cameraSize = 0.3;
axes(handles.axes2);
plotCamera('Size', cameraSize, 'Color', 'r', 'Label', '1', 'Opacity', 0);
hold on
grid on
plotCamera('Location', loc, 'Orientation', orient, 'Size', cameraSize, ...
    'Color', 'b', 'Label', '2', 'Opacity', 0);

% Visualize the point cloud
pcshow(ptCloud, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', ...
    'MarkerSize', 45);

% Rotate and zoom the plot
camorbit(0, -30);
camzoom(1.5);

% Label the axes
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis')

title('Up to Scale Reconstruction of the Scene');
<<<<<<< HEAD
=======


% --- Executes on button press in pushbutton42.
function pushbutton42_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
>>>>>>> 586eee18a473097eb5165e65387abd873a0a8eec
