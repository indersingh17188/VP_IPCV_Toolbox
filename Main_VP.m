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

% Last Modified by GUIDE v2.5 31-May-2019 16:32:13

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


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a= get(handles.popupmenu2, 'value')
if (a==1)
    set(handles.LPF_uibuttongroup, 'visible', 'on')
else
    set(handles.HPF_uibuttongroup, 'visible', 'on')
end

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
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


% --- Executes on button press in Log_pushbutton.
function Log_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Log_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Robert_pushbutton.
function Robert_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Robert_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Sobel_pushbutton.
function Sobel_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Sobel_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ZeroCross_pushbutton.
function ZeroCross_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ZeroCross_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Prewit_pushbutton.
function Prewit_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Prewit_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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
            
