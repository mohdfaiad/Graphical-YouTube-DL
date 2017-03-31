unit uGraphicalYouTube;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, DosCommand, uCommands, uCommandCreator, ShellAPI,
  Vcl.ExtDlgs, FileCtrl, WinSvc, uUpdater, wininet, uDownloader, Vcl.Menus, uThemeManager, vcl.themes,
  Vcl.OleCtrls, WMPLib_TLB, uMediaPlayer, Vcl.ToolWin, Vcl.ComCtrls,
  Vcl.JumpList, uIssueReporter;

type
  Tfrmmain = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    mmo1: TMemo;
    dscmnd1: TDosCommand;
    lbl1: TLabel;
    grp1: TGroupBox;
    rbcustom: TRadioButton;
    rbeasy: TRadioButton;
    edtcustom: TEdit;
    edturl: TEdit;
    btndownload: TButton;
    lbl2: TLabel;
    grp2: TGroupBox;
    rbaudio: TRadioButton;
    rbvideo: TRadioButton;
    btn1: TButton;
    btn4: TButton;
    btn5: TButton;
    btn3: TButton;
    lbl5: TLabel;
    mm1: TMainMenu;
    N11: TMenuItem;
    Options1: TMenuItem;
    hemeManager1: TMenuItem;
    Updates1: TMenuItem;
    CheckforUpdates1: TMenuItem;
    StopDownloading1: TMenuItem;
    OpenGithubPage1: TMenuItem;
    Exit1: TMenuItem;
    SetDownloadPath1: TMenuItem;
    Help1: TMenuItem;
    Downloading1: TMenuItem;
    Errors1: TMenuItem;
    Commands1: TMenuItem;
    pmlog: TPopupMenu;
    Clear1: TMenuItem;
    pmform: TPopupMenu;
    hemeManager2: TMenuItem;
    N1: TMenuItem;
    Copy1: TMenuItem;
    pmedturl: TPopupMenu;
    Clear2: TMenuItem;
    N2: TMenuItem;
    Copy2: TMenuItem;
    Cut1: TMenuItem;
    Paste1: TMenuItem;
    pmedtcustom: TPopupMenu;
    Clear3: TMenuItem;
    N3: TMenuItem;
    Copy3: TMenuItem;
    Cut2: TMenuItem;
    Paste2: TMenuItem;
    btn2: TButton;
    Links1: TMenuItem;
    YouTube1: TMenuItem;
    Sound1: TMenuItem;
    VidMe1: TMenuItem;
    btn6: TButton;
    ReportIssue1: TMenuItem;
    procedure rbeasyClick(Sender: TObject);
    procedure rbcustomClick(Sender: TObject);
    procedure btndownloadClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    function IsAdmin(Host : string = '') : Boolean;
    procedure FormActivate(Sender: TObject);
    procedure mmo1Change(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure OpenGithubPage1Click(Sender: TObject);
    procedure Commands1Click(Sender: TObject);
    procedure CheckforUpdates1Click(Sender: TObject);
    procedure StopDownloading1Click(Sender: TObject);
    procedure SetDownloadPath1Click(Sender: TObject);
    procedure hemeManager1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure hemeManager2Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Clear2Click(Sender: TObject);
    procedure Copy2Click(Sender: TObject);
    procedure Cut1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure Clear3Click(Sender: TObject);
    procedure Copy3Click(Sender: TObject);
    procedure Cut2Click(Sender: TObject);
    procedure Paste2Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure YouTube1Click(Sender: TObject);
    procedure Sound1Click(Sender: TObject);
    procedure VidMe1Click(Sender: TObject);
    procedure OpenURL (url : string);
    procedure btn6Click(Sender: TObject);
    procedure ReportIssue1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Private declarations }
    sDownloadPath : string;
    connected : Boolean;
  end;

var
  frmmain: Tfrmmain;

implementation

{$R *.dfm}

procedure Tfrmmain.btn1Click(Sender: TObject);
begin
  dscmnd1.Stop;
  if SelectDirectory('Select a folder to save the video / audio you want to download','',sDownloadPath) then
    ShowMessage('Download path has been set to ' + sDownloadPath);
end;

procedure Tfrmmain.btndownloadClick(Sender: TObject);
begin
  dscmnd1.Stop;
  mmo1.Lines.Clear;

  if rbcustom.Checked then
    begin
      Form2.mmo1.Clear;
      mmo1.Lines.Add('Starting Download...');
      Form2.mmo1.Lines.Add('@echo off');
      Form2.mmo1.Lines.Add('"C:\Program Files (x86)\YouTube-DL\youtube-dl.exe" ' + edtcustom.Text);
      Form2.mmo1.Lines.Add('echo Done Performing custom commands');
      Form2.mmo1.Lines.SaveToFile('C:\Users\Public\Documents\yt-download.bat');

      dscmnd1.CommandLine := 'C:\Users\Public\Documents\yt-download.bat';
      dscmnd1.Execute;
    end;

  if rbeasy.Checked then
    begin
      if rbvideo.Checked then
    begin
      Form2.mmo1.Clear;
      mmo1.Lines.Add('Starting Download...');
      Form2.mmo1.Lines.Add('@echo off');
      Form2.mmo1.Lines.Add('cd ' + sDownloadPath);
      Form2.mmo1.Lines.Add('"C:\Program Files (x86)\YouTube-DL\youtube-dl.exe" --format mp4 ' + edturl.Text);
      Form2.mmo1.Lines.Add('echo Done');
      Form2.mmo1.Lines.SaveToFile('C:\Users\Public\Documents\yt-download.bat');

      dscmnd1.CommandLine := 'C:\Users\Public\Documents\yt-download.bat';
      dscmnd1.Execute;
    end;

  if rbaudio.Checked then
    begin
      Form2.mmo1.Clear;
      mmo1.Lines.Add('Starting Download...');
      Form2.mmo1.Lines.Add('@echo off');
      Form2.mmo1.Lines.Add('cd ' + sDownloadPath);
      Form2.mmo1.Lines.Add('"C:\Program Files (x86)\YouTube-DL\youtube-dl.exe" --extract-audio --audio-format mp3 ' + edturl.Text);
      Form2.mmo1.Lines.Add('echo Done');
      Form2.mmo1.Lines.SaveToFile('C:\Users\Public\Documents\yt-download.bat');

      dscmnd1.CommandLine := 'C:\Users\Public\Documents\yt-download.bat';
      dscmnd1.Execute;
    end;
  end;
end;

procedure Tfrmmain.CheckforUpdates1Click(Sender: TObject);
begin
  if connected = True then
    begin
      if IsAdmin = True then
        begin
          frmupdater.ShowModal;

          if frmupdater.update = True then
            begin
              dscmnd1.Stop;
              mmo1.Clear;
              dscmnd1.CommandLine := 'C:\Users\Public\Documents\yt-update.bat';
              dscmnd1.Execute;
            end;
        end
      else
        ShowMessage('Please run Graphical Youtube-DL as admin!');
    end
  else
    ShowMessage('There does not seem to be an active internet connection. Please check your connection!');
end;

procedure Tfrmmain.Clear1Click(Sender: TObject);
begin
  mmo1.Clear;
end;

procedure Tfrmmain.Clear2Click(Sender: TObject);
begin
  edturl.Clear;
end;

procedure Tfrmmain.Clear3Click(Sender: TObject);
begin
  edtcustom.Clear;
end;

procedure Tfrmmain.Commands1Click(Sender: TObject);
begin
  frmcommands.Show;
end;

procedure Tfrmmain.Copy1Click(Sender: TObject);
begin
  mmo1.CopyToClipboard;
end;

procedure Tfrmmain.Copy2Click(Sender: TObject);
begin
  edturl.CopyToClipboard;
end;

procedure Tfrmmain.Copy3Click(Sender: TObject);
begin
  edtcustom.CopyToClipboard;
end;

procedure Tfrmmain.Cut1Click(Sender: TObject);
begin
  edturl.CutToClipboard;
end;

procedure Tfrmmain.Cut2Click(Sender: TObject);
begin
  edtcustom.CutToClipboard;
end;

procedure Tfrmmain.Exit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure Tfrmmain.btn2Click(Sender: TObject);
begin
  frmmediaplayer.Show;
end;

procedure Tfrmmain.btn3Click(Sender: TObject);
begin
  if MessageDlg('Are you sure you want to stop the download?', mtconfirmation, [mbYes, mbNo], 0) = mrYes then
    dscmnd1.Stop;
end;

procedure Tfrmmain.btn4Click(Sender: TObject);
begin
edturl.Clear;
end;

procedure Tfrmmain.btn5Click(Sender: TObject);
begin
  edtcustom.Clear;
end;

procedure Tfrmmain.btn6Click(Sender: TObject);
begin
//  frmissuereport.ShowModal;
  OpenURL('https://github.com/Inforcer25/Graphical-YouTube-DL/issues');
end;

procedure Tfrmmain.FormActivate(Sender: TObject);
var
  origin : Cardinal;
begin
  connected := InternetGetConnectedState(@origin,0);
end;

procedure Tfrmmain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if MessageDlg('Are you sure you want to exit?', mtconfirmation, [mbYes, mbNo], 0) = mrYes then
    CanClose:= True
  else
    CanClose:= False;
end;

procedure Tfrmmain.FormCreate(Sender: TObject);
begin
  if FileExists('C:\Users\Public\Documents\graphicalyt-theme.txt') then
      begin
        AssignFile(txttheme, 'C:\Users\Public\Documents\graphicalyt-theme.txt');
        Reset(txttheme);
        Readln(txttheme, stylename);
        CloseFile(txttheme);

        TStyleManager.SetStyle(stylename);
      end;
end;

procedure Tfrmmain.FormShow(Sender: TObject);
var
  ffmpeg, ffprobe, youtube : Boolean;
begin
  Application.Title := 'Graphical YouTube-DL';
  mmo1.Lines.Clear;
  dscmnd1.OutputLines := mmo1.Lines;
  sDownloadPath := 'Current Dir';

  if FileExists('C:\Program Files (x86)\YouTube-DL\ffmpeg.exe') then
    mmo1.Lines.Add('ffmpeg.exe FOUND!')
  else
    begin
      mmo1.Lines.Add('ffmpeg.exe NOT FOUND! Please use the YouTube-DL-Installer to fix this issue. The Installer can be found on the github page. Just click "Options > Open Github Page"');
      ShowMessage('ffmpeg.exe is missing. Please use the YouTube-DL-Installer to fix this issue. The Installer can be found on the github page. Just click "Options > Open Github Page"');
      btndownload.Enabled := False;
    end;

  if FileExists('C:\Program Files (x86)\YouTube-DL\ffprobe.exe') then
    mmo1.Lines.Add('ffprobe.exe FOUND!')
  else
    begin
      mmo1.Lines.Add('ffprobe.exe NOT FOUND! Please use the YouTube-DL-Installer to fix this issue. The Installer can be found on the github page. Just click "Options > Open Github Page"');
      ShowMessage('ffprobe.exe is missing. Please use the YouTube-DL-Installer to fix this issue. The Installer can be found on the github page. Just click "Options > Open Github Page"');
      btndownload.Enabled := False;
      ffprobe := False;
    end;

  if FileExists('C:\Program Files (x86)\YouTube-DL\youtube-dl.exe') then
    mmo1.Lines.Add('youtube-dl.exe FOUND!')
  else
    begin
      mmo1.Lines.Add('youtube-dl.exe NOT FOUND! Please use the YouTube-DL-Installer to fix this issue. The Installer can be found on the github page. Just click "Options > Open Github Page"');
      ShowMessage('ffprobe.exe is missing. Please use the YouTube-DL-Installer to fix this issue. The Installer can be found on the github page. Just click "Options > Open Github Page"');
      btndownload.Enabled := False;
    end;

  mmo1.Lines.Add(' ');
  mmo1.Lines.Add('If it keeps failing to download a video please click on the "Updates > Check for updates" button and update youtube-dl.exe');
end;

procedure Tfrmmain.hemeManager1Click(Sender: TObject);
begin
  frmthememanager.ShowModal;
end;

procedure Tfrmmain.hemeManager2Click(Sender: TObject);
begin
  frmthememanager.Show;
end;

function Tfrmmain.IsAdmin(Host: string): Boolean;
var
  H: SC_HANDLE;
begin
  if Win32Platform <> VER_PLATFORM_WIN32_NT then
    Result := True
  else
    begin
      H := OpenSCManager(PChar(Host), nil, SC_MANAGER_ALL_ACCESS);
      Result := H <> 0;
      if Result then
        CloseServiceHandle(H);
    end;
end;

procedure Tfrmmain.mmo1Change(Sender: TObject);
var
  lineNumber: integer;
begin
  for lineNumber := 0 to mmo1.lines.count-1 do
    if Pos( 'Done Downloading Update', mmo1.lines[lineNumber] ) > 0 then
      begin
        if FileExists('C:\Program Files (x86)\YouTube-DL\youtube-dl-updater.bat') then
          ShellExecute(Handle, 'runas', 'C:\Program Files (x86)\YouTube-DL\youtube-dl-updater.bat', nil, nil, SW_SHOWNORMAL);
      end;
end;

procedure Tfrmmain.OpenGithubPage1Click(Sender: TObject);
begin
  OpenURL('https://inforcer25.github.io/Graphical-YouTube-DL/');
end;

procedure Tfrmmain.OpenURL(url: string);
begin
  ShellExecute(self.WindowHandle,'open',PChar(url),nil,nil, SW_SHOWNORMAL);
end;

procedure Tfrmmain.Paste1Click(Sender: TObject);
begin
  edturl.PasteFromClipboard;
end;

procedure Tfrmmain.Paste2Click(Sender: TObject);
begin
  edtcustom.PasteFromClipboard;
end;

procedure Tfrmmain.rbcustomClick(Sender: TObject);
begin
  if rbcustom.Checked then
    begin
      edtcustom.Enabled := True;
      edturl.Enabled := False;
    end;
end;

procedure Tfrmmain.rbeasyClick(Sender: TObject);
begin
  if rbeasy.Checked then
    begin
      edtcustom.Enabled := False;
      edturl.Enabled := True;
    end;
end;

procedure Tfrmmain.ReportIssue1Click(Sender: TObject);
begin
  OpenURL('https://github.com/Inforcer25/Graphical-YouTube-DL/issues');
end;

procedure Tfrmmain.SetDownloadPath1Click(Sender: TObject);
begin
  dscmnd1.Stop;
  if SelectDirectory('Select a folder to save the video / audio you want to download','',sDownloadPath) then
    ShowMessage('Download path has been set to ' + sDownloadPath);
end;

procedure Tfrmmain.Sound1Click(Sender: TObject);
begin
  OpenURL('https://soundcloud.com/stream');
end;

procedure Tfrmmain.StopDownloading1Click(Sender: TObject);
begin
  dscmnd1.Stop;
end;

procedure Tfrmmain.VidMe1Click(Sender: TObject);
begin
  OpenURL('https://vid.me/');
end;

procedure Tfrmmain.YouTube1Click(Sender: TObject);
begin
  OpenURL('https://www.youtube.com/');
end;

end.
