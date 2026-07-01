unit uValidaCST;

interface

function ValidaCSTEmpresa(const ACST, AEstadoEmpresa, AEstadoPessoa, ACFOP: string): Boolean;

implementation

function ValidaCSTEmpresa(const ACST, AEstadoEmpresa, AEstadoPessoa, ACFOP: string): Boolean;
begin

  Result := False;

  if ((ACST = '010') and ((AEstadoEmpresa = 'PR') or  (AEstadoPessoa = 'SP')))  or
     ((ACST = '010') and ((AEstadoEmpresa = 'PR') or  (AEstadoPessoa <> 'SC'))) or
     ((ACST = '010') and ((AEstadoEmpresa = 'PR') or  (AEstadoPessoa <> 'RJ'))) or
     ((ACST = '020') and (AEstadoEmpresa <> 'SP') and (AEstadoPessoa = 'SP'))   then
    Result := True;

end;

end.
