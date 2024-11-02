-- Definição das Tabelas

CREATE TABLE odonto_atendimento (
    id_atendimento NUMBER NOT NULL,
    data_hora_atendimento DATE,
    descricao VARCHAR2(100),
    custo NUMBER,
    clinica_id_clinica NUMBER NOT NULL,
    paciente_pacienteid NUMBER NOT NULL,
    procedimento_id_procedimento NUMBER NOT NULL,
    PRIMARY KEY (id_atendimento)
);

CREATE TABLE odonto_carteirinha (
    id_carteirinha CHAR NOT NULL,
    numero VARCHAR2(30),
    emissao DATE,
    validade DATE,
    paciente_pacienteid NUMBER NOT NULL,
    plano_id_plano NUMBER NOT NULL,
    PRIMARY KEY (plano_id_plano),
    UNIQUE (paciente_pacienteid)
);

CREATE TABLE odonto_cidade (
    id_cidade NUMBER NOT NULL,
    cidade VARCHAR2(100),
    estado_id_estado NUMBER NOT NULL,
    PRIMARY KEY (id_cidade)
);

CREATE TABLE odonto_clinica (
    id_clinica NUMBER NOT NULL,
    descricao VARCHAR2(30),
    cnpj VARCHAR2(14),
    email_representante VARCHAR2(30),
    tipo_usuario_id_tipo_usuario NUMBER NOT NULL,
    razao_social VARCHAR2(30),
    PRIMARY KEY (id_clinica)
);

CREATE TABLE odonto_clinica_doutores (
    id_clinica_doutores NUMBER NOT NULL,
    data_relacionamento DATE,
    data_fim_relacionamento DATE,
    doutor_id_doutor NUMBER NOT NULL,
    clinica_id_clinica NUMBER NOT NULL,
    PRIMARY KEY (id_clinica_doutores)
);

CREATE TABLE odonto_doutor (
    id_doutor NUMBER NOT NULL,
    nome VARCHAR2(30),
    crm VARCHAR2(6),
    tipo_usuario_id_tipo_usuario NUMBER NOT NULL,
    cpf VARCHAR2(11),
    PRIMARY KEY (id_doutor)
);

CREATE TABLE odonto_endereco (
    id_endereco NUMBER NOT NULL,
    rua VARCHAR2(150),
    complemento VARCHAR2(50),
    cep VARCHAR2(10),
    cidade_id_cidade NUMBER NOT NULL,
    numero NUMBER,
    PRIMARY KEY (id_endereco)
);

CREATE TABLE odonto_estado (
    id_estado NUMBER NOT NULL,
    estado NUMBER(100),
    pais_id_pais NUMBER NOT NULL,
    PRIMARY KEY (id_estado)
);

CREATE TABLE odonto_paciente (
    pacienteid NUMBER NOT NULL,
    nome VARCHAR2(100),
    cpf VARCHAR2(11),
    email VARCHAR2(100),
    data_nascimento DATE,
    telefone VARCHAR2(11),
    endereco_id_endereco NUMBER NOT NULL,
    tipo_usuario_id_tipo_usuario NUMBER NOT NULL,
    PRIMARY KEY (pacienteid)
);

CREATE TABLE odonto_pais (
    id_pais NUMBER NOT NULL,
    pais VARCHAR2(100),
    PRIMARY KEY (id_pais)
);

CREATE TABLE odonto_plano (
    id_plano NUMBER NOT NULL,
    nome VARCHAR2(30),
    descricao VARCHAR2(50),
    preco NUMBER,
    ativo CHAR(1),
    PRIMARY KEY (id_plano)
);

CREATE TABLE odonto_procedimento (
    id_procedimento NUMBER NOT NULL,
    descricao VARCHAR2(100),
    orcamento_medio NUMBER,
    PRIMARY KEY (id_procedimento)
);

CREATE TABLE odonto_sinistro (
    id_sinistro NUMBER NOT NULL,
    custo_excedente NUMBER,
    data_sinistro DATE,
    atendimento_id_atendimento NUMBER NOT NULL,
    PRIMARY KEY (id_sinistro),
    UNIQUE (atendimento_id_atendimento)
);

CREATE TABLE odonto_tipo_usuario (
    id_tipo_usuario NUMBER NOT NULL,
    atribuicao VARCHAR2(10),
    PRIMARY KEY (id_tipo_usuario)
);

-- Relacionamentos de Chaves Estrangeiras

ALTER TABLE odonto_atendimento
    ADD CONSTRAINT atendimento_clinica_fk FOREIGN KEY (clinica_id_clinica) REFERENCES odonto_clinica (id_clinica);

ALTER TABLE odonto_atendimento
    ADD CONSTRAINT atendimento_paciente_fk FOREIGN KEY (paciente_pacienteid) REFERENCES odonto_paciente (pacienteid);

ALTER TABLE odonto_atendimento
    ADD CONSTRAINT atendimento_procedimento_fk FOREIGN KEY (procedimento_id_procedimento) REFERENCES odonto_procedimento (id_procedimento);

ALTER TABLE odonto_carteirinha
    ADD CONSTRAINT carteirinha_paciente_fk FOREIGN KEY (paciente_pacienteid) REFERENCES odonto_paciente (pacienteid);

ALTER TABLE odonto_carteirinha
    ADD CONSTRAINT carteirinha_plano_fk FOREIGN KEY (plano_id_plano) REFERENCES odonto_plano (id_plano);

ALTER TABLE odonto_cidade
    ADD CONSTRAINT cidade_estado_fk FOREIGN KEY (estado_id_estado) REFERENCES odonto_estado (id_estado);

ALTER TABLE odonto_clinica_doutores
    ADD CONSTRAINT clinica_doutores_clinica_fk FOREIGN KEY (clinica_id_clinica) REFERENCES odonto_clinica (id_clinica);

ALTER TABLE odonto_clinica_doutores
    ADD CONSTRAINT clinica_doutores_doutor_fk FOREIGN KEY (doutor_id_doutor) REFERENCES odonto_doutor (id_doutor);

ALTER TABLE odonto_clinica
    ADD CONSTRAINT clinica_tipo_usuario_fk FOREIGN KEY (tipo_usuario_id_tipo_usuario) REFERENCES odonto_tipo_usuario (id_tipo_usuario);

ALTER TABLE odonto_doutor
    ADD CONSTRAINT doutor_tipo_usuario_fk FOREIGN KEY (tipo_usuario_id_tipo_usuario) REFERENCES odonto_tipo_usuario (id_tipo_usuario);

ALTER TABLE odonto_endereco
    ADD CONSTRAINT endereco_cidade_fk FOREIGN KEY (cidade_id_cidade) REFERENCES odonto_cidade (id_cidade);

ALTER TABLE odonto_estado
    ADD CONSTRAINT estado_pais_fk FOREIGN KEY (pais_id_pais) REFERENCES odonto_pais (id_pais);

ALTER TABLE odonto_paciente
    ADD CONSTRAINT paciente_endereco_fk FOREIGN KEY (endereco_id_endereco) REFERENCES odonto_endereco (id_endereco);

ALTER TABLE odonto_paciente
    ADD CONSTRAINT paciente_tipo_usuario_fk FOREIGN KEY (tipo_usuario_id_tipo_usuario) REFERENCES odonto_tipo_usuario (id_tipo_usuario);

ALTER TABLE odonto_sinistro
    ADD CONSTRAINT sinistro_atendimento_fk FOREIGN KEY (atendimento_id_atendimento) REFERENCES odonto_atendimento (id_atendimento);