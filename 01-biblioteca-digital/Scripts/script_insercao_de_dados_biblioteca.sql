USE biblioteca;


-- 1. Autores

INSERT INTO autor (nome, biografia, nacionalidade, data_nascimento) VALUES
('Machado de Assis', 'Maior escritor brasileiro do seculo XIX', 'Brasileiro', '1839-06-21'),
('J.K. Rowling', 'Autora da saga Harry Potter', 'Britanica', '1965-07-31'),
('George Orwell', 'Autor de 1984 e A Revolucao dos Bichos', 'Britanico', '1903-06-25'),
('Clarice Lispector', 'Grande escritora brasileira modernista', 'Brasileira', '1920-12-10'),
('Stephen King', 'Mestre do terror e suspense', 'Americano', '1947-09-21'),
('Agatha Christie', 'Rainha do crime', 'Britanica', '1890-09-15'),
('Gabriel Garcia Marquez', 'Nobel de Literatura 1982', 'Colombiano', '1927-03-06'),
('Neil Gaiman', 'Autor de fantasia contemporanea', 'Britanico', '1960-11-10');

-- Pseudonimos
INSERT INTO pseudonimo_autor (codigo_autor, pseudonimo) VALUES
(3, 'Eric Blair'),
(6, 'Mary Westmacott');


-- 2. Livros

INSERT INTO livro (categoria, nr_paginas, ISBN, idioma, titulo, ano_publicacao, sinopse, editora, edicao) VALUES
('Ficcao', 256, '978-8535908770', 'Portugues', 'Dom Casmurro', 1899, 'Historia de Bentinho e Capitu, um dos maiores classicos da literatura brasileira.', 'Globo Livros', 1),
('Fantasia', 264, '978-8532530787', 'Portugues', 'Harry Potter e a Pedra Filosofal', 1997, 'O inicio da jornada magica de Harry Potter em Hogwarts.', 'Rocco', 1),
('Distopia', 416, '978-8535914849', 'Portugues', '1984', 1949, 'Um mundo totalitario onde o Grande Irmao vigia todos.', 'Companhia das Letras', 2),
('Ficcao', 176, '978-8520925683', 'Portugues', 'A Hora da Estrela', 1977, 'Historia de Macabea, uma nordestina no Rio de Janeiro.', 'Rocco', 1),
('Terror', 688, '978-8581050379', 'Portugues', 'It - A Coisa', 1986, 'Uma entidade malevolente aterroriza a cidade de Derry.', 'Suma', 1),
('Policial', 256, '978-8595084605', 'Portugues', 'Assassinato no Expresso do Oriente', 1934, 'Hercule Poirot investiga um misterioso assassinato em um trem.', 'Harper Collins', 1),
('Ficcao', 432, '978-8501061898', 'Portugues', 'Cem Anos de Solidao', 1967, 'A saga da familia Buendia em Macondo.', 'Record', 5),
('Fantasia', 544, '978-8580575491', 'Portugues', 'Deuses Americanos', 2001, 'Deuses antigos enfrentam novos deuses na America moderna.', 'Intrinseca', 2),
('Ficcao', 192, '978-8520923801', 'Portugues', 'Memorias Postumas de Bras Cubas', 1881, 'Narrado por um defunto autor, critica a sociedade brasileira.', 'Penguin Classics', 1),
('Policial', 272, '978-8595084773', 'Portugues', 'Morte no Nilo', 1937, 'Poirot investiga um assassinato durante um cruzeiro no Nilo.', 'Harper Collins', 1);

-- Relacionamento Livro-Autor
INSERT INTO livro_autor (codigo_livro, codigo_autor) VALUES
(1, 1),  -- Dom Casmurro - Machado de Assis
(2, 2),  -- Harry Potter - J.K. Rowling
(3, 3),  -- 1984 - George Orwell
(4, 4),  -- A Hora da Estrela - Clarice Lispector
(5, 5),  -- It - Stephen King
(6, 6),  -- Assassinato no Expresso - Agatha Christie
(7, 7),  -- Cem Anos de Solidao - Garcia Marquez
(8, 8),  -- Deuses Americanos - Neil Gaiman
(9, 1),  -- Memorias Postumas - Machado de Assis
(10, 6); -- Morte no Nilo - Agatha Christie


-- 3. Exemplares

INSERT INTO exemplar (codigo_livro) VALUES
(1), (1), (1),  -- 3 exemplares de Dom Casmurro
(2), (2), (2), (2), (2),  -- 5 exemplares de Harry Potter
(3), (3),  -- 2 exemplares de 1984
(4), (4),  -- 2 exemplares de A Hora da Estrela
(5), (5), (5),  -- 3 exemplares de It
(6), (6),  -- 2 exemplares de Assassinato no Expresso
(7), (7),  -- 2 exemplares de Cem Anos de Solidao
(8),  -- 1 exemplar de Deuses Americanos
(9), (9),  -- 2 exemplares de Memorias Postumas
(10), (10);  -- 2 exemplares de Morte no Nilo

-- Exemplares Fisicos
INSERT INTO exemplar_fisico (codigo_exemplar, status, localizacao, estado_conservacao) VALUES
(1, 'D', 'A1-E2-P3', 'B'),   -- Disponivel, Bom
(2, 'E', 'A1-E2-P4', 'B'),   -- Emprestado, Bom
(3, 'M', 'A1-E2-P5', 'R'),   -- Manutencao, Ruim
(4, 'D', 'A2-E1-P1', 'O'),   -- Disponivel, Otimo
(5, 'D', 'A2-E1-P2', 'B'),   
(6, 'E', 'A2-E1-P3', 'B'),
(7, 'R', 'A2-E1-P4', 'O'),   -- Reservado
(8, 'D', 'A3-E2-P1', 'B'),
(9, 'D', 'A3-E2-P2', 'B'),
(10, 'D', 'A4-E1-P1', 'O'),
(11, 'E', 'A4-E1-P2', 'B'),
(12, 'D', 'A5-E3-P1', 'O'),
(13, 'D', 'A5-E3-P2', 'B'),
(14, 'E', 'A5-E3-P3', 'R'),  -- Emprestado, estado Ruim
(15, 'D', 'A6-E1-P1', 'O'),
(16, 'D', 'A6-E1-P2', 'B'),
(17, 'D', 'A7-E2-P1', 'B'),
(18, 'D', 'A7-E2-P2', 'O'),
(19, 'D', 'A8-E1-P1', 'B');

-- Exemplares Digitais
INSERT INTO exemplar_digital (codigo_exemplar, link_download, nr_licencas, formato_arquivo, tamanho_arquivo) VALUES
(20, 'https://biblioteca.com/downloads/memorias-postumas.pdf', 10, 'PDF', 2048576),
(21, 'https://biblioteca.com/downloads/memorias-postumas.epub', 10, 'EPUB', 1536000),
(22, 'https://biblioteca.com/downloads/morte-nilo.pdf', 5, 'PDF', 3145728),
(23, 'https://biblioteca.com/downloads/morte-nilo.epub', 5, 'EPUB', 2097152);


-- 4. Leitores

INSERT INTO leitor (CPF, data_nascimento, nome, email, tipo, status, data_cadastro) VALUES
('12345678901', '1995-03-15', 'Joao Silva Santos', 'joao.silva@email.com', 'estudante', 'A', '2024-01-10'),
('23456789012', '1988-07-22', 'Maria Oliveira Costa', 'maria.oliveira@email.com', 'professor', 'A', '2024-01-15'),
('34567890123', '2000-11-08', 'Pedro Henrique Souza', 'pedro.souza@email.com', 'estudante', 'A', '2024-02-20'),
('45678901234', '1992-05-30', 'Ana Paula Ferreira', 'ana.ferreira@email.com', 'funcionario', 'A', '2024-03-05'),
('56789012345', '1985-09-12', 'Carlos Eduardo Lima', 'carlos.lima@email.com', 'professor', 'A', '2024-03-10'),
('67890123456', '2001-01-25', 'Julia Martins Rocha', 'julia.rocha@email.com', 'estudante', 'S', '2024-04-01'),
('78901234567', '1978-12-03', 'Roberto Carlos Alves', 'roberto.alves@email.com', 'publico geral', 'A', '2024-04-15'),
('89012345678', '1998-06-18', 'Fernanda Costa Lima', 'fernanda.lima@email.com', 'estudante', 'I', '2024-05-20'),
('90123456789', '1990-04-07', 'Lucas Pereira Santos', 'lucas.santos@email.com', 'funcionario', 'A', '2024-06-01'),
('01234567890', '1982-08-29', 'Patricia Almeida Silva', 'patricia.silva@email.com', 'publico geral', 'A', '2024-06-10');

-- Telefones
INSERT INTO telefone_leitor (CPF_leitor, telefone) VALUES
('12345678901', '61987654321'),
('12345678901', '61912345678'),
('23456789012', '61988776655'),
('34567890123', '61999887766'),
('45678901234', '61987651234'),
('56789012345', '61988112233'),
('56789012345', '61987443322'),
('67890123456', '61999334455'),
('78901234567', '61988223344'),
('89012345678', '61987556677'),
('90123456789', '61988665544'),
('01234567890', '61987998877');

-- Enderecos
INSERT INTO endereco_leitor (CPF_leitor, CEP, estado, cidade, rua, bairro, numero) VALUES
('12345678901', '70000000', 'DF', 'Brasilia', 'SQN 205 Bloco A', 'Asa Norte', 101),
('23456789012', '71000000', 'DF', 'Brasilia', 'SGAS 915', 'Asa Sul', 205),
('34567890123', '72000000', 'DF', 'Taguatinga', 'QNA 42', 'Taguatinga Norte', 15),
('45678901234', '73000000', 'DF', 'Ceilandia', 'QNM 25', 'Ceilandia Norte', 8),
('56789012345', '70100000', 'DF', 'Brasilia', 'SQS 308 Bloco C', 'Asa Sul', 302),
('67890123456', '71100000', 'DF', 'Brasilia', 'SHCGN 706', 'Asa Norte', 10),
('78901234567', '72100000', 'DF', 'Taguatinga', 'QSD 31', 'Taguatinga Sul', 22),
('89012345678', '73100000', 'DF', 'Samambaia', 'QR 302', 'Samambaia Norte', 5),
('90123456789', '70200000', 'DF', 'Brasilia', 'SQSW 102', 'Sudoeste', 12),
('01234567890', '71200000', 'DF', 'Guara', 'QI 15', 'Guara I', 30);


-- 5. Funcionarios

INSERT INTO funcionario (nome, CPF, cargo, login, senha, data_admissao) VALUES
('Sandra Maria Santos', '11122233344', 'bibliotecaria', 'sandra.santos', '$2y$10$abcdefghijklmnopqrstuvwxyz1234567890', '2020-01-15'),
('Ricardo Alves Pereira', '22233344455', 'atendente', 'ricardo.pereira', '$2y$10$zyxwvutsrqponmlkjihgfedcba0987654321', '2021-05-20'),
('Claudia Ferreira Costa', '33344455566', 'gerente', 'claudia.costa', '$2y$10$1a2b3c4d5e6f7g8h9i0jklmnopqrstuvwxyz', '2019-03-10'),
('Paulo Roberto Silva', '44455566677', 'atendente', 'paulo.silva', '$2y$10$zxcvbnmasdfghjklqwertyuiop123456789', '2022-08-01');


-- 6. Emprestimos

INSERT INTO emprestimo (codigo_exemplar, CPF_leitor, codigo_funcionario, data_emprestimo, data_prev_devolucao, data_real_devolucao, status, renovacoes) VALUES
-- Emprestimos ja devolvidos
(2, '12345678901', 1, '2024-10-01', '2024-10-08', '2024-10-07', 'D', 0),
(6, '23456789012', 1, '2024-10-05', '2024-10-19', '2024-10-18', 'D', 0),
(11, '34567890123', 2, '2024-10-10', '2024-10-17', '2024-10-16', 'D', 0),

-- Emprestimos ativos (ainda nao devolvidos)
(2, '45678901234', 1, '2024-11-01', '2024-11-11', NULL, 'A', 0),
(6, '56789012345', 2, '2024-11-05', '2024-11-19', NULL, 'A', 1),
(11, '12345678901', 1, '2024-11-08', '2024-11-15', NULL, 'A', 0),
(14, '23456789012', 3, '2024-11-10', '2024-11-24', NULL, 'A', 0),

-- Emprestimos atrasados
(2, '34567890123', 2, '2024-10-20', '2024-10-27', NULL, 'T', 0),
(6, '67890123456', 1, '2024-10-15', '2024-10-22', NULL, 'T', 1),
(11, '89012345678', 2, '2024-10-25', '2024-11-01', NULL, 'T', 0);


-- 7. Reservas

INSERT INTO reserva (CPF_leitor, codigo_livro, data_reserva, data_validade, status, posicao_fila) VALUES
('78901234567', 2, '2024-11-10', '2024-11-12', 'A', 1),  -- Harry Potter - ativa
('90123456789', 2, '2024-11-11', '2024-11-13', 'A', 2),  -- Harry Potter - ativa
('01234567890', 5, '2024-11-12', '2024-11-14', 'A', 1),  -- It - ativa
('12345678901', 3, '2024-10-20', '2024-10-22', 'E', NULL),  -- 1984 - expirada
('34567890123', 6, '2024-11-01', '2024-11-03', 'T', NULL);  -- Assassinato - atendida

-- 8. Multa

INSERT INTO multa (codigo_emprestimo, status, valor, data_geracao) VALUES
(8, 'P', 48.00, '2024-11-08'),  -- 24 dias de atraso x R$ 2,00 = R$ 48,00 - PENDENTE
(9, 'P', 44.00, '2024-11-06'),  -- 22 dias de atraso x R$ 2,00 = R$ 44,00 - PENDENTE
(10, 'P', 24.00, '2024-11-13'), -- 12 dias de atraso x R$ 2,00 = R$ 24,00 - PENDENTE
(1, 'G', 14.00, '2024-10-09'),  -- Emprestimo 1 atrasou 7 dias - PAGA
(2, 'G', 12.00, '2024-10-20');  -- Emprestimo 2 atrasou 6 dias - PAGA

-- 9.Pagamento

INSERT INTO pagamento (codigo_funcionario, codigo_multa, valor_pago, forma_pagamento, data_pagamento) VALUES
(1, 4, 14.00, 'Pix', '2024-10-10'),        -- Pagamento da multa do emprestimo 1
(2, 5, 12.00, 'Dinheiro', '2024-10-21');   -- Pagamento da multa do emprestimo 2

-- Verificando

SELECT 'RESUMO DOS DADOS INSERIDOS:' AS '';
SELECT COUNT(*) AS total_autores FROM autor;
SELECT COUNT(*) AS total_livros FROM livro;
SELECT COUNT(*) AS total_exemplares FROM exemplar;
SELECT COUNT(*) AS total_exemplares_fisicos FROM exemplar_fisico;
SELECT COUNT(*) AS total_exemplares_digitais FROM exemplar_digital;
SELECT COUNT(*) AS total_leitores FROM leitor;
SELECT COUNT(*) AS total_funcionarios FROM funcionario;
SELECT COUNT(*) AS total_emprestimos FROM emprestimo;
SELECT COUNT(*) AS total_reservas FROM reserva;
SELECT COUNT(*) AS total_multas FROM multa;
SELECT COUNT(*) AS total_pagamentos FROM pagamento;