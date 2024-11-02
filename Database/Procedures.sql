--procedures CRUD usadas em Java

--===PACIENTES

CREATE OR REPLACE PROCEDURE INSERT_ODONTO_PACIENTE(
    p_data_nascimento DATE,
    p_endereco_id NUMBER,
    p_cpf VARCHAR2,
    p_email VARCHAR2,
    p_nome VARCHAR2,
    p_telefone VARCHAR2
) AS
BEGIN
    INSERT INTO ODONTO_PACIENTE (DATA_NASCIMENTO, ENDERECO_ID, CPF, EMAIL, NOME, TELEFONE)
    VALUES (p_data_nascimento, p_endereco_id, p_cpf, p_email, p_nome, p_telefone);
END;

CREATE OR REPLACE PROCEDURE UPDATE_ODONTO_PACIENTE(
    p_id NUMBER,
    p_data_nascimento DATE,
    p_endereco_id NUMBER,
    p_cpf VARCHAR2,
    p_email VARCHAR2,
    p_nome VARCHAR2,
    p_telefone VARCHAR2
) AS
BEGIN
    UPDATE ODONTO_PACIENTE
    SET DATA_NASCIMENTO = p_data_nascimento,
        ENDERECO_ID = p_endereco_id,
        CPF = p_cpf,
        EMAIL = p_email,
        NOME = p_nome,
        TELEFONE = p_telefone
    WHERE ID = p_id;
END;


CREATE OR REPLACE PROCEDURE DELETE_ODONTO_PACIENTE(
    p_id NUMBER
) AS
BEGIN
    DELETE FROM ODONTO_PACIENTE WHERE ID = p_id;
END;

commit;


--===CLINICAS

CREATE OR REPLACE PROCEDURE INSERT_ODONTO_CLINICA(
    p_cnpj VARCHAR2,
    p_descricao VARCHAR2,
    p_email_representante VARCHAR2,
    p_razao_social VARCHAR2,
    p_endereco_id NUMBER
) AS
BEGIN
    INSERT INTO ODONTO_CLINICA (CNPJ, DESCRICAO, EMAIL_REPRESENTANTE, RAZAO_SOCIAL, ENDERECO_ID)
    VALUES (p_cnpj, p_descricao, p_email_representante, p_razao_social, p_endereco_id);
END;



CREATE OR REPLACE PROCEDURE UPDATE_ODONTO_CLINICA(
    p_id NUMBER,
    p_cnpj VARCHAR2,
    p_descricao VARCHAR2,
    p_email_representante VARCHAR2,
    p_razao_social VARCHAR2,
    p_endereco_id NUMBER
) AS
BEGIN
    UPDATE ODONTO_CLINICA
    SET CNPJ = p_cnpj,
        DESCRICAO = p_descricao,
        EMAIL_REPRESENTANTE = p_email_representante,
        RAZAO_SOCIAL = p_razao_social,
        ENDERECO_ID = p_endereco_id
    WHERE ID = p_id;
END;


CREATE OR REPLACE PROCEDURE DELETE_ODONTO_CLINICA(
    p_id NUMBER
) AS
BEGIN
    DELETE FROM ODONTO_CLINICA
    WHERE ID = p_id;
END;

commit;
