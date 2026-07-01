unit uSorteio;

interface

uses
  System.SysUtils, System.DateUtils;

type
  TCliente = class
    ID   : Integer;
    Nome : string;
    CPF  : string;
  end;
  TCarro = class
    ID            : Integer;
    Modelo        : string;
    AnoLancamento : Integer;
  end;
  TVenda = class
    ID        : Integer;
    ClienteID : Integer;
    CarroID   : Integer;
    DataVenda : TDateTime;
  end;
  TDBHelper = class
    procedure InserirDadosBD(const ASQL: string);
    procedure ExecutarSql(const ASQL: string);
  end;
  TSorteio = class
    FDB: TDBHelper;

    constructor Create;
    destructor Destroy; override;

    procedure InserirCliente(const ACliente: TCliente);
    procedure InserirCarro(const ACarro: TCarro);
    procedure InserirVenda(const AVenda: TVenda);

    procedure Inserir5Clientes;
    procedure Inserir5Carros;
    procedure Inserir5Vendas;
    procedure ExcluirVendasNaoSorteados;
  end;

implementation

procedure TDBHelper.InserirDadosBD(const ASQL: string);
begin

  try

    //

  except
    on E: Exception do
      Writeln('ERRO no INSERT: ' + E.Message);
  end;

end;
procedure TDBHelper.ExecutarSql(const ASQL: string);
begin

  try

    //

  except
    on E: Exception do
      Writeln('ERRO no EXEC: ' + E.Message);
  end;

end;
//------------------------------------------------------------------------------
constructor TSorteio.Create;
begin

  inherited;
  FDB := TDBHelper.Create;

end;
destructor TSorteio.Destroy;
begin

  FreeAndNil(FDB);
  inherited;

end;

procedure TSorteio.InserirCliente(const ACliente: TCliente);
begin

  var SQL := 'INSERT INTO CLIENTES (ID, NOME, CPF) VALUES (' +
             IntToStr(ACliente.ID) + ', ' +
             QuotedStr(ACliente.Nome) + ', ' +
             QuotedStr(ACliente.CPF) + ')';

  FDB.InserirDadosBD(SQL);

end;
procedure TSorteio.InserirCarro(const ACarro: TCarro);
begin

  var SQL := 'INSERT INTO CARROS (ID, MODELO, ANO_LANCAMENTO) VALUES (' +
             IntToStr(ACarro.ID) + ', ' +
             QuotedStr(ACarro.Modelo) + ', ' +
             IntToStr(ACarro.AnoLancamento) + ')';

  FDB.InserirDadosBD(SQL);

end;
procedure TSorteio.InserirVenda(const AVenda: TVenda);
begin

  var SQL := 'INSERT INTO VENDAS (ID, CLIENTE_ID, CARRO_ID, DATA_VENDA) VALUES (' +
             IntToStr(AVenda.ID) + ', ' +
             IntToStr(AVenda.ClienteID) + ', ' +
             IntToStr(AVenda.CarroID) + ', ' +
             QuotedStr(FormatDateTime('yyyy-mm-dd', AVenda.DataVenda)) + ')';

  FDB.InserirDadosBD(SQL);

end;

procedure TSorteio.Inserir5Clientes;
begin

  var Cliente: TCliente;
  for var I := 1 to 5 do
  begin

    Cliente := TCliente.Create;
    try

      Cliente.ID := I;
      case I of

        1: Cliente.Nome := 'João';
        2: Cliente.Nome := 'Maria';
        3: Cliente.Nome := 'Carlos';
        4: Cliente.Nome := 'Ana';
        5: Cliente.Nome := 'Paulo';

      end;
      Cliente.CPF := Format('0%d234567890', [I]);

      InserirCliente(Cliente);

    finally
      FreeAndNil(Cliente);
    end;

  end;

end;
procedure TSorteio.Inserir5Carros;
begin

  var Carro: TCarro;
  for var I := 1 to 5 do
  begin

    Carro := TCarro.Create;
    try

      Carro.ID := I;
      case I of

        1: Carro.Modelo := 'Fusca';
        2: Carro.Modelo := 'Gol';
        3: Carro.Modelo := 'Palio';
        4: Carro.Modelo := 'Civic';
        5: Carro.Modelo := 'Corolla';

      end;
      Carro.AnoLancamento := 2020 + I - 1;

      InserirCarro(Carro);

    finally
      FreeAndNil(Carro);
    end;

  end;

end;
procedure TSorteio.Inserir5Vendas;
begin

  var Venda: TVenda;
  for var I := 1 to 5 do
  begin

    Venda := TVenda.Create;
    try

      Venda.ID := I;
      Venda.ClienteID := I;
      Venda.CarroID := I;
      Venda.DataVenda := Now;

      InserirVenda(Venda);

    finally
      FreeAndNil(Venda);
    end;

  end;

end;
procedure TSorteio.ExcluirVendasNaoSorteados;
const
  SQL_DELETE =
    'DELETE FROM VENDAS ' +
    'WHERE NOT EXISTS (' +
    '  SELECT 1 ' +
    '  FROM (' +
    '    SELECT CL.ID ' +
    '    FROM CLIENTES CL ' +
    '    INNER JOIN VENDAS VE ON CL.ID = VE.CLIENTE_ID ' +
    '    INNER JOIN CARROS CA ON VE.CARRO_ID = CA.ID ' +
    '    WHERE CL.CPF LIKE ''0%'' ' +
    '      AND CA.ANO_LANCAMENTO = 2021 ' +
    '      AND NOT EXISTS (' +
    '        SELECT 1 ' +
    '        FROM VENDAS VE2 ' +
    '        INNER JOIN CARROS CA2 ON VE2.CARRO_ID = CA2.ID ' +
    '        WHERE VE2.CLIENTE_ID = CL.ID ' +
    '          AND CA2.MODELO = ''Marea'' ' +
    '        GROUP BY VE2.CLIENTE_ID ' +
    '        HAVING COUNT(*) >= 2' +
    '      ) ' +
    '    GROUP BY CL.ID ' +
    '    ORDER BY MIN(VE.DATA_VENDA) ' +
    '    LIMIT 15 ' +
    '  ) SORTEADOS ' +
    '  WHERE SORTEADOS.ID = VENDAS.CLIENTE_ID ' +
    ')';
begin

  FDB.ExecutarSql(SQL_DELETE);

end;

end.
