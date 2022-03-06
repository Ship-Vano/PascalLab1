program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Main  {модуль Main отвечает за обработку событий и выполнение основных задач приложения}
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;       {задание стартовых параметров приложения }
  Application.Scaled:=True;               {для корректной работы формы и её элементов}
  Application.Initialize;                 {инициализация приложения}
  Application.CreateForm(TFMain, FMain);  {создание формы}
  Application.Run;                        {запуск приложения}
end.

