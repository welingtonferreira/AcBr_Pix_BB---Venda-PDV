program PIX_BB;
uses
  Forms,
  uConfig in 'uConfig.pas' {frmConfig},
  uPagamento in 'uPagamento.pas' {frmPagamento},
  uPagamentoPIX in 'uPagamentoPIX.pas' {frmPagamentoPIX},
  uPDV in 'uPDV.pas' {frmPDV},
  uConsultaPagamentos in 'uConsultaPagamentos.pas' {frmConsultaPagamentos};

{$R *.res}
begin
  Application.Initialize;
  Application.CreateForm(TfrmPDV, frmPDV);
  Application.Run;
end.
