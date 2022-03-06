{Выполнил: Шаманов И.П., вариант №25, ФН2-21Б. Создать файл записей и выполнить требуемые действия с ним}
unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Menus, ActnList, TypInfo;

type
        tSex = (woman, man);
    tSlug = record
        nam, fam : string[15];
        date   : 1920..2000;
        sex  : tSex;
    dolgn : record
    prof : record
        name : string[15];
        stag   : byte;
        doxod  : record
            osn : word;   {0 - 65535}
            premiya : word; {0 - 65535}
            nalog  : double   {13%}
            end; {doxod}
    end; {prof}
    telef : longint
    end; {dolgn}
    end; {tSlug}

  { TFMain }
  {ниже представлена главная форма и её элементы: кнопки, поля ввода/вывода и др.}
  TFMain = class(TForm)
    Button1: TButton;
    BackGround: TImage;
    FolderFileSearch: TEdit;
    FileSearchButton: TButton;
    FileSearchParams: TComboBox;
    FileInfoSearch: TEdit;
    FileSearchBox: TGroupBox;
    UIsearchfile: TLabel;
    ResultofSearchFile: TListBox;
    FileSearchScroll: TScrollBar;
    UIWARNING: TLabel;
    RenameFileButton: TButton;
    DeleteFileButton: TButton;
    DeleteButton: TButton;
    DeleteParams: TComboBox;
    DeleteComponentBox: TGroupBox;
    DeleteFileBox: TGroupBox;
    NameToRename: TEdit;
    RenameFileBox: TGroupBox;
    SurnameToDelete: TEdit;
    UIdel: TLabel;
    Operations: TComboBox;
    FileNameSearchEdit: TEdit;
    FolderNameSearch: TEdit;
    Sex1: TComboBox;
    UIElem1: TLabel;
    SearchButton: TButton;
    AgeSearchEdit: TEdit;
    SearchParams: TComboBox;
    FileOperationsBox: TGroupBox;
    FileOperationsSearchBox: TGroupBox;
    SearchResultMemo: TMemo;
    TypedName: TEdit;
    TypedFolder: TEdit;
    BaseLabel: TLabel;
    TextFileButton1: TButton;
    TextFileButton2: TButton;
    TextFileFolder: TEdit;
    TextFileName1: TEdit;
    TextFileBox: TGroupBox;
    TextFileName2: TEdit;
    ViewButton: TButton;
    CheckExistButton: TButton;
    CreateCustomTypedFile: TButton;
    DataInsert: TGroupBox;
    FileNameView: TEdit;
    FileDirectoryView: TEdit;
    FileNameCheck: TEdit;
    FileDirectoryCheck: TEdit;
    FileExistCheckBox: TGroupBox;
    FileContentsBox: TGroupBox;
    ContentsView: TMemo;
    TypedFileName: TEdit;
    FileDirectoryName: TEdit;
    FileCreation: TGroupBox;
    JobNameEdit: TEdit;
    MainMenu1: TMainMenu;
    MenuInsert: TMenuItem;
    MenuExistCheck: TMenuItem;
    MenuFileContents: TMenuItem;
    MenuFileOperations: TMenuItem;
    MenuInfSearch: TMenuItem;
    MenuAge: TMenuItem;
    MenuAdd: TMenuItem;
    MenuDelete: TMenuItem;
    MenuDeleteFile: TMenuItem;
    MenuExit: TMenuItem;
    MenuProgInfo: TMenuItem;
    MenuSearchFileBYExtsn: TMenuItem;
    MenuSearchFileBYName: TMenuItem;
    MenuSearchFile: TMenuItem;
    MenuTextFile2Crt: TMenuItem;
    MenuTextFile1Crt: TMenuItem;
    MenuTextFile: TMenuItem;
    MenuRename: TMenuItem;
    MenuRetired: TMenuItem;
    MenuSurname: TMenuItem;
    MenuJob: TMenuItem;
    MenuSex: TMenuItem;
    Premiya: TEdit;
    Sex: TComboBox;
    Telef: TEdit;
    StagEdit: TEdit;
    NameEdit: TEdit;
    Title: TLabel;
    OsnEdit: TEdit;
    SurnameEdit: TEdit;
    DateEdit: TEdit;
    {а также методы формы для работы её элементов}
    procedure Button1Click(Sender: TObject);
    procedure CheckExistButtonClick(Sender: TObject);
    procedure CreateCustomTypedFileClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure DeleteFileButtonClick(Sender: TObject);
    procedure DeleteParamsEditingDone(Sender: TObject);
    procedure FileSearchButtonClick(Sender: TObject);
    procedure FileSearchParamsEditingDone(Sender: TObject);
    procedure MenuAddClick(Sender: TObject);
    procedure MenuAgeClick(Sender: TObject);
    procedure MenuDeleteFileClick(Sender: TObject);
    procedure MenuExistCheckClick(Sender: TObject);
    procedure MenuExitClick(Sender: TObject);
    procedure MenuFileContentsClick(Sender: TObject);
    procedure MenuFileOperationsClick(Sender: TObject);
    procedure MenuInsertClick(Sender: TObject);
    procedure MenuJobClick(Sender: TObject);
    procedure MenuProgInfoClick(Sender: TObject);
    procedure MenuRenameClick(Sender: TObject);
    procedure MenuRetiredClick(Sender: TObject);
    procedure MenuSearchFileBYNameClick(Sender: TObject);
    procedure MenuSearchFileClick(Sender: TObject);
    procedure MenuSexClick(Sender: TObject);
    procedure MenuSurnameClick(Sender: TObject);
    procedure MenuTextFile1CrtClick(Sender: TObject);
    procedure MenuTextFile2CrtClick(Sender: TObject);
    procedure MenuSearchFileBYExtsnClick(Sender: TObject);
    procedure OperationsEditingDone(Sender: TObject);
    procedure RenameFileButtonClick(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure SearchParamsEditingDone(Sender: TObject);
    procedure TextFileButton1Click(Sender: TObject);
    procedure TextFileButton2Click(Sender: TObject);
    procedure ViewButtonClick(Sender: TObject);

  private

  public

  end;

var             {глобальные переменные}
  FMain: TFMain;    {главная форма}
  startflag : boolean; {флаг, указывающий на начало работы с новым файлом или добавление компонент к существующему}
implementation

const
  gender : array [tSex] of string = ('Ж', 'М');   {для вывода данных о поле}
{$R *.lfm}
{ TFMain }
procedure TFMain.Button1Click(Sender: TObject); {метод нажатия кнопки добавления служащего в файл}
var data : file of tSlug;    {переменная для обработки типизированного файла}
  name_of_typed_file, folder_name, Ext : string[15];{имя файла, папка, расширение}
  empl : tSlug ;    {переменная для чтения из файла}
begin
    if startflag  then begin
    name_of_typed_file := TypedFileName.Text;
    folder_name := FileDirectoryName.Text;
    end
    else begin
    name_of_typed_file := FileNameSearchEdit.Text;
    folder_name := FolderNameSearch.Text;
    end;
     if FileExists('D:\BMSTU\Информатика\VisualFeatures\' + folder_name + '\' + name_of_typed_file ) then
  begin
    Ext := ExtractFileExt('D:\BMSTU\Информатика\VisualFeatures\' + folder_name + name_of_typed_file);
    if Ext = '.txt' then
       ShowMessage('Это файл, не содержащий персональную информацию по служащим. Пожалуйста, выберите другой файл.')
    else
    begin
    if (OsnEdit.Text <> '') and (Premiya.Text <> '') then
    begin
    assignfile(data, 'D:\BMSTU\Информатика\VisualFeatures\' + folder_name + '\' + name_of_typed_file);
    reset(data);
    seek(data, filesize(data));
    empl.nam := NameEdit.Text;
    empl.fam := SurnameEdit.Text;
    val(DateEdit.Text, empl.date);
    empl.sex := tSex(Sex.ItemIndex);
    empl.dolgn.prof.name := JobNameEdit.Text;
    val(StagEdit.Text,empl.dolgn.prof.stag);
    val(OsnEdit.Text, empl.dolgn.prof.doxod.osn );
    val(Premiya.Text, empl.dolgn.prof.doxod.premiya );
    empl.dolgn.prof.doxod.nalog := (empl.dolgn.prof.doxod.osn + empl.dolgn.prof.doxod.premiya)*0.13;
    val(Telef.Text, empl.dolgn.telef);
    write(data, empl);
    closefile(data);
    ShowMessage('Служащий добавлен в файл!');
    end
     else ShowMessage('Заполните поля осоновного дохода и премии!');
    end
    end
     else ShowMessage('Укажите существующий файл анкет!');
end;

procedure TFMain.CheckExistButtonClick(Sender: TObject);   {метод нажатия кнопки для проверки существования файла}
var name_of_typed_file, directory_name : string;  {имя файла, путь}
begin
  name_of_typed_file := FileNameCheck.Text;
  directory_name := FileDirectoryCheck.Text;
  if FileExists(directory_name + '\' + name_of_typed_file ) then ShowMessage('Файл существует!')
  else ShowMessage('Файл в указанном пути не сущетвует!');
end;

procedure TFMain.CreateCustomTypedFileClick(Sender: TObject); {метод нажатия кнопки для создания типизированного файла записей tSlug}
var name_of_typed_file, folder_name : string[15]; {имя файла, папка}
   data : file of tSlug; {переменная для обработки типизированного файла}
begin
  name_of_typed_file := TypedFileName.Text;
  folder_name := FileDirectoryName.Text;
  CreateDir(folder_name);
  assignfile(data, 'D:\BMSTU\Информатика\VisualFeatures\' + folder_name + '\' + name_of_typed_file);
  rewrite(data);
  closefile(data);
  ShowMessage('Файл "' + name_of_typed_file + '" успешно создан!');
  TypedName.Text := name_of_typed_file;
  TypedFolder.Text := folder_name;

end;

procedure TFMain.DeleteButtonClick(Sender: TObject);  {метод нажатия кнопки для удаления компонент из файла}
var
  Reply, BoxStyle: integer;  {значения для параметров метода Application.MessageBox()}
  f: file of tSlug;  {файловая переменная}
  elem, temp : tSlug; {переменные для чтения и записи из типизированного файла}
  i, j, k, switch : byte; {переменные для позиции указателя файла, цикла с параметром, количества удаляемых компонент, выбора способа удаления}
  pens_date : 1920..2000;   {задаваемый год рождения для удаления всех пенсионеров}
  famil, file_name, file_folder, Ext : string; {пер-я для удаления по фамилии, имя файла, папка, расширение}
begin
  file_name := FileNameSearchEdit.Text;
  file_folder := FolderNameSearch.Text;
  switch := DeleteParams.ItemIndex;
  BoxStyle := 1;
   if FileExists('D:\BMSTU\Информатика\VisualFeatures\' + file_folder + '\' + file_name ) then
  begin
    Ext := ExtractFileExt('D:\BMSTU\Информатика\VisualFeatures\' + file_folder + file_name);
    if Ext = '.txt' then
    begin
      SearchResultMemo.Text := 'Это файл, не содержащий персональную информацию по служащим. Пожалуйста, выберите другой файл.';
    end
    else
    begin
  Reply := Application.MessageBox('Вы действительно хотите удалить данный(ые) элемент(ы)?', 'Подтвердите действие', BoxStyle);
  if Reply = 1 then
  begin
  assignfile(f, 'D:\BMSTU\Информатика\VisualFeatures\' + file_folder + '\' + file_name );
  reset(f);
  i := 0;
  k := 0;
  if (switch <> 0) and (switch <> 1) then ShowMessage('Задайте параметр удаления!')
  else begin
  if switch = 0 then
  begin
   famil := LowerCase(SurnameToDelete.Text);
   while (i <= filesize(f) - 2 - k) do
   begin
       seek(f, i);
       read(f, elem);
       if (LowerCase(elem.fam) = famil) or (LowerCase(elem.fam) = famil + 'a') or (LowerCase(elem.fam) = famil + 'а') then
       begin
       inc(k);
       for j := i to filesize(f)-2 do
       begin
           seek(f, j+1);
           read(f, temp);
           seek(f, j);
           write(f, temp);
       end;
       end
       else i := i+1;
   end;
   seek(f, filesize(f)-1-k);
   read(f, elem);
   if (LowerCase(elem.fam) = famil) or (LowerCase(elem.fam) = famil + 'a') or (LowerCase(elem.fam) = famil + 'а') then inc(k);
   seek(f, filesize(f)-k);
  end
  else begin
      pens_date := StrToInt(SurnameToDelete.Text);
      while (i <= filesize(f) - 2 - k) do
   begin
       seek(f, i);
       read(f, elem);
       if (elem.date <= pens_date)  then
       begin
       inc(k);
       for j := i to filesize(f)-2 do
       begin
           seek(f, j+1);
           read(f, temp);
           seek(f, j);
           write(f, temp);
       end;
       end
       else i := i+1;
   end;
   seek(f, filesize(f)-1-k);
   read(f, elem);
   if (elem.date <= pens_date) then inc(k);
   seek(f, filesize(f)-k);
  end;
  truncate(f);
  closefile(f);
  ShowMessage('Удаление завершено!');
  end;
  end;
    end;
end
   else ShowMessage('Файла не существует!');
 end;

procedure TFMain.DeleteFileButtonClick(Sender: TObject);{метод нажатия кнопки для удаления заданного файла}
var
  Reply, BoxStyle: integer; {значения для параметров метода Application.MessageBox()}
  file_folder, file_name : string; {папка, имя файла}
begin
  file_name := FileNameSearchEdit.Text;
  file_folder := FolderNameSearch.Text;
  BoxStyle := 1;
  Reply := Application.MessageBox('Вы действительно хотите удалить данный файл?', 'Подтвердите действие', BoxStyle);
  if Reply = 1 then
  begin
  if FileExists('D:\BMSTU\Информатика\VisualFeatures\' + file_folder + '\' + file_name ) then
  begin
     if deletefile('D:\BMSTU\Информатика\VisualFeatures\' + file_folder + '\' + file_name ) then
     ShowMessage('Файл ' + file_name + ' успешно удалён!')
     else ShowMessage('Возникла ошибка при удалении файла ' + file_name);
  end
  else ShowMessage('Файл не существует!');
end;
end;

procedure TFMain.DeleteParamsEditingDone(Sender: TObject); {метод для изменения тектовой подсказки в поле ввода при изменении параметра удаления}
begin
  if DeleteParams.ItemIndex = 1 then SurnameToDelete.TextHint := 'Введите год рождения'
  else SurnameToDelete.TextHint := 'Введите фамилию';
end;

procedure TFMain.FileSearchButtonClick(Sender: TObject);{метод нажатия кнопки для поиска файлов}
var count: longint =0;     {счётчик найденных файлов}
  Info : tsearchrec;    {результат поиска}
  param, folder, wh : string; {вводимый параметр файла (имя или расширение), папка (путь), тип найденного объекта (файл или папка)}
begin
  wh := '(file)';
  ResultofSearchFile.Clear;
  param := FileInfoSearch.Text;
  folder := FolderFileSearch.Text;
  if FileSearchParams.ItemIndex = 0 then
  begin
  if FindFirst (folder + '\' + param + '*' + '.' + '*?',faAnyFile,Info)=0 then
    begin
    Repeat
      Inc(Count);
      With Info do
        begin
        if (Attr and faDirectory) = faDirectory then
          wh := '(Dir)'
        else wh := '(file)';
        ResultofSearchFile.Items.Add(Name + '                    ' + 'size:  ' + InttoStr(Size) + '  bytes                    ' + wh );
        end;
    Until FindNext(info)<>0;
    ResultofSearchFile.Items.Add('Найдено:  ' + IntToStr(count) + '  файла(ов)');
    FindClose(Info);
    end
  else  ResultofSearchFile.Items.Add('Похоже, ничего не найдено...');
  end
  else begin
    if FindFirst (folder + '\' + '*' + '.' + param + '*',faAnyFile,Info)=0 then
    begin
    Repeat
      Inc(Count);
      With Info do
        begin
        if (Attr and faDirectory) = faDirectory then
          wh := '(Dir)'
        else wh := '(file)';
        ResultofSearchFile.Items.Add(Name + '                    ' + 'size:  ' + InttoStr(Size) + '  bytes                    ' + wh );
        end;
    Until FindNext(info)<>0;
    ResultofSearchFile.Items.Add('Найдено:  ' + IntToStr(count) + '  файла(ов)');
    FindClose(Info);
    end
     else ResultofSearchFile.Items.Add('Похоже, ничего не найдено...');
  end;

end;

procedure TFMain.FileSearchParamsEditingDone(Sender: TObject); {метод для изменения текстовой подсказки в поле ввода при изменении параметра поиска файла}
begin
  if (FileSearchParams.ItemIndex = 0) then FileInfoSearch.TextHint := 'Введите имя файла'
  else FileInfoSearch.TextHint := 'Введите расширение <!без точки!>' ;
end;

procedure TFMain.MenuAddClick(Sender: TObject);  {метод нажатия кнопки подменю "работа с файлом"->"добавление компонент"}
begin                     {меняет видимость групп объектов для перехода к текущей задаче}
  DataInsert.Visible := True;
  startflag := False;
  Operations.ItemIndex := 1;
  FileOperationsSearchBox.Visible := False;
  DeleteFileBox.Visible := False;
  RenameFileBox.Visible := False;
  DeleteComponentBox.Visible:= False;
end;

procedure TFMain.MenuAgeClick(Sender: TObject);{метод нажатия кнопки подменю "работа с файлом" ->"поиск" -> "по возрасту" }
begin                     {меняет видимость групп объектов для перехода к текущей задаче}
  AgeSearchEdit.TextHint := 'Введите возраст';
  SearchParams.ItemIndex := 0;
  Operations.ItemIndex := 0;
  FileOperationsSearchBox.Visible := True;
  AgeSearchEdit.Visible := True;
  Sex1.Visible := False;
  DeleteFileBox.Visible := False;
  DataInsert.Visible := False;
  RenameFileBox.Visible := False;
end;

procedure TFMain.MenuDeleteFileClick(Sender: TObject);{метод нажатия кнопки подменю "работа с файлом" -> "удаление файла" }
begin               {меняет видимость групп объектов для перехода к текущей задаче}
  Operations.ItemIndex := 4;
  DeleteFileBox.Visible := True;
  FileOperationsSearchBox.Visible := False;
  DataInsert.Visible := False;
  DeleteComponentBox.VIsible := False;
  RenameFileBox.Visible := False;
end;

procedure TFMain.MenuExistCheckClick(Sender: TObject); {метод нажатия кнопки меню "проверка сущ. файла"}
begin                   {меняет видимость групп объектов для перехода к текущей задаче}
  FileCreation.Visible := False;
  DataInsert.Visible := False;
  FileExistCheckBox.Visible := True;
  FileContentsBox.Visible := False;
  TextFileBox.Visible := False;
  FileOperationsBox.Visible := False;
  FileSearchBox.Visible := False;
end;

procedure TFMain.MenuExitClick(Sender: TObject);  {метод нажатия кнопки меню "выход"}
begin         {осуществляет выход из приложения}
  close;
end;

procedure TFMain.MenuFileContentsClick(Sender: TObject);  {метод нажатия кнопки меню "просмотр содержимого файла"}
begin              {меняет видимость групп объектов для перехода к текущей задаче}
  FileCreation.Visible := False;
  DataInsert.Visible := False;
  FileExistCheckBox.Visible := False;
  FileContentsBox.Visible := True;
  TextFileBox.Visible := False;
  FileOperationsBox.Visible := False;
  FileSearchBox.Visible := False;
end;

procedure TFMain.MenuFileOperationsClick(Sender: TObject); {метод нажатия кнопки меню "работа с файлом"}
begin                {меняет видимость групп объектов для перехода к текущей задаче}
  startflag := False;          {теперь при добавлении элементов работаем не с новосозданным файлом, а указанным вручную}
  FileOperationsBox.Visible := True;
  FileExistCheckBox.Visible := False;
  FileCreation.Visible := False;
  DataInsert.Visible := False;
  FileContentsBox.Visible := False;
  TextFileBox.Visible := False;
  FileSearchBox.Visible := False;
end;

procedure TFMain.MenuInsertClick(Sender: TObject); {метод нажатия кнопки меню "ввод данных"}
begin                {меняет видимость групп объектов для перехода к текущей задаче}
  startflag := True;    {теперь при добавлении элементов работаем с новосозданным файлом}
  FileExistCheckBox.Visible := False;
  FileCreation.Visible := True;
  DataInsert.Visible := True;
  FileContentsBox.Visible := False;
  TextFileBox.Visible := False;
  FileOperationsBox.Visible := False;
  FileSearchBox.Visible := False;
end;

procedure TFMain.MenuJobClick(Sender: TObject); {метод нажатия кнопки подменю "работа с файлом" ->"поиск" -> "по профессии" }
begin            {меняет видимость групп объектов для перехода к текущей задаче}
  AgeSearchEdit.TextHint := 'Введите профессию';
  SearchParams.ItemIndex := 2;
  Operations.ItemIndex := 0;
  FileOperationsSearchBox.Visible := True;
  AgeSearchEdit.Visible := True;
  Sex1.Visible := False;
  DeleteFileBox.Visible := False;
  RenameFileBox.Visible := False;
end;

procedure TFMain.MenuProgInfoClick(Sender: TObject); {метод нажатия кнопки меню "информация о программе"}
begin         {показывает сообщение с краткой информацией о программе}
  Showmessage('Лабораторная работа №1. Выполнил Шаманов И.П., вар. №25, группа ФН2-21Б. Условия см. в отчёте.');
end;

procedure TFMain.MenuRenameClick(Sender: TObject); {метод нажатия кнопки подменю "работа с файлом" ->"переименовать"}
begin         {меняет видимость групп объектов для перехода к текущей задаче}
  RenameFileBox.Visible := True;
  Operations.ItemIndex := 3;
  DeleteFileBox.Visible := False;
  FileOperationsSearchBox.Visible := False;
  DataInsert.Visible := False;
  DeleteComponentBox.VIsible := False;
end;

procedure TFMain.MenuRetiredClick(Sender: TObject); {метод нажатия кнопки подменю "работа с файлом" -> "удаление компонент" -> "всех пенсионеров" }
begin       {меняет видимость групп объектов для перехода к текущей задаче}
  DeleteParams.ItemIndex := 1;
  DeleteComponentBox.Visible := True;
  FileOperationsSearchBox.Visible := False;
  DataInsert.Visible := False;
  SurnameToDelete.TextHint := 'Введите год рождения';
  Operations.ItemIndex := 2;
  DeleteFileBox.Visible := False;
  RenameFileBox.Visible := False;
end;

procedure TFMain.MenuSearchFileBYNameClick(Sender: TObject);  {метод нажатия кнопки подменю "поиск файлов" -> "по имени"}
begin            {изменяет параметр поиска (для tComboBox) и подсказку текстового поля ввода}
  FileSearchParams.ItemIndex := 0;
  FileInfoSearch.TextHint := 'Введите имя файла';
end;

procedure TFMain.MenuSearchFileClick(Sender: TObject);{метод нажатия кнопки меню "поиск файлов"}
begin       {меняет видимость групп объектов для перехода к текущей задаче}
  DataInsert.Visible := False;
  FileCreation.Visible := False;
  FileExistCheckBox.Visible := False;
  FileContentsBox.Visible := False;
  TextFileBox.Visible := False;
  FileOperationsBox.Visible := False;
  FileSearchBox.Visible := True;
end;

procedure TFMain.MenuSexClick(Sender: TObject); {метод нажатия кнопки подменю "работа с файлом" ->"поиск" -> "по полу" }
begin           {меняет видимость групп объектов для перехода к текущей задаче}
  SearchParams.ItemIndex := 1;
  Operations.ItemIndex := 0;
  FileOperationsSearchBox.Visible := True;
  Sex1.Visible := True;
  AgeSearchEdit.Visible := False;
  DeleteFileBox.Visible := False;
  RenameFileBox.Visible := False;
end;

procedure TFMain.MenuSurnameClick(Sender: TObject); {метод нажатия кнопки подменю "работа с файлом" -> "удаление компонент" -> "по фамилии" }
begin          {меняет видимость групп объектов для перехода к текущей задаче}
  DeleteParams.ItemIndex := 0;
  DeleteComponentBox.Visible := True;
  FileOperationsSearchBox.Visible := False;
  DataInsert.Visible := False;
  SurnameToDelete.TextHint := 'Введите фамилию';
  Operations.ItemIndex := 2;
  DeleteFileBox.Visible := False;
end;

procedure TFMain.MenuTextFile1CrtClick(Sender: TObject); {метод нажатия кнопки подменю "текстовый файл" -> "создать 1-й текстовый файл"}
begin        {меняет видимость групп объектов для перехода к текущей задаче}
  TextFileBox.Visible := True;
  FileExistCheckBox.Visible := False;
  FileCreation.Visible := False;
  DataInsert.Visible := False;
  FileContentsBox.Visible := False;
  FileOperationsBox.Visible := False;
  FileSearchBox.Visible := False;
end;

procedure TFMain.MenuTextFile2CrtClick(Sender: TObject);{метод нажатия кнопки подменю "текстовый файл" -> "создать 2-й текстовый файл"}
begin    {меняет видимость групп объектов для перехода к текущей задаче}
  TextFileBox.Visible := True;
  FileExistCheckBox.Visible := False;
  FileCreation.Visible := False;
  DataInsert.Visible := False;
  FileContentsBox.Visible := False;
  TextFileButton2.Visible := True;
  TextFileName2.Visible := True;
  FileOperationsBox.Visible := False;
  FileSearchBox.Visible := False;
end;

procedure TFMain.MenuSearchFileBYExtsnClick(Sender: TObject);   {метод нажатия кнопки подменю "поиск файлов" -> "по расширению"}
begin             {метод для изменения текстовой подсказки в поле ввода при изменении параметра поиска файла}
  FileSearchParams.ItemIndex := 1;
  FileInfoSearch.TextHint := 'Введите расширение <!без точки!>';
end;

procedure TFMain.OperationsEditingDone(Sender: TObject);{метод завершения выбора действия с файлом}
begin        {меняет видимость групп объектов для перехода к текущей задаче}
  if (Operations.ItemIndex = 0) then FileOperationsSearchBox.Visible := True
  else FileOperationsSearchBox.Visible := False;
  if (Operations.ItemIndex = 1) then DataInsert.Visible := True
  else DataInsert.Visible := False;
  if (Operations.ItemIndex = 2) then DeleteComponentBox.Visible := True
  else  DeleteComponentBox.Visible := False;
  if (Operations.ItemIndex = 3) then RenameFileBox.Visible := True
  else  RenameFileBox.Visible := False;
  if (Operations.ItemIndex = 4) then DeleteFileBox.Visible := True
  else  DeleteFileBox.Visible := False;
end;

procedure TFMain.RenameFileButtonClick(Sender: TObject);  {метод нажатия кнопки для переименовывания файла}
var
  Reply, BoxStyle: integer;   {значения для параметров метода Application.MessageBox()}
  file_folder, file_name, new_name : string; {имя папки, имя файла, новое имя}
begin
  file_name := FileNameSearchEdit.Text;
  file_folder := FolderNameSearch.Text;
  new_name := NameToRename.Text;
  BoxStyle := 1;
  Reply := Application.MessageBox('Вы действительно хотите переименовать данный файл?', 'Подтвердите действие', BoxStyle);
  if Reply = 1 then
  begin
  if FileExists('D:\BMSTU\Информатика\VisualFeatures\' + file_folder + '\' + file_name ) then
  begin
     if renamefile('D:\BMSTU\Информатика\VisualFeatures\' + file_folder + '\' + file_name, 'D:\BMSTU\Информатика\VisualFeatures\' + file_folder + '\' + new_name ) then
     ShowMessage('Файл ' + file_name + ' успешно переименован в ' + new_name + '!')
     else ShowMessage('Возникла ошибка при переименовании файла ' + file_name);
  end
  else ShowMessage('Файл не существует!');
end;

end;

procedure TFMain.SearchButtonClick(Sender: TObject);   {метод нажатия кнопки для поиска компонент  файла}
var file_name, file_folder, Ext, s1, job : string;  {имя файла, папка, расширение, вспомогательная строка (для вывода года рождения), название профессии}
  sex_ : tSex;  {пол}
  ff : file of tSlug; {файловая переменная}
  elem : tSlug;   {переменная для чтения и записи из типизированного файла}
  age : word;  {возраст}
  anyresult : boolean = False; {флаг пустого результата}
begin
  file_name := FileNameSearchEdit.Text;
  file_folder := FolderNameSearch.Text;
  SearchResultMemo.Text := '';
  if FileExists('D:\BMSTU\Информатика\VisualFeatures\' + file_folder + '\' + file_name ) then
  begin
    Ext := ExtractFileExt('D:\BMSTU\Информатика\VisualFeatures\' + file_folder + file_name);
    if Ext = '.txt' then
    begin
      SearchResultMemo.Text := 'Это файл, не содержащий персональную информацию по служащим. Пожалуйста, выберите другой файл.';
    end
    else
    begin
    assignfile(ff, 'D:\BMSTU\Информатика\VisualFeatures\' + file_folder + '\' + file_name);
    reset(ff);
    if (SearchParams.ItemIndex = 0) then begin     {поиск по возрасту}
    age := StrToInt(AgeSearchEdit.Text);
    SearchResultMemo.Text := SearchResultMemo.Text + 'Результаты поиска по запросу: возраст, ' + IntToStr(age) + #13#10;
    SearchResultMemo.Text := SearchResultMemo.Text + '---------------------' + #13#10;
    while not(eof(ff)) do
     begin
         read(ff, elem);
         with elem do begin
         if ((2022 - date) = age) then begin
         anyresult := True;
             str(date, s1);
             SearchResultMemo.Text := SearchResultMemo.Text + fam+ ' ' + nam + ' '+ s1 + ' ' + IntToStr(dolgn.telef) + #13#10 ;
                      end;
     end;
     end;
    end;
    if (SearchParams.ItemIndex = 1) then begin   {поиск по полу}
    if (Sex1.ItemIndex = 0) or (Sex1.ItemIndex = 1) then
    begin
    sex_ := tSex(Sex1.ItemIndex);
    SearchResultMemo.Text := SearchResultMemo.Text + 'Результаты поиска по запросу: пол, ' + gender[sex_] + #13#10;
    SearchResultMemo.Text := SearchResultMemo.Text + '---------------------' + #13#10;
    while not(eof(ff)) do
     begin
         read(ff, elem);
         with elem do begin
         if (sex_ = sex) then begin
             anyresult := True;
             str(date, s1);
             SearchResultMemo.Text := SearchResultMemo.Text + fam+ ' ' + nam + ' '+ s1 + ' ' + gender[sex] + ' ' + IntToStr(dolgn.telef) + #13#10 ;
                      end;
     end;
     end;
    end
    else showmessage('Введите параметр пола!');
    end;
    if (SearchParams.ItemIndex = 2) then begin   {поиск по профессии}
    job := AgeSearchEdit.Text;
    SearchResultMemo.Text := SearchResultMemo.Text + 'Результаты поиска по запросу: профессия, ' + job + #13#10;
    SearchResultMemo.Text := SearchResultMemo.Text + '---------------------' + #13#10;
    while not(eof(ff)) do
     begin
         read(ff, elem);
         with elem do begin
         if (LowerCase(job) = LowerCase(dolgn.prof.name)) then begin
             anyresult := True;
             str(date, s1);
             SearchResultMemo.Text := SearchResultMemo.Text + fam+ ' ' + nam + ' '+ s1 + ' ' + dolgn.prof.name + ' ' + IntToStr(dolgn.telef) + #13#10 ;
                      end;
     end;
     end;
    end;
    if (SearchParams.ItemIndex <> 0) and (SearchParams.ItemIndex <> 1) and (SearchParams.ItemIndex <> 2) then showmessage('Выберите параметр!');
    closefile(ff);
    end;
    if not(anyresult) then  SearchResultMemo.Text := 'Похоже, что по вашему запросу ничего не найдено...';
  end
  else ShowMessage('Файл в указанном пути не сущетвует!');
end;

procedure TFMain.SearchParamsEditingDone(Sender: TObject);  {метод завершения выбора параметра поиска}
begin         {меняет видимость групп объектов для перехода к текущей задаче, текстовые подсказки}
  if (SearchParams.ItemIndex = 0) or (SearchParams.ItemIndex = 2) then begin
  AgeSearchEdit.Visible := True;
  AgeSearchEdit.TextHint := 'Введите возраст';
  end
  else AgeSearchEdit.Visible := False;
  if (SearchParams.ItemIndex = 2) then AgeSearchEdit.TextHint := 'Введите профессию';
  if (SearchParams.ItemIndex = 1) then Sex1.Visible := True
  else Sex1.Visible := False;
end;


procedure TFMain.TextFileButton1Click(Sender: TObject); {метод нажатия кнопки добавления информации о служащем (дохода, премии, налога) из типизированного файла в 1-й текстовый}
var txt:textfile;  {переменная текстового файла}
  ff : file of tSlug;   {переменная файла записей}
    elem : tSlug;    {переменная для чтения и записи из типизированного файла}
   name_of_file, directory_name, Tname_of_typed_file, Tdirectory_name, s1, s2, s3 : string; {имя текст. файла, новая папка, имя тип. файла, имя папки тип. файла, вспомогательные строки}
   FT : TFloatFormat; {переменная формата вещественных чисел для функции FloatToStrF()}
begin
  FT := ffgeneral;
  Tdirectory_name := TypedFolder.Text;
  Tname_of_typed_file := TypedName.Text;
  if FileExists('D:\BMSTU\Информатика\VisualFeatures\' + Tdirectory_name + '\' + Tname_of_typed_file ) then
  begin
  name_of_file := TextFileName1.Text;
  directory_name :=  TextFileFolder.Text;
  CreateDir(directory_name);
  assignfile(txt, directory_name + '\' + name_of_file + '.txt');
  rewrite(txt);
  assignfile(ff, 'D:\BMSTU\Информатика\VisualFeatures\' + Tdirectory_name + '\' + Tname_of_typed_file);
  reset(ff);
  while not(eof(ff)) do
  begin
      read(ff, elem);
      str(elem.dolgn.prof.doxod.osn, s1);
      str(elem.dolgn.prof.doxod.premiya, s2);
      s3 := FloatToStrf(elem.dolgn.prof.doxod.nalog, FT, 10, 2);
      write(txt, s1 + ' ' + s2 + ' ' + s3);
      writeln(txt);
  end;
  closefile(ff);
  closefile(txt);
  TextFileButton2.Visible := True;
  TextFileName2.Visible := True;
  end
  else ShowMessage('Указанного типизированного Файла не существует!');
end;

procedure TFMain.TextFileButton2Click(Sender: TObject);  {метод нажатия кнопки добавления суммарного дохода, дохода, премии, налога из 1-го текстового файла во 2-й текстовый}
var txt1, txt2:textfile;   {переменные текстового файла}
   name_of_file, directory_name, s, temp : string; {имя файла, папка, вспомогательная строка 1, вспомогательная строка 2}
   total : extended =0;   {суммарный доход}
   fs1, fs2: TFormatSettings;  {настройки формата вещественных чисел: десятичный разделитель (точка и запятая)}
   TextContent: TStringList;   {объект: лист строк для ввода информации}
   count : integer =0;        {подсчёт числа строк}
   i : byte;      {переменная для цикла с параметром}
   FT : TFloatFormat;     {переменная формата вещественных чисел для функции FloatToStrF()}
begin
   FT:= ffgeneral;
   fs1 := FormatSettings;
   fs1.DecimalSeparator := '.';
   fs2 := FormatSettings;
   fs1.DecimalSeparator := ',';
   name_of_file := TextFileName1.Text;   {существующий 1-й файл}
   directory_name :=  TextFileFolder.Text;
   if FileExists('D:\BMSTU\Информатика\VisualFeatures\' + directory_name + '\' + name_of_file + '.txt')
   then begin
   assignfile(txt1, directory_name + '\' + name_of_file + '.txt');
   reset(txt1);
   assignfile(txt2, directory_name + '\' + TextFileName2.Text + '.txt');
   rewrite(txt2);
   TextContent := TStringList.Create;
   TextContent.LoadFromFile(directory_name + '\' + name_of_file + '.txt');
   while not(eof(txt1)) do
   begin
       temp := '';
       readln(txt1, s);
       for i := 1 to length(s) do
       begin
          if (s[i] <> ' ')  then temp:= temp + s[i]
          else
            begin
            if (temp <> ' ') or (temp <> '') then
            total := total + StrToFloat(temp, fs1) ;
            temp := '';
            end;
       end;
       if (temp <> ' ') and (temp <> '')  then
       total := total - StrToFloat(temp, fs2) ;    {вычет налога}
       write(txt2, FloatToStrf(total, FT, 10, 2) + ' ');
       write(txt2, TextContent[count]);
       writeln(txt2);
       inc(count);
       total := 0;
   end;
   closefile(txt2);
   closefile(txt1);
   end
   else ShowMessage('Сначала создайте 1-й текстовый файл!');
end;

procedure TFMain.ViewButtonClick(Sender: TObject);   {метод нажатия кнопки просмотра содержимого файла}
var name_of_typed_file, directory_name, s1, s2, s3, s4, s5, Ext : string; {имя файла, папка, 5 вспомогательных строк}
    TextContents: TStringList;    {объект: лист строк для вывода информации}
    ff : file of tSlug;    {файловая переменная}
    elem : tSlug;    {переменная для чтения и записи из типизированного файла}
begin
  ContentsView.Text := '';
  name_of_typed_file := FileNameView.Text;
  directory_name :=  FileDirectoryView.Text;
  if FileExists('D:\BMSTU\Информатика\VisualFeatures\' + directory_name + '\' + name_of_typed_file ) then
  begin
    Ext := ExtractFileExt('D:\BMSTU\Информатика\VisualFeatures\' + directory_name+name_of_typed_file);
    if Ext = '.txt' then
    begin
      TextContents:=TStringList.Create;
      TextContents.LoadFromFile(directory_name + '\' + name_of_typed_file);
      ContentsView.Lines.Assign(TextContents);
    end
    else
    begin
    assignfile(ff, 'D:\BMSTU\Информатика\VisualFeatures\' + directory_name + '\' + name_of_typed_file);
    reset(ff);
    while not(eof(ff)) do
     begin
         read(ff, elem);
         with elem do begin
             str(date, s1); str(dolgn.prof.stag, s2); str(dolgn.prof.doxod.osn, s3);
             str(dolgn.prof.doxod.premiya, s4); str(dolgn.prof.doxod.nalog:10:2, s5);
             ContentsView.Text := ContentsView.Text + nam+ ' ' + fam + ' '+ s1 + ' '+ gender[sex] + ' '+ dolgn.prof.name + ' '+ s2 + ' '+ s3 + ' '+ s4 + ' '+  s5 + ' '+  IntToStr(dolgn.telef) + #13#10 ;
                      end;
     end;
    closefile(ff);
    end;
  end
  else ShowMessage('Файл в указанном пути не сущетвует!');

end;

end.


