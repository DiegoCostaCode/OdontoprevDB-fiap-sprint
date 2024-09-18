-- Criar sequências primeiro
CREATE SEQUENCE CH_CIDADE_CIDADE_ID_SEQ START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE CH_CLINICA_CLINICA_ID_SEQ START WITH 1 NOCACHE ORDER;
CREATE SEQUENCE CH_CONVENIO_CONVENIO_ID_SEQ START WITH 1 NOCACHE ORDER;

-- Criar tabelas principais primeiro
CREATE TABLE CH_PAIS (
    ID        NUMBER PRIMARY KEY NOT NULL,
    DESCRICAO VARCHAR2(50)
);

CREATE TABLE CH_ESTADO (
    ID        NUMBER PRIMARY KEY NOT NULL,
    DESCRICAO VARCHAR2(50),
    PAIS_ID   NUMBER NOT NULL,
    CONSTRAINT CH_ESTADO_PAIS_FK FOREIGN KEY (PAIS_ID) REFERENCES CH_PAIS(ID)
);

CREATE TABLE CH_CIDADE (
    CIDADE_ID NUMBER PRIMARY KEY NOT NULL,
    DESCRICAO VARCHAR2(50),
    ESTADO_ID NUMBER NOT NULL,
    CONSTRAINT CH_CIDADE_ESTADO_FK FOREIGN KEY (ESTADO_ID) REFERENCES CH_ESTADO(ID)
);

CREATE TABLE CH_BAIRRO (
    ID               NUMBER PRIMARY KEY NOT NULL,
    DESCRICAO        VARCHAR2(50),
    DESCRICAO_RUA    VARCHAR2(50),
    NUMERO           NUMBER(7),
    CEP              NUMBER(8),
    CIDADE_ID NUMBER NOT NULL,
    CONSTRAINT CH_BAIRRO_CIDADE_FK FOREIGN KEY (CIDADE_ID) REFERENCES CH_CIDADE(CIDADE_ID)
);

CREATE TABLE CH_ENDERECO (
    ID        NUMBER PRIMARY KEY NOT NULL,
    ID_PAIS   NUMBER,
    ID_ESTADO NUMBER,
    ID_CIDADE NUMBER,
    ID_BAIRRO NUMBER,
    CONSTRAINT CH_ENDERECO_PAIS_FK FOREIGN KEY (ID_PAIS) REFERENCES CH_PAIS(ID),
    CONSTRAINT CH_ENDERECO_ESTADO_FK FOREIGN KEY (ID_ESTADO) REFERENCES CH_ESTADO(ID),
    CONSTRAINT CH_ENDERECO_CIDADE_FK FOREIGN KEY (ID_CIDADE) REFERENCES CH_CIDADE(CIDADE_ID),
    CONSTRAINT CH_ENDERECO_BAIRRO_FK FOREIGN KEY (ID_BAIRRO) REFERENCES CH_BAIRRO(ID)
);

CREATE TABLE CH_CONVENIO (
    CONVENIO_ID NUMBER PRIMARY KEY NOT NULL,
    NOME_CONVENIO VARCHAR2(100),
    DESCRICAO     VARCHAR2(100),
    PRECO         NUMBER(7)
);

CREATE TABLE CH_CLINICA (
    CLINICA_ID NUMBER PRIMARY KEY NOT NULL,
    DESCRICAO           VARCHAR2(200),
    CNPJ                NUMBER(14),
    EMAIL_REPRESENTANTE VARCHAR2(100),
    ID_ENDERECO           NUMBER,
    CONSTRAINT CH_CLINICA_BAIRRO_FK FOREIGN KEY (ID_ENDERECO) REFERENCES CH_ENDERECO(ID)
);

CREATE TABLE CH_DOUTOR (
    ID                 NUMBER PRIMARY KEY NOT NULL,
    NOME               VARCHAR2(50),
    CPF                NUMBER(11),
    EMAIL              VARCHAR2(100),
    NASCIMENTO         DATE,
    TELEFONE           NUMBER(16),
    CLINICA_ID NUMBER NOT NULL,
    CONSTRAINT CH_DOUTOR_CLINICA_FK FOREIGN KEY (CLINICA_ID) REFERENCES CH_CLINICA(CLINICA_ID)
);

CREATE TABLE CH_USUARIO (
    ID                   NUMBER PRIMARY KEY NOT NULL,
    NOME                 VARCHAR2(50),
    CPF                  NUMBER(11),
    EMAIL                VARCHAR2(100),
    NASCIMENTO           DATE,
    TELEFONE             NUMBER(16),
    CONVENIO_ID NUMBER NOT NULL,
    ENDERECO_ID          NUMBER NOT NULL,
    CONSTRAINT CH_USUARIO_CONVENIO_FK FOREIGN KEY (CONVENIO_ID) REFERENCES CH_CONVENIO(CONVENIO_ID),
    CONSTRAINT CH_USUARIO_ENDERECO_FK FOREIGN KEY (ENDERECO_ID) REFERENCES CH_ENDERECO(ID)
);

CREATE TABLE CH_CARTEIRINHA(
    ID NUMBER PRIMARY KEY NOT NULL,
    NUMERO VARCHAR2(10),
    EMISSAO DATE,
    VALIDADE DATE,
    USUARIO_ID NUMBER NOT NULL,
    CONVENIO_ID NUMBER NOT NULL,
    CONSTRAINT CH_DONO_CARTEIRINHA_FK FOREIGN KEY (CONVENIO_ID) REFERENCES CH_USUARIO(ID),
    CONSTRAINT CH_TIPO_CONVENIO_FK FOREIGN KEY (CONVENIO_ID) REFERENCES CH_CONVENIO(CONVENIO_ID)
);

CREATE TABLE CH_CONSULTA (
    ID         NUMBER PRIMARY KEY NOT NULL,
    DATA       DATE,
    HORARIO    TIMESTAMP,
    DESCRICAO  VARCHAR2(100),
    CLINICA_ID NUMBER,
    DOUTOR_ID  NUMBER NOT NULL,
    USUARIO_ID NUMBER NOT NULL,
    CONSTRAINT CH_CONSULTA_CLINICA_FK FOREIGN KEY (CLINICA_ID) REFERENCES CH_CLINICA(CLINICA_ID),
    CONSTRAINT CH_CONSULTA_DOUTOR_FK FOREIGN KEY (DOUTOR_ID) REFERENCES CH_DOUTOR(ID),
    CONSTRAINT CH_CONSULTA_USUARIO_FK FOREIGN KEY (USUARIO_ID) REFERENCES CH_USUARIO(ID)
);
