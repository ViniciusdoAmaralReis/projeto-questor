# <div align="center">🧩 Projeto Questor</div>
<p align="center">
  <img src="https://img.shields.io/badge/Delphi-10.4+-red?style=flat-square&logo=delphi&logoColor=white" />
  <img src="https://img.shields.io/badge/SQLite-3-blue?style=flat-square&logo=sqlite&logoColor=white" />
  <img src="https://img.shields.io/badge/VSCode-1.60+-blue?style=flat-square&logo=visual-studio-code&logoColor=white" />
  <img src="https://img.shields.io/badge/DB_Browser-SQLite-003B57?style=flat-square&logo=sqlite&logoColor=white" />
</p>
<div align="center">Este projeto é a solução para um desafio técnico de uma vaga de desenvolvedor Delphi. O objetivo foi modelar um sistema de sorteio para clientes da montadora Taif, aplicando regras de negócio específicas por meio de consultas SQL e implementando uma camada de acesso a dados simulada com classes em Object Pascal.</div>

---

## ℹ️ Sobre

A Taif realizou um sorteio para clientes que compraram o modelo **Marea**. As regras do sorteio são:

- Apenas os **15 primeiros clientes** (por ordem de data de venda) são contemplados.
- O CPF do cliente deve começar com o dígito **0**.
- O cliente deve ter comprado um carro com **ano de lançamento 2021**.
- Clientes que compraram **dois ou mais carros do modelo Marea** estão desclassificados.

O sistema desenvolvido contempla:

- **Scripts SQL** para criação das tabelas e consultas do sorteio.
- **Classes em Delphi** (`TCliente`, `TCarro`, `TVenda`) representando as entidades.
- **Métodos fictícios** (`InserirDadosBD` e `ExecutarSql`) para simular operações com banco de dados.
- **Funcionalidades** para inserção de 5 clientes, 5 carros e 5 vendas, cada uma com um carro diferente.
- **Exclusão de vendas** de clientes não sorteados, sem utilizar o comando `IN` (usando `NOT EXISTS`).

Validação CST:

- função para validação de CST

---

## ▶️ Execução

### 1. Banco de Dados (SQL)

Os scripts SQL podem ser executados em qualquer SGBD compatível com a sintaxe apresentada (foi testado no DB Browser for SQLite Version 3.13.1).

```bash
01 - criacao_tabelas.sql
02 - quantidade_vendas_marea.sql
03 - quantidade_vendas_uno_cliente.sql
04 - quantidade_clientes_nao_venda.sql
05 - clientes_sorteados.sql
06 - exclusao_vendas_nao_sorteados.sql
```

### 2. Delphi

```pascal
begin
  var Sorteio := TSorteio.Create;
  try
    Sorteio.Inserir5Clientes;          // insere 5 clientes
    Sorteio.Inserir5Carros;            // insere 5 carros
    Sorteio.Inserir5Vendas;            // insere uma venda para cada cliente
    Sorteio.ExcluirVendasNaoSorteados; // exclui vendas dos não sorteados
  finally
    FreeAndNil(Sorteio);
  end;
end;
```
Os métodos InserirDadosBD e ExecutarSql são fictícios.

```pascal
if ValidaCSTEmpresa('020', 'PR', 'SP', '') then
  ShowMessage('Válido')
else
  ShowMessage('Inválido');
```

---

## 📐 Decisões Técnicas

- Foram utilizadas as seguintes ferramentas: DB Browser for SQLite Version 3.13.1, VSCode 1.122.1, Delphi 13.
- Código com variáveis inline e FreeAndNil (estilo Delphi moderno).
- Uso de QuotedStr para montar as strings SQL com segurança.
- try..except nos métodos fictícios para capturar erros.

---
## ⚖️ Licença
Este projeto é apenas para fins de avaliação técnica.
