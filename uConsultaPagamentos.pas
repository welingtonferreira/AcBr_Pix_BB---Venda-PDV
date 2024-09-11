unit uConsultaPagamentos;

interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, ACBrPIXCD, Grids, ActnList, uPagamentoPIX, ImgList, System.Actions,
  Vcl.Samples.Spin, Vcl.ComCtrls, ACBrPIXUtil, ACBrBase, System.DateUtils,
  ACBrCEP, ACBrPIXPSPBancoDoBrasil, ACBrPIXPSPSantander, ACBrPIXBase, ACBrPIXSchemasPix,
  ACBrPIXSchemasDevolucao, ACBrPIXSchemasCob, ACBrPIXPSPShipay, ShellAPI,
  ACBrOpenSSLUtils, ACBrPIXPSPSicredi, ACBrPIXBRCode, ACBrSocket, ACBrPIXPSPSicoob, ACBrPIXPSPPagSeguro, ACBrPIXPSPGerenciaNet,
  ACBrPIXPSPBradesco, ACBrPIXPSPPixPDV, ACBrPIXPSPInter, ACBrPIXPSPAilos,
  ACBrPIXPSPMatera, ACBrPIXPSPCielo, ACBrPIXPSPMercadoPago, ACBrPIXPSPGate2All,
  ACBrPIXPSPBanrisul, ACBrPIXPSPC6Bank, System.ImageList, System.Json
  {$IfDef FPC}
  , DateTimePicker
  {$EndIf};
type

  { TfrmConsultaPagamentos }
  TfrmConsultaPagamentos = class(TForm)
    pnBackground: TPanel;
    pgTestesPix: TPageControl;
    tsConsultarPixRecebidos: TTabSheet;
    pConsultarPixRecebidos: TPanel;
    lE2eid: TLabel;
    lInicio: TLabel;
    lFim: TLabel;
    lCPFCPNJ: TLabel;
    lPagina: TLabel;
    lPagina1: TLabel;
    edtConsultarPixRecebidosTxId: TEdit;
    btConsultarPixRecebidos: TBitBtn;
    dtConsultarPixRecebidosInicio: TDateTimePicker;
    dtConsultarPixRecebidosFim: TDateTimePicker;
    edtConsultarPixRecebidosCPFCNPJ: TEdit;
    seConsultarPixRecebidosPagina: TSpinEdit;
    seConsultarPixRecebidosItensPagina: TSpinEdit;
    mConsultarPixRecebidos: TMemo;
    Panel4: TPanel;
    btLimparConsultarPixRecebidos: TBitBtn;
    ACBrPixCD1: TACBrPixCD;
    ACBrPSPBancoDoBrasil1: TACBrPSPBancoDoBrasil;
    procedure btConsultarPixRecebidosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btLimparConsultarPixRecebidosClick(Sender: TObject);
  private
    function FormatarJSON(const AJSON: String): String;
    procedure MostrarPixEmLinhas(const NomePix: String; APix: TACBrPIX; SL: TStrings);
    procedure MostrarDevolucaoEmLinhas(const NomeDev: String;
      ADev: TACBrPIXDevolucao; SL: TStrings);

  public

  end;

var
  frmConsultaPagamentos: TfrmConsultaPagamentos;

implementation

uses
  {$IfDef FPC}
   fpjson, jsonparser, jsonscanner, Jsons,
  {$EndIf}
  uConfig, uPagamento,   TypInfo, Clipbrd, IniFiles, synacode, synautil,
  ACBrDelphiZXingQRCode, ACBrImage, ACBrValidador, ACBrConsts,
  ACBrPIXSchemasCobV, OpenSSLExt,
  ACBrJSON,
  ACBrUtil.Base,
  ACBrUtil.FilesIO,
  ACBrUtil.Strings,
  ACBrUtil.DateTime,
  ACBrUtil.Compatibilidade, uPDV;

{$R *.dfm}

procedure TfrmConsultaPagamentos.btConsultarPixRecebidosClick(Sender: TObject);
var
  Ok: Boolean;
  i: Integer;
begin
  mConsultarPixRecebidos.Lines.Clear;

  Ok := ACBrPixCD1.PSP.epPix.ConsultarPixRecebidos(
          StartOfTheDay(dtConsultarPixRecebidosInicio.DateTime),
          EndOfTheDay(dtConsultarPixRecebidosFim.DateTime),
          edtConsultarPixRecebidosTxId.Text,
          OnlyNumber(edtConsultarPixRecebidosCPFCNPJ.Text),
          seConsultarPixRecebidosPagina.Value,
          seConsultarPixRecebidosItensPagina.Value);

  if Ok then
  begin
    mConsultarPixRecebidos.Lines.Text := FormatarJSON(ACBrPixCD1.PSP.epPix.PixConsultados.AsJSON);
    mConsultarPixRecebidos.Lines.Add('');
    mConsultarPixRecebidos.Lines.Add('Encontrado: '+IntToStr(ACBrPixCD1.PSP.epPix.PixConsultados.pix.Count)+', documentos PIX');
    for i := 0 to ACBrPixCD1.PSP.epPix.PixConsultados.pix.Count-1 do
    begin
      mConsultarPixRecebidos.Lines.Add('');
      MostrarPixEmLinhas('  Pix['+IntToStr(i)+']',
        ACBrPixCD1.PSP.epPix.PixConsultados.pix[i], mConsultarPixRecebidos.Lines);
    end;
  end
  else
    mConsultarPixRecebidos.Lines.Text := FormatarJSON(ACBrPixCD1.PSP.epPix.Problema.AsJSON);
end;

procedure TfrmConsultaPagamentos.btLimparConsultarPixRecebidosClick(
  Sender: TObject);
begin
  mConsultarPixRecebidos.Lines.Clear;
end;

function TfrmConsultaPagamentos.FormatarJSON(const AJSON: String): String;
{$IfDef FPC}
var
  jpar: TJSONParser;
  j: TJsonObject;
{$EndIf}
begin
  Result := AJSON;
  {$IfDef FPC}
  try
    j := TJSONObject.Create();
    try
      Result := j.Decode(Result);
    finally
      j.Free;
    end;
    jpar := TJSONParser.Create(Result, [joUTF8]);
    try
      Result := jpar.Parse.FormatJSON([], 2);
    finally
      jpar.Free;
    end;
  except
    Result := AJSON;
  end;
  {$EndIf}
end;

procedure TfrmConsultaPagamentos.FormShow(Sender: TObject);
var
  wConfig: TPDVConfig;
begin
  wConfig := TPDVConfig.Create;
  try
    wConfig.LerConfig;
    ACBrPixCD1.Recebedor.Nome := wConfig.RecebedorNome;
    ACBrPixCD1.Recebedor.Cidade := wConfig.RecebedorCidade;
    ACBrPSPBancoDoBrasil1.ChavePIX := wConfig.ChavePix;
    ACBrPSPBancoDoBrasil1.ClientID := wConfig.ClientID;
    ACBrPSPBancoDoBrasil1.ClientSecret := wConfig.ClientSecret;
    ACBrPSPBancoDoBrasil1.DeveloperApplicationKey := wConfig.DeveloperAppKey;
    ACBrPSPBancoDoBrasil1.ArquivoCertificado := wConfig.ArqCertificado;
    ACBrPSPBancoDoBrasil1.ArquivoChavePrivada := wConfig.ArqChavePrivada;

    dtConsultarPixRecebidosInicio.Date := StartOfTheDay(Now);
    dtConsultarPixRecebidosFim.Date := EndOfTheDay(Now);
  finally
    wConfig.Free;
  end;
end;

procedure TfrmConsultaPagamentos.MostrarPixEmLinhas(const NomePix: String;
  APix: TACBrPIX; SL: TStrings);
var
  i: Integer;
begin
  SL.Add(NomePix+'.endToEndId: '+APix.endToEndId);
  SL.Add(NomePix+'.TxId: '+APix.txid);
  SL.Add(NomePix+'.valor: '+FormatFloatBr(APix.valor));
  if not APix.componentesValor.IsEmpty then
  begin
    SL.Add(NomePix+'.componentesValor.original.valor: '+FormatFloatBr(APix.componentesValor.original.valor));
    if (APix.componentesValor.saque.valor > 0) then
      SL.Add(NomePix+'.componentesValor.saque.valor: '+FormatFloatBr(APix.componentesValor.saque.valor));
    if (APix.componentesValor.troco.valor > 0) then
      SL.Add(NomePix+'.componentesValor.troco.valor: '+FormatFloatBr(APix.componentesValor.troco.valor));
    if (APix.componentesValor.juros.valor > 0) then
      SL.Add(NomePix+'.componentesValor.juros.valor: '+FormatFloatBr(APix.componentesValor.juros.valor));
    if (APix.componentesValor.multa.valor > 0) then
      SL.Add(NomePix+'.componentesValor.multa.valor: '+FormatFloatBr(APix.componentesValor.multa.valor));
    if (APix.componentesValor.abatimento.valor > 0) then
      SL.Add(NomePix+'.componentesValor.abatimento.valor: '+FormatFloatBr(APix.componentesValor.abatimento.valor));
    if (APix.componentesValor.desconto.valor > 0) then
      SL.Add(NomePix+'.componentesValor.desconto.valor: '+FormatFloatBr(APix.componentesValor.desconto.valor));
  end;
  SL.Add(NomePix+'.chave: '+APix.chave);
  SL.Add(NomePix+'.horario: '+FormatDateTimeBr(APix.horario));
  SL.Add(NomePix+'.infoPagador: '+APix.infoPagador);
  SL.Add(NomePix+'.devolucoes: '+IntToStr(APix.devolucoes.Count) );

  for i := 0 to APix.devolucoes.Count-1 do
    MostrarDevolucaoEmLinhas( NomePix+'.devolucoes['+IntToStr(i)+']',
                              APix.devolucoes[i],
                              SL );
end;

procedure TfrmConsultaPagamentos.MostrarDevolucaoEmLinhas(const NomeDev: String;
  ADev: TACBrPIXDevolucao; SL: TStrings);
begin
  SL.Add(NomeDev+'.valor: '+FormatFloatBr(ADev.valor));
  SL.Add(NomeDev+'.natureza: '+ UTF8ToUnicodeString(PIXNaturezaDevolucaoToString(ADev.natureza)));
  SL.Add(NomeDev+'.descricao: '+ UTF8ToUnicodeString(ADev.descricao));
  SL.Add(NomeDev+'.id: '+ADev.id);
  SL.Add(NomeDev+'.rtrId: '+ADev.rtrId);
  SL.Add(NomeDev+'.horario.solicitacao: '+FormatDateTimeBr(ADev.horario.solicitacao));
  SL.Add(NomeDev+'.horario.liquidacao: '+FormatDateTimeBr(ADev.horario.liquidacao));
  SL.Add(NomeDev+'.status: '+ UTF8ToUnicodeString(PIXStatusDevolucaoToString(ADev.status)));
  SL.Add(NomeDev+'.motivo: '+ UTF8ToUnicodeString(ADev.motivo));
end;

end.
