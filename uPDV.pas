unit uPDV;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, ACBrPIXCD, Grids, ActnList, uPagamentoPIX, ImgList, System.Actions;

type

  TVendaDados = record
    ClienteDoc: String;
    ClienteNome: String;
    Total: Currency;
    UltPagamento_E2E: String;
    UltPagamento_Valor: Currency;
  end;

  { TfrPDV }

  TfrmPDV = class(TForm)
    aConfigurar: TAction;
    aCancelarAnterior: TAction;
    aIncluirItem: TAction;
    aExcluirItem: TAction;
    aEfetuarPagamento: TAction;
    alAcoesPDV: TActionList;
    btEfetuarPagamento: TSpeedButton;
    btCancelarAnterior: TSpeedButton;
    edClienteDoc: TEdit;
    edClienteNome: TEdit;
    edItemDescricao: TEdit;
    edItemEAN: TEdit;
    edItemValor: TEdit;
    gbCliente: TGroupBox;
    gbItens: TGroupBox;
    gbStatus: TGroupBox;
    gbTotal: TGroupBox;
    gdItens: TStringGrid;
    Label1: TLabel;
    lbClienteDoc: TLabel;
    lbClienteNome: TLabel;
    lbItemDescricao: TLabel;
    lbItemEAN: TLabel;
    lbItemValor: TLabel;
    pnOpcoes: TPanel;
    pnHeader: TPanel;
    pnItemRodape: TPanel;
    pnBackground: TPanel;
    pnCliente: TPanel;
    pnDadosItem: TPanel;
    pnRodape: TPanel;
    pnTotalStr: TPanel;
    btItemIncluir: TSpeedButton;
    btItemExcluir: TSpeedButton;
    Panel1: TPanel;
    btnConfig: TSpeedButton;
    SpeedButton1: TSpeedButton;
    aConsultarPagamentos: TAction;
    procedure aCancelarAnteriorExecute(Sender: TObject);
    procedure aConfigurarExecute(Sender: TObject);
    procedure aEfetuarPagamentoExecute(Sender: TObject);
    procedure aExcluirItemExecute(Sender: TObject);
    procedure aIncluirItemExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure aConsultarPagamentosExecute(Sender: TObject);

  private

    procedure AtualizarTotal;
    procedure IniciarNovaVenda;
    procedure AvaliarInterface;
    procedure LimparInterface;
    procedure ExcluirItemGrid(aIndex: Integer);
    procedure AtualizarStatus(aStatus: String; aCor: TColor);
    procedure AdicionarItemGrid(aEan, aDescricao: String; aValor: Double);
  public
    fVendaDados: TVendaDados;
    property VendaDados: TVendaDados read fVendaDados;
  end;

var
  frmPDV: TfrmPDV;

implementation

uses
  uConfig, uPagamento, ACBrUtil.Base, uConsultaPagamentos;

{$R *.dfm}

{ TfrPDV }

procedure TfrmPDV.FormCreate(Sender: TObject);
begin
  IniciarNovaVenda;
end;

procedure TfrmPDV.aEfetuarPagamentoExecute(Sender: TObject);
var
  wP: TfrmPagamento;
begin
  fVendaDados.ClienteDoc := edClienteDoc.Text;
  fVendaDados.ClienteNome := edClienteNome.Text;

  if NaoEstaVazio(fVendaDados.ClienteNome) and EstaVazio(fVendaDados.ClienteDoc) then
  begin
    ShowMessage('Necess�rio preencher o CPF/CNPJ do cliente');
    edClienteDoc.SetFocus;
    Exit;
  end;

  AtualizarStatus('PAGANDO', $0000D3D9);
  try
    wP := TfrmPagamento.Create(Self);
    if (wP.ShowModal = mrOK) then
      IniciarNovaVenda;
  finally
    AtualizarStatus('VENDENDO', $00FFBF80);
  end;
end;

procedure TfrmPDV.aConfigurarExecute(Sender: TObject);
var
  wC: TfrmConfig;
begin
  wC := TfrmConfig.Create(Self);
  wC.ShowModal;
end;

procedure TfrmPDV.aConsultarPagamentosExecute(Sender: TObject);
var
  wC: TfrmConsultaPagamentos;
begin
  wC := TfrmConsultaPagamentos.Create(Self);
  wC.ShowModal;
end;

procedure TfrmPDV.aCancelarAnteriorExecute(Sender: TObject);
var
  wPix: TfrmPagamentoPIX;
begin
  wPix := TfrmPagamentoPIX.Create(Self);
  if wPix.EstornarPagamento(VendaDados.UltPagamento_E2E, VendaDados.UltPagamento_Valor) then
  begin
    fVendaDados.UltPagamento_E2E := EmptyStr;
    fVendaDados.UltPagamento_Valor := 0;
    AvaliarInterface;
  end;
end;

procedure TfrmPDV.aExcluirItemExecute(Sender: TObject);
begin
  if (MessageDlg('Deseja realmente excluir o Item?', mtConfirmation, mbOKCancel, 0) = mrNo) then
    Exit;

  ExcluirItemGrid(gdItens.Row);
  AtualizarTotal;
end;

procedure TfrmPDV.aIncluirItemExecute(Sender: TObject);
begin
  if EstaVazio(edItemDescricao.Text) then
  begin
    ShowMessage('Informe a Descri��o do Item');
    edItemDescricao.SetFocus;
  end
  else if EstaVazio(edItemEAN.Text) then
  begin
    ShowMessage('Informe o C�digo EAN do Item');
    edItemEAN.SetFocus;
  end
  else
  begin
    AdicionarItemGrid(Trim(edItemEAN.Text), Trim(edItemDescricao.Text), StrToFloatDef(edItemValor.Text, 1));
    AtualizarTotal;
  end;
end;

procedure TfrmPDV.AtualizarTotal;
var
  I: Integer;
begin
  fVendaDados.Total := 0;
  for I := 1 to Pred(gdItens.RowCount) do
    fVendaDados.Total := fVendaDados.Total +
      StrToCurrDef(StringReplace(gdItens.Cells[2, I], '.', '', []), 0);
  AvaliarInterface;
end;

procedure TfrmPDV.IniciarNovaVenda;
begin
  fVendaDados.Total := 0;
  fVendaDados.ClienteDoc := EmptyStr;
  fVendaDados.ClienteNome := EmptyStr;
  LimparInterface;

  AtualizarTotal;
end;

procedure TfrmPDV.AvaliarInterface;
begin
  aExcluirItem.Enabled := (fVendaDados.Total > 0);
  aEfetuarPagamento.Enabled := (fVendaDados.Total > 0);
  aEfetuarPagamento.Visible := (fVendaDados.Total > 0);
  aCancelarAnterior.Enabled := NaoEstaVazio(VendaDados.UltPagamento_E2E);
  aCancelarAnterior.Visible := NaoEstaVazio(VendaDados.UltPagamento_E2E);
  pnTotalStr.Caption := FormatFloatBr(fVendaDados.Total, 'R$ ,0.00');
end;

procedure TfrmPDV.LimparInterface;
begin
  //edItemEAN.Clear;
  edItemValor.Clear;
  //edItemDescricao.Clear;
  //edClienteDoc.Clear;
  //edClienteNome.Clear;

  with gdItens do
  begin
    RowCount := 1;
    ColWidths[0] := 130;
    ColWidths[1] := 200;
    ColWidths[2] := 130;

    Cells[0,0] := 'EAN';
    Cells[1,0] := 'Descri��o';
    Cells[2,0] := 'Valor';
  end;
end;

procedure TfrmPDV.ExcluirItemGrid(aIndex: Integer);
var
  I, J: Integer;
begin
  with gdItens do
  begin
    for I := aIndex to RowCount - 2 do
      for J := 0 to ColCount - 1 do
        Cells[J, I] := Cells[J, I+1];

    RowCount := RowCount - 1
  end;
end;

procedure TfrmPDV.AtualizarStatus(aStatus: String; aCor: TColor);
begin
  Panel1.Color := aCor;
  Panel1.Caption := aStatus;
end;

procedure TfrmPDV.AdicionarItemGrid(aEan, aDescricao: String; aValor: Double);
begin
  with gdItens do
  begin
    RowCount := RowCount + 1;
    Cells[0, RowCount-1] := aEAN;
    Cells[1, RowCount-1] := aDescricao;
    Cells[2, RowCount-1] := FormatFloatBr(aValor);
  end;
end;

end.

