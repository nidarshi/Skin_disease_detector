function varargout = SkinDiseaseDetector(varargin)
% SKINDISEASEDETECTOR MATLAB code for SkinDiseaseDetector.fig
%      SKINDISEASEDETECTOR, by itself, creates a new SKINDISEASEDETECTOR or raises the existing
%      singleton*.
%
%      H = SKINDISEASEDETECTOR returns the handle to a new SKINDISEASEDETECTOR or the  handle to
%      the existing singleton*.
%
%      SKINDISEASEDETECTOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SKINDISEASEDETECTOR.M with the given input arguments.
%
%      SKINDISEASEDETECTOR('Property','Value',...) creates a new SKINDISEASEDETECTOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SkinDiseaseDetector_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SkinDiseaseDetector_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SkinDiseaseDetector

% Last Modified by GUIDE v2.5 09-Jun-2020 22:35:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SkinDiseaseDetector_OpeningFcn, ...
                   'gui_OutputFcn',  @SkinDiseaseDetector_OutputFcn, ...
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


% --- Executes just before SkinDiseaseDetector is made visible.

function SkinDiseaseDetector_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SkinDiseaseDetector (see VARARGIN)
clc
% Update handles structure
guidata(hObject, handles);



% UIWAIT makes SkinDiseaseDetector wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SkinDiseaseDetector_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure


% --- Executes on button press in loadImage.
function loadImage_Callback(hObject, eventdata, handles)
% hObject    handle to loadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile(...
    {'*.jpg;*.gif;*.png;*.bmp',...
     'image file(*.jpg,*.gif,*.png,*.bmp)';'*.*','all files(*.*)'},...
     'load the skin images');

% need to handle the case where the user presses cancel
if filename~=0
    fullimagefilename = fullfile(pathname,filename);

    % create an img field in handles for the image that is being loaded
    handles.img = imread(fullimagefilename);
   

    axes(handles.axes1);
    image(handles.img);  
    title(' Original Image ');
    axes(handles.axes2);
    image(handles.img);
    title(' Enhanced Image ');
    axes(handles.axes3);
    title('');
    % save the application data
    guidata(hObject,handles);
end



% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all


% --- Executes on button press in result.
function result_Callback(hObject, eventdata, handles)
% hObject    handle to result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load NewskinDb.mat


if isfield(handles,'img')

    % copy the image from the handles structure
    im=getimage(handles.axes2);
    im2 = imresize(im,[400,600]);
    % continue with your code
    % etc.

end
net=convnet;
label=classify(net,im2);

   
axes(handles.axes3);
t=title(char(label));
t.FontSize = 14;
t.Color = 'blue';



% Put the test features into variable 'test'


% Update GUI
guidata(hObject,handles);




% --- Executes on slider movement.
function brightness_Callback(hObject, eventdata, handles)
% hObject    handle to brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Gamma=get(hObject,'Value')+1;
J=getimage(handles.axes2);
K=imadjust(J,[],[],Gamma);
axes(handles.axes2);
image(K);
title(' Enhanced Image ');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function brightness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function contrast_Callback(hObject, eventdata, handles)
% hObject    handle to contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

T=[get(hObject,'Value'),1];
J=handles.img;
K2=imadjust(J,stretchlim(J, T), [0 1]);
axes(handles.axes2);
image(K2);
title(' Enhanced Image ');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function contrast_CreateFcn(hObject, eventdata, handles)
% hObject    handle to contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in resetimage.
function resetimage_Callback(hObject, eventdata, handles)
% hObject    handle to resetimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
title('');
cla;
axes(handles.axes2);
title('');
cla;
axes(handles.axes3);
title('');
cla;
guidata(hObject,handles);




% --- Executes on button press in cropimage.
function cropimage_Callback(~, eventdata, handles)
% hObject    handle to cropimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Z=getimage(handles.axes2);
W=imcrop(Z);
axes(handles.axes2);
image(W);
