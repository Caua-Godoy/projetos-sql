CREATE DATABASE biblioteca;

-- Criação livro

CREATE TABLE livro(
codigo 					INT,
categoria 				VARCHAR(20)  NOT NULL,
nr_paginas 				INT 		 NOT NULL,
ISBN 					VARCHAR(17)  NOT NULL,
idioma 					VARCHAR(30)  NOT NULL,
edicao 					INT,
titulo 					VARCHAR(200)  NOT NULL,
ano_publicacao 			INT 		 NOT NULL,
sinopse 				VARCHAR(1000),
editora 				VARCHAR(45)  NOT NULL
);

-- Constraints livro

ALTER TABLE livro
ADD CONSTRAINT PK_livro
PRIMARY KEY (codigo);

ALTER TABLE livro
MODIFY codigo INT AUTO_INCREMENT;

ALTER TABLE livro
ADD CONSTRAINT UK_livro_ISBN
UNIQUE (ISBN);

ALTER TABLE livro
ADD CONSTRAINT CK_livro_ano_publicacao
CHECK (ano_publicacao >= 1000 AND ano_publicacao <= 2025);

-- Criação leitor

CREATE TABLE leitor(
CPF 					CHAR(11),
data_nascimento 		DATE 		 NOT NULL,
data_cadastro 			DATE 		 NOT NULL DEFAULT (CURDATE()),
nome					VARCHAR(50)  NOT NULL,
email					VARCHAR(50)  NOT NULL,
status					CHAR(1)  	 NOT NULL DEFAULT 'A',
tipo					VARCHAR(20)  NOT NULL 
);

-- Constraints leitor

ALTER TABLE leitor
ADD CONSTRAINT PK_leitor
PRIMARY KEY (CPF);

ALTER TABLE leitor
ADD CONSTRAINT UK_leitor_email
UNIQUE (email);

ALTER TABLE leitor
ADD CONSTRAINT CK_leitor_status
CHECK (status IN ('A', 'S', 'I')); -- ativo, suspenso, inadimplente

ALTER TABLE leitor
ADD CONSTRAINT CK_leitor_tipo
CHECK (tipo IN('estudante','professor','funcionário','público geral'));

-- Criação telefone_leitor

CREATE TABLE telefone_leitor(
CPF_leitor 				CHAR(11),
telefone				CHAR(11)
);

-- Cosntraints telefone_leitor

ALTER TABLE telefone_leitor
ADD CONSTRAINT PK_telefone_leitor
PRIMARY KEY (CPF_leitor,telefone);

ALTER TABLE telefone_leitor
ADD CONSTRAINT FK_telefone_leitor__leitor
FOREIGN KEY (CPF_leitor) REFERENCES leitor(CPF);

-- Criação endereco_leitor

CREATE TABLE endereco_leitor(
CPF_leitor				CHAR(11),
CEP						CHAR(8) 	 NOT NULL,
estado					CHAR(2)		 NOT NULL,
cidade					VARCHAR(45)  NOT NULL,
rua 					VARCHAR(45)  NOT NULL,
bairro					VARCHAR(45)  NOT NULL,
numero					INT          NOT NULL
);

-- Constriants endereco_leitor

ALTER TABLE endereco_leitor
ADD CONSTRAINT PK_endereco_leitor
PRIMARY KEY (CPF_leitor);

ALTER TABLE endereco_leitor
ADD CONSTRAINT FK_endereco_leitor__leitor
FOREIGN KEY (CPF_leitor) REFERENCES leitor(CPF);

-- Criação reserva

CREATE TABLE reserva(
codigo					INT,
CPF_leitor				CHAR(11)     NOT NULL,
codigo_livro			INT          NOT NULL,
data_reserva			DATE         NOT NULL DEFAULT (CURDATE()),
data_validade 			DATE         NOT NULL,
status					CHAR(1)      NOT NULL DEFAULT 'A',
posicao_fila			INT
);

-- Constriants reserva

ALTER TABLE reserva
ADD CONSTRAINT PK_reserva
PRIMARY KEY (codigo);

ALTER TABLE reserva
MODIFY codigo INT AUTO_INCREMENT;

ALTER TABLE reserva
ADD CONSTRAINT FK_reserva__leitor
FOREIGN KEY (CPF_leitor) REFERENCES leitor(CPF);

ALTER TABLE reserva
ADD CONSTRAINT FK_reserva__livro
FOREIGN KEY (codigo_livro) REFERENCES livro(codigo);

ALTER TABLE reserva
ADD CONSTRAINT UK_reserva_leitor_livro
UNIQUE (CPF_leitor,codigo_livro);

ALTER TABLE reserva
ADD CONSTRAINT CK_reserva_status
CHECK (status IN('A','E','T','C'));  -- ativa, expirada, atendida, cancelada

-- Criação autor

CREATE TABLE autor(
codigo					INT,
nome					VARCHAR(50)  NOT NULL,
biografia				VARCHAR(100),
nacionalidade			VARCHAR(30)  NOT NULL,
data_nascimento			DATE         NOT NULL
);

-- Constraints autor

ALTER TABLE autor
ADD CONSTRAINT PK_autor
PRIMARY KEY (codigo);

ALTER TABLE autor
  MODIFY codigo INT AUTO_INCREMENT;
  
  -- Criação pseudonimo_autor

CREATE TABLE pseudonimo_autor(
codigo_autor			INT,
pseudonimo				VARCHAR(45)
);

-- Constraints pseudonimo_autor

ALTER TABLE pseudonimo_autor
ADD CONSTRAINT PK_pseudonimo_autor
PRIMARY KEY (codigo_autor,pseudonimo);

ALTER TABLE pseudonimo_autor
ADD CONSTRAINT FK_pseudonimo_autor__autor
FOREIGN KEY (codigo_autor) REFERENCES autor(codigo);

-- Criação livro_autor

CREATE TABLE livro_autor(
codigo_livro			INT,
codigo_autor			INT
);

-- Constraints livro_autor

ALTER TABLE livro_autor
ADD CONSTRAINT PK_livro_autor
PRIMARY KEY (codigo_livro,codigo_autor);

ALTER TABLE livro_autor
ADD CONSTRAINT FK_livro_autor__livro
FOREIGN KEY (codigo_livro) REFERENCES livro(codigo);

ALTER TABLE livro_autor
ADD CONSTRAINT FK_livro_autor__autor
FOREIGN KEY (codigo_autor) REFERENCES autor(codigo);

-- Criação exemplar

CREATE TABLE exemplar(
codigo					INT,
codigo_livro			INT
);

-- Constraints exemplar

ALTER TABLE exemplar
ADD CONSTRAINT PK_exemplar
PRIMARY KEY (codigo);

ALTER TABLE exemplar
  MODIFY codigo INT AUTO_INCREMENT;

ALTER TABLE exemplar
ADD CONSTRAINT FK_exemplar__livro
FOREIGN KEY (codigo_livro) REFERENCES livro(codigo);

-- Criação exemplar_fisico 

CREATE TABLE exemplar_fisico(
codigo_exemplar			INT,
status					CHAR(1)      NOT NULL,
localizacao				VARCHAR(100) NOT NULL,
estado_conservacao		CHAR(1)		 NOT NULL
);

-- Constraints exemplar_fisico

ALTER TABLE exemplar_fisico
ADD CONSTRAINT PK_exemplar_fisico
PRIMARY KEY (codigo_exemplar);

ALTER TABLE exemplar_fisico
 ADD CONSTRAINT FK_exemplar_fisico__exemplar
 FOREIGN KEY (codigo_exemplar) REFERENCES exemplar(codigo);

ALTER TABLE exemplar_fisico
 ADD CONSTRAINT CK_exemplar_fisico_estado_conservacao
 CHECK (estado_conservacao IN('O','B','R','P')); -- Ótimo, Bom, Ruim, Pessimo

ALTER TABLE exemplar_fisico
 ADD CONSTRAINT CK_exemplar_fisico_status
 CHECK (status IN ('D', 'E', 'R', 'M')); -- disponível, emprestado, reservado, manutenção

-- Criação exemplar_digital

CREATE TABLE exemplar_digital(
codigo_exemplar			INT,
link_download			VARCHAR(100) NOT NULL,
nr_licencas				INT 		 NOT NULL,
formato_arquivo			VARCHAR(15)  NOT NULL,
tamanho_arquivo			BIGINT		 NOT NULL
);

-- Constrainst exemplar_digital

ALTER TABLE exemplar_digital
 ADD CONSTRAINT PK_exemplar_digital
 PRIMARY KEY (codigo_exemplar);

ALTER TABLE exemplar_digital
 ADD CONSTRAINT FK_exemplar_digital__exemplar
 FOREIGN KEY (codigo_exemplar) REFERENCES exemplar(codigo);
 
 -- Criação funcionario

CREATE TABLE funcionario(
codigo					INT,
nome					VARCHAR(50)  NOT NULL,
data_admissao			DATE   		 NOT NULL DEFAULT (CURDATE()),
login					VARCHAR(45)  NOT NULL,
senha	 				VARCHAR(255)  NOT NULL,
CPF						CHAR(11)	 NOT NULL,
cargo					VARCHAR(30)  NOT NULL
);

-- Constraints funcionario

ALTER TABLE funcionario
 ADD CONSTRAINT PK_funcionario
 PRIMARY KEY (codigo);

ALTER TABLE funcionario
  MODIFY codigo INT AUTO_INCREMENT;

ALTER TABLE funcionario
 ADD CONSTRAINT UK_funcionario_CPF
 UNIQUE (CPF);

ALTER TABLE funcionario
 ADD CONSTRAINT UK_funcionario_login
 UNIQUE (login);
 
 -- Criação emprestimo

CREATE TABLE emprestimo(
codigo					INT,
codigo_exemplar 		INT			 NOT NULL,
CPF_leitor				CHAR(11)	 NOT NULL,
codigo_funcionario 		INT			 NOT NULL,
data_prev_devolucao     DATE		 NOT NULL,
data_real_devolucao     DATE,
data_emprestimo			DATE         NOT NULL DEFAULT (CURDATE()),
status     				CHAR(1)      NOT NULL,
renovacoes				INT			 NOT NULL DEFAULT 0
);

-- Constraints emprestimo

ALTER TABLE emprestimo
 ADD CONSTRAINT PK_emprestimo
 PRIMARY KEY (codigo);

ALTER TABLE emprestimo
  MODIFY codigo INT AUTO_INCREMENT;

ALTER TABLE emprestimo
 ADD CONSTRAINT FK_emprestimo__exemplar
 FOREIGN KEY (codigo_exemplar) REFERENCES exemplar(codigo);

ALTER TABLE emprestimo
 ADD CONSTRAINT FK_emprestimo__leitor
 FOREIGN KEY (CPF_leitor) REFERENCES leitor(CPF);

ALTER TABLE emprestimo
 ADD CONSTRAINT FK_emprestimo__funcionario
 FOREIGN KEY (codigo_funcionario) REFERENCES funcionario(codigo);

ALTER TABLE emprestimo
 ADD CONSTRAINT CK_emprestimo_renovacoes
 CHECK (renovacoes >= 0 AND renovacoes <= 2);

ALTER TABLE emprestimo
 ADD CONSTRAINT CK_emprestimo_status
 CHECK (status IN ('A', 'D', 'T'));  -- ativo, devolvido, atrasado

-- Criação multa

CREATE TABLE multa(
codigo					INT,
codigo_emprestimo		INT 		 NOT NULL,
status					CHAR(1)      NOT NULL DEFAULT 'P',
valor					FLOAT(5,2)   NOT NULL,
data_geracao			DATE		 NOT NULL DEFAULT(CURDATE())
);

-- Constraints multa

ALTER TABLE multa
 ADD CONSTRAINT PK_multa
 PRIMARY KEY (codigo);

ALTER TABLE multa
  MODIFY codigo INT AUTO_INCREMENT;

ALTER TABLE multa
 ADD CONSTRAINT FK_multa__emprestimo
 FOREIGN KEY (codigo_emprestimo) REFERENCES emprestimo(codigo);

ALTER TABLE multa
 ADD CONSTRAINT CK_multa_status
 CHECK (status IN ('P', 'G', 'C')); -- Pendente, Paga, Cancelada

-- Criação pagamento

CREATE TABLE pagamento(
codigo					INT,
codigo_funcionario		INT 		 NOT NULL,
codigo_multa			INT 		 NOT NULL,
valor_pago				FLOAT(5,2)   NOT NULL,
forma_pagamento			VARCHAR(45)  NOT NULL,
data_pagamento			DATE 		 NOT NULL DEFAULT(CURDATE())
);

-- Constraints pagamento

ALTER TABLE pagamento
 ADD CONSTRAINT PK_pagamento
 PRIMARY KEY (codigo);

ALTER TABLE pagamento
  MODIFY codigo INT AUTO_INCREMENT;

ALTER TABLE pagamento
 ADD CONSTRAINT FK_pagamento__funcionario
 FOREIGN KEY (codigo_funcionario) REFERENCES funcionario(codigo);

ALTER TABLE pagamento
 ADD CONSTRAINT FK_pagamento__multa
 FOREIGN KEY (codigo_multa) REFERENCES multa(codigo);

ALTER TABLE pagamento
 ADD CONSTRAINT CK_pagamento_valor
 CHECK (valor_pago > 0);

ALTER TABLE pagamento
 ADD CONSTRAINT CK_pagamento_forma_pagamento
 CHECK (forma_pagamento IN('Dinheiro','Pix','Cartao'));


-- Criação de Indexes 
CREATE INDEX IDX_livro_titulo ON livro(titulo);
CREATE INDEX IDX_livro_ISBN ON livro(ISBN);
CREATE INDEX IDX_leitor_email ON leitor(email);
CREATE INDEX IDX_emprestimo_devolucao ON emprestimo(data_real_devolucao);
CREATE INDEX IDX_leitor_status ON leitor(status);
CREATE INDEX IDX_emprestimo_status ON emprestimo(status);
CREATE INDEX IDX_multa_status ON multa(status);
CREATE INDEX IDX_reserva_status ON reserva(status);
CREATE INDEX IDX_exemplar_fisico_status ON exemplar_fisico(status);
CREATE INDEX IDX_leitor_tipo ON leitor(tipo);
CREATE INDEX IDX_emprestimo_data_emprestimo ON emprestimo(data_emprestimo);
CREATE INDEX IDX_emprestimo_data_prev_devolucao ON emprestimo(data_prev_devolucao);
CREATE INDEX IDX_multa_data_geracao ON multa(data_geracao);
CREATE INDEX IDX_pagamento_data_pagamento ON pagamento(data_pagamento);
CREATE INDEX IDX_reserva_data_reserva ON reserva(data_reserva);
CREATE INDEX IDX_livro_categoria ON livro(categoria);
CREATE INDEX IDX_exemplar_fisico_localizacao ON exemplar_fisico(localizacao);
CREATE INDEX IDX_emprestimo_leitor_status ON emprestimo(CPF_leitor, status);
CREATE INDEX IDX_emprestimo_exemplar_data ON emprestimo(codigo_exemplar, data_emprestimo);
CREATE INDEX IDX_leitor_tipo_status ON leitor(tipo, status);
CREATE INDEX IDX_multa_emprestimo_status ON multa(codigo_emprestimo, status);
CREATE INDEX IDX_reserva_livro_status ON reserva(codigo_livro, status);
CREATE INDEX IDX_emprestimo_atraso ON emprestimo(data_real_devolucao, data_prev_devolucao);
