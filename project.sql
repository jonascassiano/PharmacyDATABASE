--	Federal University of São Francisco Valley (UNIVASF)
--	Pharmacy Oracle SQL database

CREATE TABLE Cliente (
    pk_CPF_C NUMBER(11) PRIMARY KEY,
    Nome VARCHAR (255) NOT NULL,
    DDD NUMBER(3),
    Numero NUMBER(9)
);

CREATE TABLE Funcionario (
    pk_CPF_F NUMBER(11) PRIMARY KEY,
    Nome VARCHAR (255) NOT NULL,
    Salario NUMBER(9, 2) NOT NULL,
    Cargo VARCHAR (255) NOT NULL,
    Cidade VARCHAR (255) NOT NULL,
    Rua VARCHAR (255) NOT NULL,
    Num NUMBER(9) NOT NULL,
    UF VARCHAR (2) NOT NULL,
    Bairro VARCHAR (255) NOT NULL
);

CREATE TABLE Fornecedor (
    pk_CNPJ NUMBER(14) PRIMARY KEY,
    Nome VARCHAR (255) NOT NULL,
    Bairro VARCHAR (255) NOT NULL,
    Rua VARCHAR (255) NOT NULL,
    Cidade VARCHAR (255) NOT NULL,
    Num NUMBER(9) NOT NULL,
    UF VARCHAR(2) NOT NULL
);

CREATE TABLE Medicamento (
    pk_CodProduto NUMBER(9) PRIMARY KEY,
    Preco NUMBER(9, 2) NOT NULL,
    Tipo VARCHAR(255) NOT NULL,
    QtdEstoque NUMBER(9) NOT NULL,
    Nome VARCHAR(255) NOT NULL,
    QtdMiligramas NUMBER(5, 2) NOT NULL,
    Controlado VARCHAR(1) NOT NULL,
    Tarja VARCHAR(255) NOT NULL
);

CREATE TABLE TELEFONE_FUN (
    pk_Telefone_F NUMBER(9) NOT NULL,
    pk_fk_CPF_F NUMBER(11) NOT NULL,
    Numero NUMBER(9) NOT NULL,
    DDD NUMBER(3) NOT NULL,
    CONSTRAINT pk_Telefone_fun PRIMARY KEY (pk_Telefone_F, pk_fk_CPF_F),
    CONSTRAINT fk_CPF_F FOREIGN KEY (pk_fk_CPF_F) REFERENCES FUNCIONARIO(PK_CPF_F)
);

CREATE TABLE Compra (
    pk_idCompra NUMBER(9) PRIMARY KEY,
    fk_Funcionario_CPF NUMBER(11) NOT NULL,
    fk_Fornecedor_CNPJ NUMBER(14) NOT NULL,
    ValorTotal NUMBER(9, 2) NOT NULL,
    DataCompra DATE NOT NULL,
    CONSTRAINT fk_Compra_Funcionario_CPF FOREIGN KEY (fk_Funcionario_CPF) REFERENCES funcionario(pk_CPF_F),
    CONSTRAINT fk_Compra_Fornecedor_CNPJ FOREIGN KEY (fk_Fornecedor_CNPJ) REFERENCES fornecedor(pk_CNPJ)
);

CREATE TABLE TELEFONE_FOR (
    pk_Telefone_FOR NUMBER(9) NOT NULL,
    pk_fk_CNPJ NUMBER(14) NOT NULL,
    Numero NUMBER(9) NOT NULL,
    DDD NUMBER(3) NOT NULL,
    CONSTRAINT pk_Telefone_fornecedor PRIMARY KEY (pk_Telefone_FOR, pk_fk_CNPJ),
    CONSTRAINT fk_CPNJ_FOR FOREIGN KEY (pk_fk_CNPJ) REFERENCES FORNECEDOR(pk_CNPJ)
);

CREATE TABLE Venda (
    pk_idVenda NUMBER(9) PRIMARY KEY,
    fk_Cliente_CPF NUMBER (11) NOT NULL,
    fk_Funcionario_CPF NUMBER (11) NOT NULL,
    DataVenda DATE NOT NULL,
    Desconto NUMBER(5, 2),
    ValorTotal NUMBER(9, 2) NOT NULL,
    CONSTRAINT fk_Venda_Cliente_CPF FOREIGN KEY (fk_Cliente_CPF) REFERENCES Cliente(pk_CPF_C),
    CONSTRAINT fk_Venda_Funcionario_CPF FOREIGN KEY (fk_Funcionario_CPF) REFERENCES funcionario(pk_CPF_F)
);

CREATE TABLE ItensVendidos (
    pk_fk_Medicamento_CodProduto NUMBER(9) NOT NULL,
    pk_fk_Venda_idVenda NUMBER(9) NOT NULL,
    Qtd NUMBER(9) NOT NULL,
    CONSTRAINT pk_ItensVendidos PRIMARY KEY (
        pk_fk_Medicamento_CodProduto,
        pk_fk_Venda_idVenda
    ),
    CONSTRAINT pk_fk_Med_Produto FOREIGN KEY (pk_fk_Medicamento_CodProduto) REFERENCES Medicamento(pk_CodProduto),
    CONSTRAINT pk_fk_Vend_idVenda FOREIGN KEY (pk_fk_Venda_idVenda) REFERENCES Venda(pk_idVenda)
);

CREATE TABLE ItensComprados (
    pk_fk_Compra_idCompra NUMBER(9) NOT NULL,
    pk_fk_Medicamento_CodProduto NUMBER(9) NOT NULL,
    Qtd NUMBER(9) NOT NULL,
    DataValidade DATE NOT NULL,
    CONSTRAINT pk_ItensComprados PRIMARY KEY (
        pk_fk_Compra_idCompra,
        pk_fk_Medicamento_CodProduto
    ),
    CONSTRAINT pk_fk_Compr_idCompra FOREIGN KEY (pk_fk_Compra_idCompra) REFERENCES Compra(pk_idCompra),
    CONSTRAINT pk_fk_Med_CodProduto FOREIGN KEY (pk_fk_Medicamento_CodProduto) REFERENCES Medicamento(pk_CodProduto)
);

-- Procedure - DROP_Estoque
CREATE
OR REPLACE PROCEDURE Drop_Estoque(varIDVENDA IN VENDA.PK_IDVENDA % TYPE) IS varX NUMBER;

VarNOMEMED VARCHAR(255);

totalQTD NUMBER;

BEGIN FOR varX IN (
    SELECT
        pk_fk_MEDICAMENTO_CODPRODUTO,
        QTD
    FROM
        Itensvendidos
    WHERE
        pk_fk_Venda_idVenda = varIDVENDA
) LOOP
UPDATE
    MEDICAMENTO
SET
    qtdEstoque = qtdEstoque - varX.QTD
WHERE
    varX.pk_fk_MEDICAMENTO_CODPRODUTO = pk_CODPRODUTO;

SELECT
    qtdEstoque INTO totalQTD
FROM
    MEDICAMENTO
WHERE
    varX.pk_fk_MEDICAMENTO_CODPRODUTO = pk_CODPRODUTO;

SELECT
    NOME INTO varNOMEMED
FROM
    MEDICAMENTO
WHERE
    varX.pk_fk_MEDICAMENTO_CODPRODUTO = pk_CODPRODUTO;

dbms_output.put_line (
    'Nova quantidade de estoque de ' || varNOMEMED || ' : ' || totalQTD
);

END LOOP;

END Drop_Estoque;

--Procedure ADD_Estoque
CREATE
OR REPLACE PROCEDURE ADD_Estoque(varIDCOMPRA IN COMPRA.PK_IDCOMPRA % TYPE) IS varX NUMBER;

VarNOMEMED VARCHAR(255);

totalQTD NUMBER;

BEGIN FOR varX IN (
    SELECT
        pk_fk_MEDICAMENTO_CODPRODUTO,
        QTD
    FROM
        ItensComprados
    WHERE
        pk_fk_compra_idCompra = varidCompra
) LOOP
UPDATE
    MEDICAMENTO
SET
    qtdEstoque = qtdEstoque + varX.QTD
WHERE
    varX.pk_fk_MEDICAMENTO_CODPRODUTO = pk_CODPRODUTO;

SELECT
    qtdEstoque INTO totalQTD
FROM
    MEDICAMENTO
WHERE
    varX.pk_fk_MEDICAMENTO_CODPRODUTO = pk_CODPRODUTO;

SELECT
    NOME INTO varNOMEMED
FROM
    MEDICAMENTO
WHERE
    varX.pk_fk_MEDICAMENTO_CODPRODUTO = pk_CODPRODUTO;

dbms_output.put_line (
    'Nova quantidade de estoque de ' || varNOMEMED || ' : ' || totalQTD
);

END LOOP;

END ADD_Estoque;

--Trigger Drop_estoque_auto
CREATE
OR REPLACE TRIGGER Drop_estoque_auto
AFTER
insert
    ON itensVendidos FOR EACH ROW DECLARE VarNOMEMED VARCHAR(255);

totalQTD NUMBER;

BEGIN
UPDATE
    MEDICAMENTO
SET
    qtdEstoque = qtdEstoque - :NEW.qtd
WHERE
    :NEW.pk_fk_MEDICAMENTO_CODPRODUTO = pk_CODPRODUTO;

SELECT
    qtdEstoque INTO totalQTD
FROM
    MEDICAMENTO
WHERE
    :NEW.pk_fk_MEDICAMENTO_CODPRODUTO = pk_CODPRODUTO;

SELECT
    NOME INTO varNOMEMED
FROM
    MEDICAMENTO
WHERE
    :NEW.pk_fk_MEDICAMENTO_CODPRODUTO = pk_CODPRODUTO;

dbms_output.put_line (
    'Nova quantidade de estoque de ' || varNOMEMED || '' || totalQTD
);

END;


--Trigger ADD_estoque_auto
CREATE
OR REPLACE TRIGGER ADD_estoque_auto
AFTER
insert
    ON itensComprados FOR EACH ROW DECLARE VarNOMEMED VARCHAR(255);

totalQTD NUMBER;

BEGIN
UPDATE
    MEDICAMENTO
SET
    qtdEstoque = qtdEstoque + :NEW.qtd
WHERE
    :NEW.pk_fk_MEDICAMENTO_CODPRODUTO = pk_CODPRODUTO;

SELECT
    qtdEstoque INTO totalQTD
FROM
    MEDICAMENTO
WHERE
    :NEW.pk_fk_MEDICAMENTO_CODPRODUTO = pk_CODPRODUTO;

SELECT
    NOME INTO varNOMEMED
FROM
    MEDICAMENTO
WHERE
    :NEW.pk_fk_MEDICAMENTO_CODPRODUTO = pk_CODPRODUTO;

dbms_output.put_line (
    'Nova quantidade de estoque de ' || varNOMEMED || ' :
' || totalQTD
);

END;