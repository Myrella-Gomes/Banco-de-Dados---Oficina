CREATE DATABASE Oficina;
USE Oficina;

CREATE TABLE IF NOT EXISTS Cliente (
  idcliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(45) NOT NULL,
  sobrenome VARCHAR(45) NOT NULL,
  contato VARCHAR(45) NOT NULL,
  razão_social CHAR(15) NOT NULL
  );

  CREATE TABLE IF NOT EXISTS Pagamento(
  idPagamento INT NOT NULL AUTO_INCREMENT,
  Forma_de_pagamento VARCHAR(45) NOT NULL,
  agência varchar (16) DEFAULT ('nao informado'),
  conta varchar (16) DEFAULT ('nao informado'),
  Cliente_idcliente INT NOT NULL,
  PRIMARY KEY (idPagamento, Cliente_idcliente),
  INDEX fk_Pagamento_Cliente1_idx (Cliente_idcliente ASC) VISIBLE,
  CONSTRAINT fk_Pagamento_Cliente1
    FOREIGN KEY (Cliente_idcliente)
    REFERENCES Cliente (idcliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE IF NOT EXISTS Funcionários(
  idfuncionários INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  endereço VARCHAR(45) NOT NULL,
  especialidade VARCHAR(45) NOT NULL,
  contato VARCHAR(14) NOT NULL,
  PRIMARY KEY (idfuncionários));
  
CREATE TABLE IF NOT EXISTS Veículo(
  idVeículo INT NOT NULL AUTO_INCREMENT,
  Tipo VARCHAR(45) NOT NULL,
  cor CHAR(9) NOT NULL,
  marca VARCHAR(20) NOT NULL,
  Cliente_idcliente INT NOT NULL,
  Funcionários_idfuncionários INT NOT NULL,
  PRIMARY KEY (idVeículo, Cliente_idcliente, Funcionários_idfuncionários),
  INDEX fk_Veículo_Cliente_idx (Cliente_idcliente ASC) VISIBLE,
  INDEX fk_Veículo_Funcionários1_idx (Funcionários_idfuncionários ASC) VISIBLE,
  CONSTRAINT fk_Veículo_Cliente
    FOREIGN KEY (Cliente_idcliente)
    REFERENCES Cliente (idcliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Veículo_Funcionários1
    FOREIGN KEY (Funcionários_idfuncionários)
    REFERENCES Funcionários (idfuncionários)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE IF NOT EXISTS Ordem_de_Serviço(
  idordemdeserviços INT NOT NULL AUTO_INCREMENT,
  Número INT NOT NULL,
  Data_de_Emissão DATE NOT NULL,
  Status_ VARCHAR(45) NOT NULL,
  Data_de_conclusão DATE NULL,
  Serviço VARCHAR(45) NOT NULL,
  Funcionários_idfuncionários INT NOT NULL,
  Cliente_idcliente INT NOT NULL,
  PRIMARY KEY (idordemdeserviços, Funcionários_idfuncionários, Cliente_idcliente),
  INDEX fk_Ordem_de_Serviço_Funcionários1_idx (Funcionários_idfuncionários ASC) VISIBLE,
  INDEX fk_Ordem_de_Serviço_Cliente1_id (Cliente_idcliente ASC) VISIBLE,
  CONSTRAINT fk_Ordem_de_Serviço_Funcionários1
    FOREIGN KEY (Funcionários_idfuncionários)
    REFERENCES Funcionários (idfuncionários)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Ordem_de_Serviço_Cliente1
    FOREIGN KEY (Cliente_idcliente)
    REFERENCES Cliente (idcliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE IF NOT EXISTS Serviços (
  idServiços INT NOT NULL AUTO_INCREMENT,
  Tipo_de_serviço VARCHAR(45) NOT NULL,
  Valor_do_serviço DECIMAL NOT NULL,
  Valor_mâo_de_obra DECIMAL NOT NULL,
  Valor_das_pecas DECIMAL NOT NULL,
  Ordem_de_Serviço_idserviços INT NOT NULL,
  PRIMARY KEY (idServiços, Ordem_de_Serviço_idserviços),
  INDEX fk_Serviços_Ordem_de_Serviço1_idx (Ordem_de_Serviço_idserviços ASC) VISIBLE,
  CONSTRAINT fk_Serviços_Ordem_de_Serviço1
    FOREIGN KEY (Ordem_de_Serviço_idserviços)
    REFERENCES Ordem_de_Serviço (idordemdeserviços)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
Insert into Cliente (nome, sobrenome, contato, razão_social)
Values 
	('Myrella', 'Gomes', '81996750987', '80767598614'),
	('Gabriel', 'Gomes', '81964598268', '12345678910'),
    ('Emellyn', 'Silva', '98979876654', '34576589254'),
    ('Thiago', 'Freire', '81998765432', '08798765432');
    
Insert into Pagamento (Forma_de_pagamento, agência, conta, Cliente_idcliente)
Values
	('Cartão de Credito', '13837', '874352', 1),
    ('Cartão de Débito', '37589', '849247', 2),
	('Dinheiro', DEFAULT, DEFAULT, 3),
	('Pix', DEFAULT, DEFAULT, 4);

Insert into Funcionários (nome, endereço, especialidade, contato)
Values
	('Caio', 'Igarassu', 'Reparos', '98979876654'),
	('Daniele', 'Paulista', 'Reparos', '81767689884'),
    ('Junior', 'Silva', 'Reparos', '81997965432'),
    ('Thiago', 'Costa', 'Reparos', '8199865432');
    
INSERT INTO Ordem_de_Serviço (Número, Data_de_Emissão, Status_, Data_de_conclusão, Serviço, Funcionários_idfuncionários, Cliente_idcliente)
Values 
	(1,'2024-12-12', 'Em andamento', '2024-12-27', 'Reparo', 1, 1),
	(2,'2024-12-13', 'Em andamento', '2024-12-29', 'Reparo', 2, 2),
	(3,'2024-12-12', 'Em andamento', '2024-12-28', 'Reparo', 3, 3),
    (4,'2024-12-13', 'Em andamento', '2024-12-30', 'Reparo', 4, 4);
    
INSERT INTO Serviços (Tipo_de_serviço, Valor_do_serviço, Valor_mâo_de_obra, Valor_das_pecas, Ordem_de_Serviço_idserviços) 
VALUES 
	('Reparo', 500.00, 300.00, 200.00, 1),
    ('Reparo', 700.00, 500.00, 200.00, 2),
    ('Reparo', 300.00, 200.00, 100.00, 3),
    ('Reparo', 150.00, 100.00, 50.00, 4);

INSERT INTO Veículo (Tipo, cor, marca, Cliente_idcliente, Funcionários_idfuncionários) 
	VALUES 
	('Carro', 'azul', 'fiat', 1, 1),
    ('Moto', 'preto', 'harley', 2, 2),
	('Carro', 'vermelho', 'chevrolet', 3, 3),
	('Moto', 'cinza', 'yamaha', 4, 4);
    
-- Query que retorna o nome completo dos clientes, produtos comprados e valor da compra
Select
	idcliente,
    id,
	concat(nome, ' ', nome_do_meio, ' ', sobrenome) as 'NOME COMPLETO',
    descricao as 'Produtos comprados',
    valor as 'Valor da Compra'
From Cliente c
Join clientes c on p.id_cliente = c.id_cliente;