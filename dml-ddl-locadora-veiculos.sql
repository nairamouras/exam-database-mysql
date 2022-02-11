CREATE DATABASE locadoraVeiculos;
USE locadoraVeiculos;

CREATE TABLE clientes(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME
);

CREATE TABLE pessoas_juridicas(
    clientes_id INT NOT NULL,
    cnpj INT NOT NULL,
    inscricao_estadual INT NOT NULL,
    endereco VARCHAR(60),
    created_at DATETIME NOT NULL,
    updated_at DATETIME,
    CONSTRAINT pk_pessoas_juridicas PRIMARY KEY (clientes_id),
    CONSTRAINT fk_clientes_id_juridicas FOREIGN KEY (clientes_id) REFERENCES clientes(id)
);

CREATE TABLE pessoas_fisicas(
    clientes_id INT NOT NULL,
    sexo VARCHAR(1),
    data_nascimento DATE,
    endereco VARCHAR(60),
    cpf INT NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME,
    CONSTRAINT pk_pessoas_fisicas PRIMARY KEY (clientes_id),
    CONSTRAINT fk_clientes_id_fisicas FOREIGN KEY (clientes_id) REFERENCES clientes(id)

);

CREATE TABLE veiculos(
    placa VARCHAR(7) NOT NULL PRIMARY KEY,
    chassi INT NOT NULL,
    cor VARCHAR(10),
    motor VARCHAR(15),
    quilometragem_atual FLOAT,
    created_at DATETIME NOT NULL,
    updated_at DATETIME
);

CREATE TABLE automoveis(
    veiculos_placa VARCHAR(7) NOT NULL,
    tamanho VARCHAR(10) NOT NULL,
    numero_passageiros INT NOT NULL,
    numero_portas INT NOT NULL,
    acessorios VARCHAR(255),
    tempo_revisao TIME NOT NULL,
    quilometragem_media_diaria FLOAT NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME,
    CONSTRAINT pk_automoveis PRIMARY KEY (veiculos_placa),
    CONSTRAINT fk_veiculos_placa_automoveis FOREIGN KEY (veiculos_placa) REFERENCES veiculos(placa)
);

CREATE TABLE camionetas_passageiros(
    veiculos_placa VARCHAR(7) NOT NULL,
    tamanho VARCHAR(10) NOT NULL,
    numero_passageiros INT NOT NULL,
    numero_portas INT NOT NULL,
    acessorios VARCHAR(255),
    tempo_revisao TIME NOT NULL,
    quilometragem_media_diaria FLOAT NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME,
    CONSTRAINT pk_camionetas_passageiros PRIMARY KEY (veiculos_placa),
    CONSTRAINT fk_veiculos_placa_camionetas_passageiros FOREIGN KEY (veiculos_placa) REFERENCES veiculos(placa)
);

CREATE TABLE camionetas_carga(
    veiculos_placa VARCHAR(7) NOT NULL,
    capacidade_carga FLOAT NOT NULL,
    tempo_revisao TIME NOT NULL,
    quilometragem_media_diaria FLOAT NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME,
    CONSTRAINT pk_camionetas_carga PRIMARY KEY (veiculos_placa),
    CONSTRAINT fk_veiculos_placa_camionetas_carga FOREIGN KEY (veiculos_placa) REFERENCES veiculos(placa)
);

CREATE TABLE revisoes(
    veiculos_placa VARCHAR(7) NOT NULL,
    data_prox_revisao DATE NOT NULL,
    data_ult_revisao DATE NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME,
    CONSTRAINT fk_veiculos_placa_revisoes FOREIGN KEY (veiculos_placa) REFERENCES veiculos(placa)
);

CREATE TABLE filiais(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cidade VARCHAR(20),
    estado VARCHAR(2) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME
);

CREATE TABLE veiculos_alugados(
    veiculos_placa VARCHAR(7) NOT NULL,
    filiais_id INT NOT NULL,
    clientes_id INT NOT NULL,
    data_entrega DATE NOT NULL,
    filial_entrega INT NOT NULL,
    numero_habilitacao INT NOT NULL,
    vencimento_habilitacao DATE NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME,
    CONSTRAINT fk_veiculos_placa_alugados FOREIGN KEY (veiculos_placa) REFERENCES veiculos(placa),
    CONSTRAINT fk_clientes_id_alugados FOREIGN KEY (clientes_id) REFERENCES clientes(id),
    CONSTRAINT fk_filiais_id_alugados FOREIGN KEY (filiais_id) REFERENCES filiais(id)
);

CREATE TABLE veiculos_disponiveis(
    veiculos_placa VARCHAR(7) NOT NULL,
    filiais_id INT NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME,
    CONSTRAINT fk_veiculos_placa_disponiveis FOREIGN KEY (veiculos_placa) REFERENCES veiculos(placa),
    CONSTRAINT fk_filiais_id_disponiveis FOREIGN KEY (filiais_id) REFERENCES filiais(id)
);

CREATE TABLE reservas_veiculos(
    veiculos_placa VARCHAR(7) NOT NULL,
    filiais_id INT NOT NULL,
    data_disponivel DATE NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME,
    CONSTRAINT fk_veiculos_placa_reservas FOREIGN KEY (veiculos_placa) REFERENCES veiculos(placa),
    CONSTRAINT fk_filiais_id_reservas FOREIGN KEY (filiais_id) REFERENCES filiais(id)
);

SHOW TABLES;
DESCRIBE clientes;
DESCRIBE veiculos;
DESCRIBE filiais;
DESCRIBE pessoas_fisicas;
DESCRIBE veiculos_alugados;

INSERT INTO clientes VALUES(1, 'Naíra', "2021-10-26 00:30:00", NULL);
INSERT INTO clientes VALUES(2, 'Luiz', "2021-10-26 00:31:00", NULL);

SELECT nome FROM clientes WHERE nome = 'Naíra';
SELECT nome, id FROM clientes WHERE nome = 'Luiz';

INSERT INTO pessoas_fisicas VALUES(1, 'F', "2001-03-30", 'Cuiabá-MT', 2876754, "2021-10-26 00:35:00", NULL);
INSERT INTO pessoas_fisicas VALUES(2, 'M', "1997-11-19", 'Cuiabá-MT', 2323134, "2021-10-26 00:37:00", NULL);

INSERT INTO filiais VALUES(1, 'Curitiba','PR', "2021-10-27 14:55:00", NULL);
INSERT INTO filiais VALUES(2, 'Londrina','PR', "2021-10-27 14:55:00", NULL);

INSERT INTO veiculos VALUES('CBA7897', 7567, 'branco', 'v6', '10.6', "2021-10-26 00:41:00", NULL);
INSERT INTO veiculos VALUES('ERF5678', 756787, 'preto', 'v8', '18.6', "2021-10-26 00:41:00", NULL);

INSERT INTO automoveis VALUES('CBA7897', 'Grande', 4, 4, 'Ar-condicionado, rádio', "04:00:00", 20.0, "2021-10-26 00:50:00", NULL);

INSERT INTO revisoes VALUES('ERF5678', "2021-11-09", "2021-10-20", "2021-10-26 00:53:00", NULL);

SELECT * FROM veiculos;
SELECT * FROM revisoes;
SELECT * FROM automoveis;

SELECT nome FROM clientes WHERE nome LIKE 'N%%';
SELECT tamanho FROM automoveis WHERE acessorios LIKE '%%rádio%%';

INSERT INTO reservas_veiculos VALUES('ERF5678', 1, "10-11-2021", "2021-10-27 14:57:00", NULL);
INSERT INTO veiculos_alugados VALUES('CBA7897', 1, 2, "2021-10-30", 2, 3452236, "2025-07-14", "2021-10-27 14:57:00", NULL);

SELECT * FROM reservas_veiculos;
SELECT clientes_id FROM veiculos_alugados WHERE placa = 'CBA7897';



