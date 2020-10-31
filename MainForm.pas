unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.IOUtils,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Layouts, FMX.TabControl, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Memo, FMX.ListBox, IdHTTP, FMX.Platform,
  System.Permissions, IdBaseComponent, IdComponent, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent;

type
  TForm1 = class(TForm)
    TabControl1: TTabControl;
    ExtraireTab: TTabItem;
    Layout1: TLayout;
    ExtraireButton: TButton;
    SaveDialog1: TSaveDialog;
    ComboBox1: TComboBox;
    Layout6: TLayout;
    GenererTab: TTabItem;
    TabControl2: TTabControl;
    GenR1Nord: TTabItem;
    GenR1Sud: TTabItem;
    GenR2Nord: TTabItem;
    GenR2Sud: TTabItem;
    Layout7: TLayout;
    GenButtonR1Nord: TButton;
    Layout8: TLayout;
    GenButtonR1Sud: TButton;
    Layout9: TLayout;
    GenButtonR2Nord: TButton;
    Layout10: TLayout;
    GenButtonR2Sud: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    VisualizeTab: TTabItem;
    TabControl3: TTabControl;
    ImR1Sud: TTabItem;
    Image2: TImage;
    Layout3: TLayout;
    SaveButtonR1Sud: TButton;
    ImR2Nord: TTabItem;
    Image3: TImage;
    Layout4: TLayout;
    SaveButtonR2Nord: TButton;
    ImR2Sud: TTabItem;
    Image4: TImage;
    Layout5: TLayout;
    SaveButtonR2Sud: TButton;
    ImR1Nord: TTabItem;
    Image1: TImage;
    Layout2: TLayout;
    SaveButtonR1Nord: TButton;
    Layout11: TLayout;
    NetHTTPClient1: TNetHTTPClient;
    procedure ExtraireButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SaveButtonR1NordClick(Sender: TObject);
    procedure GenButtonR1NordClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private const
    PermissionWrite = 'android.permission.WRITE_EXTERNAL_STORAGE';
  private
    typ: string;
    function RecoverChamp(champ: string; typ: string): TstringList;
{$IFDEF ANDROID}
    procedure AccessWritePermissionRequestResult(Sender: TObject;
      const APermissions: TArray<string>;
      const AGrantResults: TArray<TPermissionStatus>);
    procedure DisplayRationale(Sender: TObject;
      const APermissions: TArray<string>; const APostRationaleProc: TProc);
{$ENDIF}
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

uses FMX.DialogService;

procedure TForm1.ExtraireButtonClick(Sender: TObject);
var
  c: integer;
  ts: TstringList;
  l: integer;
begin

  for c := 1 to 4 do
  begin
    if c = 1 then
    begin
      ts := RecoverChamp('R&eacute;gionale 1 - Nord', ComboBox1.Selected.Text);
      Memo1.Lines.Clear;
      for l := 0 to ts.Count - 1 do
        Memo1.Lines.Add(ts.Strings[l]);
    end
    else if c = 2 then
    begin
      ts := RecoverChamp('R&eacute;gionale 1 - Sud', ComboBox1.Selected.Text);
      Memo2.Lines.Clear;
      for l := 0 to ts.Count - 1 do
        Memo2.Lines.Add(ts.Strings[l]);
    end
    else if c = 3 then
    begin
      ts := RecoverChamp('R&eacute;gionale 2 - Nord', ComboBox1.Selected.Text);
      Memo3.Lines.Clear;
      for l := 0 to ts.Count - 1 do
        Memo3.Lines.Add(ts.Strings[l]);
    end
    else if c = 4 then
    begin
      ts := RecoverChamp('R&eacute;gionale 2 - Sud', ComboBox1.Selected.Text);
      Memo4.Lines.Clear;
      for l := 0 to ts.Count - 1 do
        Memo4.Lines.Add(ts.Strings[l]);
    end;

  end;

  TabControl1.ActiveTab := GenererTab;
  TabControl2.ActiveTab := GenR1Nord;

  self.typ := ComboBox1.Selected.Text;

end;

procedure TForm1.SaveButtonR1NordClick(Sender: TObject);
var
  bmp: TBitmap;
  s: string;
  date: TDate;
begin
{$IFDEF ANDROID}
  TDirectory.CreateDirectory(System.IOUtils.TPath.GetSharedPicturesPath + '/FamfootInsta');

  if self.typ = 'Agenda' then
    s := System.IOUtils.TPath.GetSharedPicturesPath + '/FamfootInsta/agenda.png'
  else
    s := System.IOUtils.TPath.GetSharedPicturesPath + '/FamfootInsta/resultats.png';

  date := Now();
  bmp := Image1.MakeScreenshot;
  s := s.Replace('.png', '_R1Nord_' + DateToStr(date).Replace('/', '-')
    + '.png');
  bmp.SaveToFile(s);
  bmp.Free;

  if self.typ = 'Agenda' then
    s := System.IOUtils.TPath.GetSharedPicturesPath + '/FamfootInsta/agenda.png'
  else
    s := System.IOUtils.TPath.GetSharedPicturesPath + '/FamfootInsta/resultats.png';

  bmp := Image2.MakeScreenshot;
  s := s.Replace('.png', '_R1Sud_' + DateToStr(date).Replace('/', '-')
    + '.png');
  bmp.SaveToFile(s);
  bmp.Free;

  if self.typ = 'Agenda' then
    s := System.IOUtils.TPath.GetSharedPicturesPath + '/FamfootInsta/agenda.png'
  else
    s := System.IOUtils.TPath.GetSharedPicturesPath + '/FamfootInsta/resultats.png';

  bmp := Image3.MakeScreenshot;
  s := s.Replace('.png', '_R2Nord_' + DateToStr(date).Replace('/', '-')
    + '.png');
  bmp.SaveToFile(s);
  bmp.Free;

  if self.typ = 'Agenda' then
    s := System.IOUtils.TPath.GetSharedPicturesPath + '/FamfootInsta/agenda.png'
  else
    s := System.IOUtils.TPath.GetSharedPicturesPath + '/FamfootInsta/resultats.png';

  bmp := Image4.MakeScreenshot;
  s := s.Replace('.png', '_R2Sud_' + DateToStr(date).Replace('/', '-')
    + '.png');
  bmp.SaveToFile(s);
  bmp.Free;

{$ELSE}
  if self.typ = 'Agenda' then
    SaveDialog1.Filename := System.IOUtils.TPath.GetDocumentsPath +
      '\agenda.png'
  else
    SaveDialog1.Filename := System.IOUtils.TPath.GetDocumentsPath +
      '\résultats.png';
  if SaveDialog1.Execute then
  begin
    date := Now();

    bmp := Image1.MakeScreenshot;
    s := SaveDialog1.Filename;
    s := s.Replace('.png', '_R1Nord_' + DateToStr(date).Replace('/', '-')
      + '.png');
    bmp.SaveToFile(s);
    bmp.Free;

    bmp := Image2.MakeScreenshot;
    s := SaveDialog1.Filename;
    s := s.Replace('.png', '_R1Sud_' + DateToStr(date).Replace('/', '-')
      + '.png');
    bmp.SaveToFile(s);
    bmp.Free;

    bmp := Image3.MakeScreenshot;
    s := SaveDialog1.Filename;
    s := s.Replace('.png', '_R2Nord_' + DateToStr(date).Replace('/', '-')
      + '.png');
    bmp.SaveToFile(s);
    bmp.Free;

    bmp := Image4.MakeScreenshot;
    s := SaveDialog1.Filename;
    s := s.Replace('.png', '_R2Sud_' + DateToStr(date).Replace('/', '-')
      + '.png');
    bmp.SaveToFile(s);
    bmp.Free;
  end;
{$ENDIF}
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
{$IFDEF ANDROID}
  PermissionsService.RequestPermissions([PermissionWrite],
    AccessWritePermissionRequestResult, DisplayRationale);
{$ENDIF}
end;

{$IFDEF ANDROID}

procedure TForm1.AccessWritePermissionRequestResult(Sender: TObject;
  const APermissions: TArray<string>;
  const AGrantResults: TArray<TPermissionStatus>);
begin
  // 1 permission involved: CAMERA
  if not((Length(AGrantResults) = 1) and
    (AGrantResults[0] = TPermissionStatus.Granted)) then
    TDialogService.ShowMessage
      ('Cannot access the storage because the required permission has not been granted')
end;

procedure TForm1.DisplayRationale(Sender: TObject;
  const APermissions: TArray<string>; const APostRationaleProc: TProc);
begin
  // Show an explanation to the user *asynchronously* - don't block this thread waiting for the user's response!
  // After the user sees the explanation, invoke the post-rationale routine to request the permissions
  TDialogService.ShowMessage
    ('The app needs to access the storage in order to work',
    procedure(const AResult: TModalResult)
    begin
      APostRationaleProc
    end)
end;

{$ENDIF}

procedure TForm1.FormShow(Sender: TObject);
var
  w, h: Single;
begin
  TabControl1.ActiveTab := ExtraireTab;

  w := layout11.Width;
  h := layout11.Height;

  if w < h then
    Image1.Width := w
  else
    Image1.width := h;
  Image1.Height := Image1.Width;

  if w < h then
    Image2.Width := w
  else
    Image2.width := h;
  Image2.Height := Image1.Width;

  if w < h then
    Image3.Width := w
  else
    Image3.width := h;
  Image3.Height := Image1.Width;

  if w < h then
    Image4.Width := w
  else
    Image4.width := h;
  Image4.Height := Image1.Width;

end;

procedure TForm1.GenButtonR1NordClick(Sender: TObject);
var
  champ, date, match: string;
  i, j, k, c, nbdates, nbmatchs, id, im: integer;
  LabelTitre: TLabel;
  LabelDateTab: array of TLabel;
  LabelMatchTab: array of TLabel;
  policetop, policedate, policematch: integer;
  heighttop, heightdate, heightmatch: integer;
  ts: TstringList;
  Image: TImage;
  l: integer;
begin

{$IFDEF ANDROID}

  policetop := 18;
  policedate := 16;
  policematch := 16;

  heighttop := 80;
  heightdate := 25;
  heightmatch := 25;

{$ELSE}

  policetop := 28;
  policedate := 26;
  policematch := 26;

  heighttop := 130;
  heightdate := 40;
  heightmatch := 40;

{$ENDIF}

  for i := Image1.ChildrenCount - 1 downto 0 do
  begin
//    Image1.Children.Items[i].Free;
      Image1.RemoveObject(Image1.Children.Items[i]);
  end;

  for i := Image2.ChildrenCount - 1 downto 0 do
  begin
//    Image2.Children.Items[i].Free;
    Image2.RemoveObject(Image2.Children.Items[i]);
  end;

  for i := Image3.ChildrenCount - 1 downto 0 do
  begin
    Image3.RemoveObject(Image3.Children.Items[i]);
//    Image3.Children.Items[i].Free;
  end;

  for i := Image4.ChildrenCount - 1 downto 0 do
  begin
    Image4.RemoveObject(Image4.Children.Items[i]);
//    Image4.Children.Items[i].Free;
  end;

  ts := TstringList.Create;

  for c := 1 to 4 do
  begin
    if c = 1 then
    begin
      ts.Clear;
      for l := 0 to Memo1.Lines.Count - 1 do
        ts.Add(Memo1.Lines.Strings[l].Replace('&eacute;', 'é'));
      Image := Image1;
    end
    else if c = 2 then
    begin
      ts.Clear;
      for l := 0 to Memo2.Lines.Count - 1 do
        ts.Add(Memo2.Lines.Strings[l].Replace('&eacute;', 'é'));
      Image := Image2;
    end
    else if c = 3 then
    begin
      ts.Clear;
      for l := 0 to Memo3.Lines.Count - 1 do
        ts.Add(Memo3.Lines.Strings[l].Replace('&eacute;', 'é'));
      Image := Image3;
    end
    else if c = 4 then
    begin
      ts.Clear;
      for l := 0 to Memo4.Lines.Count - 1 do
        ts.Add(Memo4.Lines.Strings[l].Replace('&eacute;', 'é'));
      Image := Image4;
    end;

    i := Pos('<strong><span style="color:#3399cb;">', ts.Strings[0]) +
      Length('<strong><span style="color:#3399cb;">');
    j := Pos('</span></strong><br />', ts.Strings[0]);
    champ := ts.Strings[0].Substring(i - 1, j - i);
    champ := champ.Replace('&eacute;', 'é');

    LabelTitre := TLabel.Create(Image);
    LabelTitre.Parent := Image;
    LabelTitre.Align := TalignLayout.Top;
    LabelTitre.Text := champ;
    LabelTitre.Height := heighttop;
    LabelTitre.StyledSettings := [];
    LabelTitre.TextSettings.Font.Size := policetop;
    LabelTitre.TextSettings.Font.Family := 'Chewy';
    LabelTitre.TextSettings.HorzAlign := TTextAlign.Center;
    LabelTitre.TextSettings.FontColor := TAlphaColor($FFFFBD59);

    nbdates := 0;
    for i := 0 to ts.Count - 1 do
    begin
      if Pos('<em><span style="color:#e6a536;">', ts.Strings[i]) <> 0 then
        nbdates := nbdates + 1;
    end;

    nbmatchs := ts.Count - 1 - nbdates;

    SetLength(LabelDateTab, nbdates);
    SetLength(LabelMatchTab, nbmatchs);

    id := 0;
    im := 0;
    for i := ts.Count - 1 downto 1 do
    begin
      if Pos('<em><span style="color:#e6a536;">', ts.Strings[i]) <> 0 then
      begin
        j := Pos('<em><span style="color:#e6a536;">', ts.Strings[i]) +
          Length('<em><span style="color:#e6a536;">');
        k := Pos('</span></em><br />', ts.Strings[i]);

        date := ts.Strings[i].Substring(j - 1, k - j);

        LabelDateTab[id] := TLabel.Create(Image);
        LabelDateTab[id].Parent := Image;
        LabelDateTab[id].Align := TalignLayout.Top;
        LabelDateTab[id].Text := date;
        LabelDateTab[id].Height := heightdate;
        LabelDateTab[id].Margins.Left := 10;
        LabelDateTab[id].Margins.Top := 5;
        LabelDateTab[id].StyledSettings := [];
        LabelDateTab[id].TextSettings.Font.Size := policedate;
        LabelDateTab[id].TextSettings.Font.Family := 'Chewy';
        LabelDateTab[id].TextSettings.FontColor := TAlphaColor($FF38B6FF);
        id := id + 1;
      end
      else
      begin
        if Pos('<strong>', ts.Strings[i]) <> 0 then
        begin
          j := Pos('<strong>', ts.Strings[i]) + Length('<strong>');
          k := Pos('</strong>', ts.Strings[i]);

          match := ts.Strings[i].Substring(j - 1, k - j);
        end
        else
        begin
          j := 0;
          k := Pos('<br />', ts.Strings[i]);
          match := ts.Strings[i].Substring(j, k - j - 1);
        end;

        LabelMatchTab[im] := TLabel.Create(Image);
        LabelMatchTab[im].Parent := Image;
        LabelMatchTab[im].Align := TalignLayout.Top;
        LabelMatchTab[im].Text := match;
        LabelMatchTab[im].Margins.Left := 10;
        LabelMatchTab[im].Height := heightmatch;
        LabelMatchTab[im].StyledSettings := [];
        LabelMatchTab[im].TextSettings.Font.Size := policematch;
        LabelMatchTab[im].TextSettings.Font.Family := 'Chewy';
        LabelMatchTab[im].TextSettings.FontColor := TAlphaColorRec.White;
        im := im + 1;

      end;

    end;
  end;

  ts.Free;

  TabControl1.ActiveTab := VisualizeTab;
  TabControl3.ActiveTab := ImR1Nord;
end;

function TForm1.RecoverChamp(champ: string; typ: string): TstringList;
var
  url, s, res, temp: string;
  p, endp, i: integer;
begin
  if typ = 'Agenda' then
    url := 'https://famfoot.fr/agenda/'
  else
    url := 'https://famfoot.fr/resultats/';

  s := NetHttpClient1.Get(url).ContentAsString;

  p := Pos(champ, s);

  p := p - Length('<strong><span style="color:#3399cb;">');
  endp := Pos('<a href', s, p);
  res := s.Substring(p - 1, endp - p);

  res := res.Replace('</p></strong>', '</strong><br />');
  res := res.Replace('<br />', '<br />|');
  res := res.Replace('MAZERES UZOS RONTIGN', 'ASMUR');
  res := res.Replace('<p style="font-size: small">', '');

  if typ = 'Agenda' then
  begin
    res := res.Replace(' (1ER)', '');
    for i := 2 to 12 do
      res := res.Replace(' (' + IntToStr(i) + 'EME)', '');
  end
  else
  begin
    while Pos('(', res) <> 0 do
    begin
      p := Pos('(', res);
      endp := Pos(')', res);
      temp := res.Substring(0, p - 1);
      temp := temp + res.Substring(endp, Length(res) - endp);
      res := temp;
    end;
  end;

  result := TstringList.Create;

  result.Clear;
  result.Delimiter := '|';
  result.StrictDelimiter := True; // Requires D2006 or newer.
  result.DelimitedText := res;

end;

end.
