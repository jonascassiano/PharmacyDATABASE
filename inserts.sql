--	Federal University of São Francisco Valley (UNIVASF)
--	Pharmacy Oracle SQL database

--TEST INSERT DATA

--Funcionario
BEGIN
INSERT INTO
    funcionario
VALUES
    (
        10123453401,
        'Jaime Rodrigues Araújo',
        1500.00,
        'Operador de Caixa',
        'Juazeiro',
        'Rua 10',
        '100',
        'PE',
        'Loteamento
Recife'
    );

INSERT INTO
    funcionario
VALUES
    (
        11113398043,
        'Jorge Lucas Star Wars',
        2500.00,
        'Operador de Caixa',
        'Petrolina',
        'Rua 21',
        '420',
        'PE',
        'Vila
Eduardo'
    );

INSERT INTO
    funcionario
VALUES
    (
        94428187084,
        'Maria Carolina Araújo',
        4300.00,
        'Gerente',
        'Petrolina',
        'Rua 31',
        '200',
        'PE',
        'Cohab'
    );

END;

-- Cliente
BEGIN
INSERT INTO
    cliente
VALUES
    (19006207071, 'Eronildo Junior', 81, 22010112);

INSERT INTO
    cliente
VALUES
    (
        30765713039,
        'Edwildson Filho da
Natureza',
        74,
        23110212
    );

INSERT INTO
    cliente
VALUES
    (82871596018, 'Tiago Tito Liro', 74, 24160311);

INSERT INTO
    cliente
VALUES
    (19006217171, 'Joao Pinto', null, null);

END;

--Medicamento
BEGIN
INSERT INTO
    medicamento
VALUES
    (
        01,
        12.00,
        'XAROPE',
        10,
        'ACEBROFILINA',
        25.00,
        'S',
        'Vermelha'
    );

INSERT INTO
    medicamento
VALUES
    (
        02,
        140.67,
        'COMPRIMIDO',
        4,
        'RITALINA',
        10.00,
        'S',
        'Preta'
    );

INSERT INTO
    medicamento
VALUES
    (
        03,
        5.00,
        'GEL',
        13,
        'DICLOFENACO SÓDICO',
        10.00,
        'N',
        'N'
    );

INSERT INTO
    medicamento
VALUES
    (
        04,
        8.00,
        'COMPRIMIDO',
        33,
        'IBUPROFENO',
        200.00,
        'N',
        'N'
    );

INSERT INTO
    medicamento
VALUES
    (
        05,
        4.00,
        'COMPRIMIDO',
        20,
        'NIMESULIDA',
        100.00,
        'N',
        'N'
    );

END;

--FORNECEDOR
BEGIN
INSERT INTO
    fornecedor
VALUES
    (
        00012301443002,
        'DB MEDICAMENTOS',
        'MARIA
DAS DORES',
        'RUA TREZE',
        'PETROLINA',
        440,
        'PE'
    );

INSERT INTO
    fornecedor
VALUES
    (
        00012301443232,
        'BANCO MEDICAMENTOS
CONTROLADOS',
        'JOSE DE MATOS',
        'RUA DAS GRAÇAS',
        'JUAZEIRO',
        770,
        'BA'
    );

INSERT INTO
    fornecedor
VALUES
    (
        00022303113002,
        'DB SP MED',
        'ALTO
NORTE',
        'RUA 7',
        'SAO PAULO',
        120,
        'SP'
    );

END;

--VENDA
BEGIN
INSERT INTO
    Venda
VALUES
    (
        01,
        19006207071,
        10123453401,
        TO_DATE('12/12/2018', 'MM/DD/YYYY'),
        0.2,
        100.00
    );

INSERT INTO
    Venda
VALUES
    (
        02,
        30765713039,
        10123453401,
        TO_DATE('12/12/2018', 'MM/DD/YYYY'),
        null,
        10.00
    );

INSERT INTO
    Venda
VALUES
    (
        03,
        30765713039,
        11113398043,
        TO_DATE('03/01/2019', 'MM/DD/YYYY'),
        null,
        50.00
    );

END;

--Compra
BEGIN
INSERT INTO
    COMPRA
VALUES
    (
        01,
        10123453401,
        00012301443002,
        320,
        TO_DATE('10/10/2018', 'MM/DD/YYYY')
    );

INSERT INTO
    COMPRA
VALUES
    (
        02,
        94428187084,
        00012301443232,
        180,
        TO_DATE('09/10/2018', 'MM/DD/YYYY')
    );

INSERT INTO
    COMPRA
VALUES
    (
        03,
        94428187084,
        00022303113002,
        703.35,
        TO_DATE('08/10/2018', 'MM/DD/YYYY')
    );

INSERT INTO
    COMPRA
VALUES
    (
        04,
        94428187084,
        00022303113002,
        65,
        TO_DATE('08/10/2018', 'MM/DD/YYYY')
    );

INSERT INTO
    COMPRA
VALUES
    (
        05,
        94428187084,
        00022303113002,
        80,
        TO_DATE('08/10/2018', 'MM/DD/YYYY')
    );

END;

--Sold Itens
BEGIN
INSERT INTO
    ITENSVENDIDOS
VALUES
    (01, 01, 10);

INSERT INTO
    ITENSVENDIDOS
VALUES
    (02, 02, 15);

INSERT INTO
    ITENSVENDIDOS
VALUES
    (03, 03, 5);

INSERT INTO
    ITENSVENDIDOS
VALUES
    (02, 03, 4);

END;

--Itens Comprados
BEGIN
INSERT INTO
    ITENSCOMPRADOS
VALUES
    (01, 04, 40, TO_DATE('10/10/2020', 'MM/DD/YYYY'));

INSERT INTO
    ITENSCOMPRADOS
VALUES
    (02, 01, 15, TO_DATE('10/10/2020', 'MM/DD/YYYY'));

INSERT INTO
    ITENSCOMPRADOS
VALUES
    (03, 02, 5, TO_DATE('10/10/2021', 'MM/DD/YYYY'));

INSERT INTO
    ITENSCOMPRADOS
VALUES
    (04, 03, 13, TO_DATE('10/10/2021
', 'MM/DD/YYYY'));

INSERT INTO
    ITENSCOMPRADOS
VALUES
    (05, 05, 20, TO_DATE('10/10/2024', 'MM/DD/YYYY'));

END;

--Telefone Funcionarios
BEGIN
INSERT INTO
    TELEFONE_FUN
VALUES
    (01, 10123453401, 988786755, 87);

INSERT INTO
    TELEFONE_FUN
VALUES
    (02, 10123453401, 988665555, 87);

INSERT INTO
    TELEFONE_FUN
VALUES
    (01, 11113398043, 123443215, 74);

INSERT INTO
    TELEFONE_FUN
VALUES
    (01, 94428187084, 123412345, 74);

END;

--Telefone Fornecedor
BEGIN
INSERT INTO
    TELEFONE_FOR
VALUES
    (01, 00012301443002, 988786733, 87);

INSERT INTO
    TELEFONE_FOR
VALUES
    (02, 00012301443002, 988665533, 87);

INSERT INTO
    TELEFONE_FOR
VALUES
    (01, 00012301443232, 123443233, 74);

INSERT INTO
    TELEFONE_FOR
VALUES
    (01, 00022303113002, 123412333, 74);

END;