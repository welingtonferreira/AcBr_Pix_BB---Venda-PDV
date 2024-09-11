unit uPagamento;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  ActnList, System.Actions;

type

  { TfrPagamento }

  TfrmPagamento = class(TForm)
    aCancelar: TAction;
    aDinheiro: TAction;
    aDebito: TAction;
    aCredito: TAction;
    aPIX: TAction;
    ActionList1: TActionList;
    pnPagamento: TPanel;
    btPIX: TSpeedButton;
    procedure aCancelarExecute(Sender: TObject);
    procedure aFormaPagtoExecute(Sender: TObject);
    procedure aPIXExecute(Sender: TObject);
  private

  public

  end;

implementation

uses uPagamentoPIX;

{$R *.dfm}

{ TfrPagamento }

procedure TfrmPagamento.aFormaPagtoExecute(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TfrmPagamento.aCancelarExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmPagamento.aPIXExecute(Sender: TObject);
var
  wPix: TfrmPagamentoPIX;
begin
  wPix := TfrmPagamentoPIX.Create(Self);

  if wPix.CriarCobranca and (wPix.ShowModal = mrOK) then
    ModalResult := mrOK;
end;

end.

