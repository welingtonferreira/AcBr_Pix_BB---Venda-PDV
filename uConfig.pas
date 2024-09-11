unit uConfig;
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, ACBrBase, ACBrOpenSSLUtils;
type
  { TPDVConfig }
  TPDVConfig = class
  private
    fArqCertificado: String;
    fArqChavePrivada: String;
    fChavePix: String;
    fCidade: String;
    fClientID: String;
    fClientSecret: String;
    fDeveloperAppKey: String;
    fLogArquivo: String;
    fLogNivel: Integer;
    fRecebedorNome: String;
    function GetNomeArquivoConfig: String;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure LerConfig;
    procedure GravarConfig;
    property NomeArquivoConfig: String read GetNomeArquivoConfig;
    // Log
    property LogNivel: Integer read fLogNivel write fLogNivel;
    property LogArquivo: String read fLogArquivo write fLogArquivo;
    // Recebedor
    property RecebedorNome: String read fRecebedorNome write fRecebedorNome;
    property RecebedorCidade: String read fCidade write fCidade;
    // PSP
    property ChavePix: String read fChavePix write fChavePix;
    property ClientID: String read fClientID write fClientID;
    property ClientSecret: String read fClientSecret write fClientSecret;
    // Banco do Brasil
    property DeveloperAppKey: String read fDeveloperAppKey write fDeveloperAppKey;
    property ArqCertificado: String read fArqCertificado write fArqCertificado;
    property ArqChavePrivada: String read fArqChavePrivada write fArqChavePrivada;
  end;
  { TfrConfig }
  TfrmConfig = class(TForm)
    btCancelar: TSpeedButton;
    btSalvar: TSpeedButton;
    cbLogNivel: TComboBox;
    edLogArquivo: TEdit;
    edBBChavePIX: TEdit;
    edBBClientID: TEdit;
    edBBClientSecret: TEdit;
    edBBDevAppKey: TEdit;
    edRecebedorCidade: TEdit;
    edRecebedorNome: TEdit;
    gbLog: TGroupBox;
    gbPSPBancoDoBrasil: TGroupBox;
    gbRecebedor: TGroupBox;
    lbBBChavePIX: TLabel;
    lbBBClientID: TLabel;
    lbBBClientSecret: TLabel;
    lbBBDevAppKey: TLabel;
    lbLogArquivo: TLabel;
    lbLogNivel: TLabel;
    lbRecebedorCidade: TLabel;
    lbRecebedorNome: TLabel;
    OpenDialog1: TOpenDialog;
    pnRecebedor: TPanel;
    pnLog: TPanel;
    pnConfigHeader: TPanel;
    pnConfigPIX: TPanel;
    pnBancoDoBrasil: TPanel;
    pnRodape: TPanel;
    a: TSpeedButton;
    lbItauArqChavePrivada: TLabel;
    edtArqChavePrivada: TEdit;
    lbItauArqCertificado: TLabel;
    edtArqCertificado: TEdit;
    btArqCertificado: TSpeedButton;
    btArqChavePrivada: TSpeedButton;
    ACBrOpenSSLUtils1: TACBrOpenSSLUtils;
    procedure btCancelarClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btArqChavePrivadaClick(Sender: TObject);
    procedure btArqCertificadoClick(Sender: TObject);
    procedure edtArqChavePrivadaExit(Sender: TObject);
    procedure edtArqCertificadoExit(Sender: TObject);
  private
    fPDVConfig: TPDVConfig;
    function GetPDVConfig: TPDVConfig;
    procedure ValidarCampos;
    function AdicionarPathAplicacao(const AFileName: String): String;
    procedure ValidarChavePSPBB;
    procedure ValidarCertificadoPSPBB;
  public
    property PDVConfig: TPDVConfig read GetPDVConfig;
  end;

var
  frmConfig: TfrmConfig;

implementation

uses
  uPDV, IniFiles, ACBrUtil.Base, ACBrImage, ACBrValidador, ACBrPIXUtil, ACBrConsts,
  ACBrPIXSchemasCobV, OpenSSLExt,
  ACBrJSON,
  ACBrUtil.FilesIO,
  ACBrUtil.Strings,
  ACBrUtil.DateTime,
  ACBrUtil.Compatibilidade;

{$R *.dfm}

{ TPDVConfig }

function TPDVConfig.GetNomeArquivoConfig: String;
begin
  Result := ChangeFileExt(Application.ExeName, '.ini');
end;

constructor TPDVConfig.Create;
begin
  Clear;
end;

destructor TPDVConfig.Destroy;
begin
  inherited Destroy;
end;

procedure TPDVConfig.Clear;
begin
//  fLogNivel := 0;
//  fChavePix := EmptyStr;
//  fCidade := EmptyStr;
//  fClientID := EmptyStr;
//  fClientSecret := EmptyStr;
//  fDeveloperAppKey := EmptyStr;
//  fLogArquivo := EmptyStr;
//  fRecebedorNome := EmptyStr;
//  fArqCertificado := EmptyStr;
//  fArqChavePrivada := EmptyStr;
end;

procedure TPDVConfig.LerConfig;
var
  wIni: TIniFile;
begin
  wIni := TIniFile.Create(NomeArquivoConfig);
  try
    RecebedorNome := wIni.ReadString('Recebedor', 'Nome', '');
    RecebedorCidade := wIni.ReadString('Recebedor', 'Cidade', '');
    LogArquivo := wIni.ReadString('Log', 'Arquivo', '');
    LogNivel := wIni.ReadInteger('Log', 'Nivel', 1);
    // PSP
    ChavePix := wIni.ReadString('PSP', 'ChavePIX', '');
    ClientID := wIni.ReadString('PSP', 'ClientID', '');
    ClientSecret := wIni.ReadString('PSP', 'ClientSecret', '');
    // Banco do Brasil
    DeveloperAppKey := wIni.ReadString('BancoBrasil', 'DeveloperApplicationKey', '');
    ArqCertificado := wIni.ReadString('BancoBrasil', 'ArqCertificado', '');
    ArqChavePrivada := wIni.ReadString('BancoBrasil', 'ArqChavePrivada', '');
  finally
    wIni.Free;
  end;
end;

procedure TPDVConfig.GravarConfig;
var
  wIni: TIniFile;
begin
  wIni := TIniFile.Create(NomeArquivoConfig);
  try
    wIni.WriteString('Recebedor', 'Nome', RecebedorNome);
    wIni.WriteString('Recebedor', 'Cidade', RecebedorCidade);
    wIni.WriteString('Log', 'Arquivo', LogArquivo);
    wIni.WriteInteger('Log', 'Nivel', LogNivel);
    wIni.WriteString('PSP', 'ChavePIX', ChavePix);
    wIni.WriteString('PSP', 'ClientID', ClientID);
    wIni.WriteString('PSP', 'ClientSecret', ClientSecret);
    // Banco do Brasil
    wIni.WriteString('BancoBrasil', 'DeveloperApplicationKey', DeveloperAppKey);
    wIni.WriteString('BancoBrasil', 'ArqCertificado', ArqCertificado);
    wIni.WriteString('BancoBrasil', 'ArqChavePrivada', ArqChavePrivada);
  finally
    wIni.Free;
  end;
end;

{ TfrConfig }
procedure TfrmConfig.btArqCertificadoClick(Sender: TObject);
begin
  OpenDialog1.FileName := edtArqCertificado.Text;
  if OpenDialog1.Execute then
    edtArqCertificado.Text := OpenDialog1.FileName;

  edtArqCertificado.SetFocus;
end;

procedure TfrmConfig.btArqChavePrivadaClick(Sender: TObject);
begin
  OpenDialog1.FileName := edtArqChavePrivada.Text;
  if OpenDialog1.Execute then
    edtArqChavePrivada.Text := OpenDialog1.FileName;

  edtArqChavePrivada.SetFocus;
end;

procedure TfrmConfig.btCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmConfig.btSalvarClick(Sender: TObject);
begin
  ValidarCampos;
  PDVConfig.RecebedorNome := edRecebedorNome.Text;
  PDVConfig.RecebedorCidade := edRecebedorCidade.Text;
  PDVConfig.LogNivel := cbLogNivel.ItemIndex;
  PDVConfig.LogArquivo := edLogArquivo.Text;
  //Banco do Brasil
  PDVConfig.ChavePix := edBBChavePIX.Text;
  PDVConfig.ClientID := edBBClientID.Text;
  PDVConfig.ClientSecret := edBBClientSecret.Text;
  PDVConfig.DeveloperAppKey := edBBDevAppKey.Text;
  PDVConfig.ArqChavePrivada := edtArqChavePrivada.Text;
  PDVConfig.ArqCertificado := edtArqCertificado.Text;
  PDVConfig.GravarConfig;
  ModalResult := mrOK;
end;

procedure TfrmConfig.edtArqCertificadoExit(Sender: TObject);
begin
  if not (edtArqCertificado.Text = EmptyStr) then
    ValidarCertificadoPSPBB;
end;

procedure TfrmConfig.edtArqChavePrivadaExit(Sender: TObject);
begin
  if not (edtArqChavePrivada.Text = EmptyStr) then
  ValidarChavePSPBB;
end;

procedure TfrmConfig.FormDestroy(Sender: TObject);
begin
  if Assigned(fPDVConfig) then
    fPDVConfig.Free;
end;

procedure TfrmConfig.FormShow(Sender: TObject);
begin
  PDVConfig.LerConfig;
  edRecebedorNome.Text := PDVConfig.RecebedorNome;
  edRecebedorCidade.Text := PDVConfig.RecebedorCidade;
  cbLogNivel.ItemIndex := PDVConfig.LogNivel;
  edLogArquivo.Text := PDVConfig.LogArquivo;
  edBBChavePIX.Text := PDVConfig.ChavePix;
  edBBClientID.Text := PDVConfig.ClientID;
  edBBClientSecret.Text := PDVConfig.ClientSecret;
  edBBDevAppKey.Text := PDVConfig.DeveloperAppKey;
  edtArqChavePrivada.Text := PDVConfig.fArqChavePrivada;
  edtArqCertificado.Text := PDVConfig.fArqCertificado;
end;

function TfrmConfig.GetPDVConfig: TPDVConfig;
begin
  if (not Assigned(fPDVConfig)) then
    fPDVConfig := TPDVConfig.Create;
  Result := fPDVConfig;
end;

procedure TfrmConfig.ValidarCampos;
var
  wErros: TStringList;
  procedure ValidarCampo(aNomeCampo: String; aEdit: TEdit);
  begin
    if EstaVazio(aEdit.Text) then
      wErros.Add(' - ' + aNomeCampo + ' não pode ser vazio');
  end;
begin
  wErros := TStringList.Create;
  try
    ValidarCampo('Nome do Recebedor', edRecebedorNome);
    ValidarCampo('Cidade do Recebedor', edRecebedorCidade);
    ValidarCampo('Chave PIX', edBBChavePIX);
    ValidarCampo('ClientID', edBBClientID);
    ValidarCampo('ClientSecret', edBBClientSecret);
    ValidarCampo('DeveloperAppKey', edBBDevAppKey);
    if (wErros.Count > 0) then
    begin
      wErros.Insert(0, ' Verifique os erros antes de Gravar:' + sLineBreak);
      ShowMessage(wErros.Text);
      Abort;
    end;
  finally
    wErros.Free;
  end;
end;

procedure TfrmConfig.ValidarChavePSPBB;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edtArqChavePrivada.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPrivateKeyFromFile(a);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  ShowMessage(e);
end;

procedure TfrmConfig.ValidarCertificadoPSPBB;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edtArqCertificado.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPEMFromFile(a);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  ShowMessage(e);
end;

function TfrmConfig.AdicionarPathAplicacao(const AFileName: String): String;
var
  s: String;
begin
  s := Trim(AFileName);
  if (s = '') then
    Result := s
  else if (ExtractFilePath(AFileName) <> '') then
    Result := s
  else
    Result := ApplicationPath + s;
end;

end.
