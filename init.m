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
FitxersProva = dir([pwd '/test/*.txt']);
LlistaProva = FitxersProva(1).name;

% Omple el vector vertical amb els noms dels fitxers
for i = 2:length(FitxersProva)
    LlistaProva = vertcat(LlistaProva, FitxersProva(i).name);
end
LlistaProva = mat2cell(LlistaProva);
% Omple el desplegable dels Fitxers de Prova amb els seus noms
set(handles.popup_prova,'string',LlistaProva);

% Emplena el desplegable de N imatges a llegir en funci� del nombre de
% l�nies que hi ha a l'arxiu seleccionat.
fid = fopen(['test/' getCurrentPopupString(handles.popup_prova)]);

nLinies = 0;
while (fgets(fid) ~= -1),
  nLinies = nLinies+1;
end
fclose(fid);

% Creaci� i assignaci� del String del desplegable.
n_imatges = 1;
for i = 2:nLinies
    n_imatges = vertcat(n_imatges, i);
end
n_imatges = mat2cell(n_imatges);
set(handles.n_imatges_popup, 'String', n_imatges);


% --- Outputs from this function are returned to the command line.
function varargout = init_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes on selection change in popup_prova.
function popup_prova_Callback(hObject, eventdata, handles)

% Llegeix i compta les l�nies del fitxer seleccionat.
fid = fopen(['test/' getCurrentPopupString(handles.popup_prova)]);

nLinies = 0;
while (fgets(fid) ~= -1),
  nLinies = nLinies+1;
end
fclose(fid);

% Creaci� i assignaci� del String del desplegable.
n_imatges = 1;
for i = 2:nLinies
    n_imatges = vertcat(n_imatges, i);
end
n_imatges = mat2cell(n_imatges);
set(handles.n_imatges_popup, 'String', n_imatges);

% --- Executes during object creation, after setting all properties.
function popup_prova_CreateFcn(hObject, eventdata, handles)

handles.popup_prova = hObject;
guidata(hObject, handles);

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_entrena.
function push_entrena_Callback(hObject, eventdata, handles)
%Variables globals.
global mitjana_verd_natura;
global mitjana_verd_ciutat;
global mitjana_linia_natura;
global mitjana_linia_ciutat;

% Crida a la funci� train i li passa el nom del fitxer a obrir
[mitjana_verd_natura,mitjana_verd_ciutat,mitjana_linia_natura,mitjana_linia_ciutat] = train;

% C�lcul de llindars idonis.
K_verd = (mitjana_verd_natura + mitjana_verd_ciutat)/2;
K_linies = (mitjana_linia_natura + mitjana_linia_ciutat)/2;

% Display dels llindars a la interf�cie.
set(handles.verd_percent, 'String', [num2str(K_verd*100) ' %']);
set(handles.n_linies, 'String', num2str(K_linies));

% Habilita el bot� de classificaci�
set(handles.push_classifica,'Enable','on');



% --- Executes on button press in push_classifica.
function push_classifica_Callback(hObject, eventdata, handles)
%Variables globals.
global mitjana_verd_natura;
global mitjana_verd_ciutat;
global mitjana_linia_natura;
global mitjana_linia_ciutat;

% Llegeix el contingut del desplegable d'entrenament 
file = getCurrentPopupString(handles.popup_prova);

% Lectura del record i la precisi�.
grup = file(1:2);
num = str2num(getCurrentPopupString(handles.n_imatges_popup));
[x_record,y_precisio] = classificacio_llindars(grup, num, mitjana_verd_natura,mitjana_verd_ciutat,mitjana_linia_natura,mitjana_linia_ciutat);

% Escriu el record i la precisi� a la interf�cie.
set(handles.precisio, 'String', y_precisio);
set(handles.record, 'String', x_record);

% Dibuixa la gr�fica de precisi� i record.

% Dibuixa la matriu de confusi�.


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in n_imatges_popup.
function n_imatges_popup_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function n_imatges_popup_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit2_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
