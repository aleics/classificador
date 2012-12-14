function varargout = init(varargin)


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @init_OpeningFcn, ...
                   'gui_OutputFcn',  @init_OutputFcn, ...
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


% --- Executes just before init is made visible.
function init_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.

% Choose default command line output for init
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Llegeix fitxers .txt del directori de train
FitxersEntrenament = dir([pwd '/train/*.txt']);
LlistaEntrenament = FitxersEntrenament(1).name;

% Omple el vector vertical amb els noms dels fitxers
for i = 2:length(FitxersEntrenament)
    LlistaEntrenament = vertcat(LlistaEntrenament, FitxersEntrenament(i).name);
end

% Omple el desplegable dels Fitxers d' Entrenament amb els seus noms
set(handles.popup_entrenament,'string',LlistaEntrenament);

% Llegeix fitxers .txt del directori de train
FitxersProva = dir([pwd '/test/*.txt']);
LlistaProva = FitxersProva(1).name;

% Omple el vector vertical amb els noms dels fitxers
for i = 2:length(FitxersProva)
    LlistaProva = vertcat(LlistaProva, FitxersProva(i).name);
end

% Omple el desplegable dels Fitxers de Prova amb els seus noms
set(handles.popup_prova,'string',LlistaProva);


% --- Outputs from this function are returned to the command line.
function varargout = init_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes on selection change in popup_entrenament.
function popup_entrenament_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function popup_entrenament_CreateFcn(hObject, eventdata, handles)

handles.popup_entrenament = hObject;
guidata(hObject, handles);

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup_prova.
function popup_prova_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function popup_prova_CreateFcn(hObject, eventdata, handles)

handles.popup_prova = hObject;
guidata(hObject, handles);

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_entrena.
function push_entrena_Callback(hObject, eventdata, handles)



% --- Executes on button press in push_classifica.
function push_classifica_Callback(hObject, eventdata, handles)

