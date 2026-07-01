unit uInsereProdutos;

interface

uses
  System.SysUtils, System.Generics.Collections;

type
  TProdutoRegra = class
    ID        : Integer;
    Descricao : string;
  end;
  TProduto = class
    ID             : Integer;
    Nome           : string;
    Preco          : Double;
    ProdutoRegraID : Integer;
  end;
  TDBHelper = class
    procedure GravarProduto(const AProduto: TProduto);
  end;
  TInsereProdutos = class
    FDB: TDBHelper;

    constructor Create;
    destructor Destroy; override;
    procedure InserirListaProdutos;
  end;

implementation

procedure TDBHelper.GravarProduto(const AProduto: TProduto);
begin

  Writeln('Gravando: ' + AProduto.Nome);

end;
//------------------------------------------------------------------------------
constructor TInsereProdutos.Create;
begin

  inherited;
  FDB := TDBHelper.Create;

end;
destructor TInsereProdutos.Destroy;
begin

  FreeAndNil(FDB);
  inherited;

end;
procedure TInsereProdutos.InserirListaProdutos;
begin

  var Lista := TList<TProduto>.Create;
  try

    var Produto: TProduto;
    for var I := 1 to 10 do
    begin

      Produto                := TProduto.Create;
      Produto.ID             := I;
      Produto.Nome           := Format('Produto %d', [I]);
      Produto.Preco          := 10.0 * I;
      Produto.ProdutoRegraID := (I mod 3) + 1;

      Lista.Add(Produto);

    end;

    for Produto in Lista do
      try

        FDB.GravarProduto(Produto);
        Writeln('Produto ' + Produto.Nome + ' inserido com sucesso!');

      except
        on E: Exception do
          Writeln(Produto.Nome + ' | ERRO ao inserir: ' + E.Message);
      end;

  finally
    for Produto in Lista do
      FreeAndNil(Produto);

    FreeAndNil(Lista);
  end;

end;

end.
