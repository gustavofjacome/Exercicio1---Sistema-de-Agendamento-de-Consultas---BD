
CREATE TABLE Pessoa (
    cpf        CHAR(11)     NOT NULL,
    email      VARCHAR(50)  NOT NULL,
    nome       VARCHAR(150) NOT NULL,
    data_nasc  DATE         NOT NULL,
    endereco   VARCHAR(300) NOT NULL, 
    telefone   VARCHAR(15)  NULL,

    CONSTRAINT pessoa_pk PRIMARY KEY (cpf),
    CONSTRAINT pessoa_un UNIQUE (email, nome)
);

CREATE TABLE Paciente (
    cpf_pessoa   CHAR(11)    NOT NULL,
    senha        VARCHAR(20) NOT NULL,
    plano_saude  BOOLEAN     NOT NULL DEFAULT FALSE,

    CONSTRAINT paciente_pk PRIMARY KEY (cpf_pessoa),
    CONSTRAINT paciente_pessoa_fk FOREIGN KEY (cpf_pessoa)
        REFERENCES Pessoa (cpf),
    CONSTRAINT paciente_senha_ck CHECK (senha ~ '^[A-Za-z0-9]{5,10}$')
);

CREATE TABLE Medico (
    cpf_pessoa  CHAR(11)    NOT NULL,
    crm         VARCHAR(10) NOT NULL,

    CONSTRAINT medico_pk PRIMARY KEY (cpf_pessoa),
    CONSTRAINT medico_pessoa_fk FOREIGN KEY (cpf_pessoa)
        REFERENCES Pessoa (cpf),
    CONSTRAINT medico_crm_un UNIQUE (crm)
);

CREATE TABLE Especialidade (
    id         INT GENERATED ALWAYS AS IDENTITY,
    descricao  VARCHAR(300) NOT NULL,

    CONSTRAINT especialidade_pk PRIMARY KEY (id)
);

CREATE TABLE MedicoEspecialidade (
    cpf_medico        CHAR(11) NOT NULL,
    id_especialidade  INT      NOT NULL,

    CONSTRAINT medicoespecialidade_pk PRIMARY KEY (cpf_medico, id_especialidade),
    CONSTRAINT medicoespecialidade_medico_fk FOREIGN KEY (cpf_medico)
        REFERENCES Medico (cpf_pessoa),
    CONSTRAINT medicoespecialidade_especialidade_fk FOREIGN KEY (id_especialidade)
        REFERENCES Especialidade (id)
);

CREATE TABLE Agendamento (
    cpf_paciente    CHAR(11)         NOT NULL,
    cpf_medico      CHAR(11)         NOT NULL,
    dh_consulta     TIMESTAMP        NOT NULL,
    dh_agendamento  TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    valor_consulta  DOUBLE PRECISION NOT NULL DEFAULT 0.0,
    
    CONSTRAINT agendamento_pk PRIMARY KEY (cpf_paciente, cpf_medico, dh_consulta),
    CONSTRAINT agendamento_paciente_fk FOREIGN KEY (cpf_paciente)
        REFERENCES Paciente (cpf_pessoa),
    CONSTRAINT agendamento_medico_fk FOREIGN KEY (cpf_medico)
        REFERENCES Medico (cpf_pessoa)
);