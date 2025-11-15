-- Queries Biblioteca 

USE biblioteca; 

-- Listar todos os livros com seus autores
SELECT 
l.titulo,
l.categoria,
GROUP_CONCAT(a.nome SEPARATOR ', ') AS autores,
l.ano_publicacao,
l.editora
FROM livro l
JOIN livro_autor la ON l.codigo = la.codigo_livro
JOIN autor a ON la.codigo_autor = a.codigo
GROUP BY l.codigo, l.titulo, l.categoria, l.ano_publicacao, l.editora
ORDER BY l.titulo;

/*
+------------------------------------+-----------+------------------------+----------------+----------------------+
| titulo                             | categoria | autores                | ano_publicacao | editora              |
+------------------------------------+-----------+------------------------+----------------+----------------------+
| 1984                               | Distopia  | George Orwell          |           1949 | Companhia das Letras |
| A Hora da Estrela                  | Ficcao    | Clarice Lispector      |           1977 | Rocco                |
| Assassinato no Expresso do Oriente | Policial  | Agatha Christie        |           1934 | Harper Collins       |
| Cem Anos de Solidao                | Ficcao    | Gabriel Garcia Marquez |           1967 | Record               |
| Deuses Americanos                  | Fantasia  | Neil Gaiman            |           2001 | Intrinseca           |
| Dom Casmurro                       | Ficcao    | Machado de Assis       |           1899 | Globo Livros         |
| Harry Potter e a Pedra Filosofal   | Fantasia  | J.K. Rowling           |           1997 | Rocco                |
| It - A Coisa                       | Terror    | Stephen King           |           1986 | Suma                 |
| Memorias Postumas de Bras Cubas    | Ficcao    | Machado de Assis       |           1881 | Penguin Classics     |
| Morte no Nilo                      | Policial  | Agatha Christie        |           1937 | Harper Collins       |
+------------------------------------+-----------+------------------------+----------------+----------------------+
*/

-- Listar exemplares digitais disponiveis
SELECT 
l.titulo,
l.categoria,
ed.formato_arquivo,
ed.nr_licencas AS licencas_disponiveis,
ROUND(ed.tamanho_arquivo / 1048576, 2) AS tamanho_mb
FROM livro l
JOIN exemplar e ON l.codigo = e.codigo_livro
JOIN exemplar_digital ed ON e.codigo = ed.codigo_exemplar
ORDER BY l.titulo;

/*
+---------------------------------+-----------+-----------------+----------------------+------------+
| titulo                          | categoria | formato_arquivo | licencas_disponiveis | tamanho_mb |
+---------------------------------+-----------+-----------------+----------------------+------------+
| Deuses Americanos               | Fantasia  | PDF             |                   10 |       1.95 |
| Memorias Postumas de Bras Cubas | Ficcao    | EPUB            |                   10 |       1.46 |
| Memorias Postumas de Bras Cubas | Ficcao    | PDF             |                    5 |       3.00 |
| Morte no Nilo                   | Policial  | EPUB            |                    5 |       2.00 |
+---------------------------------+-----------+-----------------+----------------------+------------+
*/

-- Emprestimos ATRASADOS com dias de atraso
SELECT 
le.nome AS leitor,
le.email,
le.tipo AS tipo_leitor,
li.titulo AS livro,
emp.data_emprestimo,
emp.data_prev_devolucao,
DATEDIFF(CURDATE(), emp.data_prev_devolucao) AS dias_atraso,
DATEDIFF(CURDATE(), emp.data_prev_devolucao) * 2.00 AS valor_multa_calculado
FROM emprestimo emp
JOIN leitor le ON emp.CPF_leitor = le.CPF
JOIN exemplar ex ON emp.codigo_exemplar = ex.codigo
JOIN livro li ON ex.codigo_livro = li.codigo
WHERE emp.data_real_devolucao IS NULL 
  AND emp.data_prev_devolucao < CURDATE()
ORDER BY dias_atraso DESC;

/*
+----------------------+--------------------------+-------------+----------------------------------+-----------------+---------------------+-------------+-----------------------+
| leitor               | email                    | tipo_leitor | livro                            | data_emprestimo | data_prev_devolucao | dias_atraso | valor_multa_calculado |
+----------------------+--------------------------+-------------+----------------------------------+-----------------+---------------------+-------------+-----------------------+
| Julia Martins Rocha  | julia.rocha@email.com    | estudante   | Harry Potter e a Pedra Filosofal | 2024-10-15      | 2024-10-22          |         388 |                776.00 |
| Pedro Henrique Souza | pedro.souza@email.com    | estudante   | Dom Casmurro                     | 2024-10-20      | 2024-10-27          |         383 |                766.00 |
| Fernanda Costa Lima  | fernanda.lima@email.com  | estudante   | A Hora da Estrela                | 2024-10-25      | 2024-11-01          |         378 |                756.00 |
| Ana Paula Ferreira   | ana.ferreira@email.com   | funcionario | Dom Casmurro                     | 2024-11-01      | 2024-11-11          |         368 |                736.00 |
| Joao Silva Santos    | joao.silva@email.com     | estudante   | A Hora da Estrela                | 2024-11-08      | 2024-11-15          |         364 |                728.00 |
| Carlos Eduardo Lima  | carlos.lima@email.com    | professor   | Harry Potter e a Pedra Filosofal | 2024-11-05      | 2024-11-19          |         360 |                720.00 |
| Maria Oliveira Costa | maria.oliveira@email.com | professor   | It - A Coisa                     | 2024-11-10      | 2024-11-24          |         355 |                710.00 |
+----------------------+--------------------------+-------------+----------------------------------+-----------------+---------------------+-------------+-----------------------+
*/

-- Livros mais emprestados
SELECT 
li.titulo,
li.categoria,
COUNT(emp.codigo) AS total_emprestimos,
COUNT(CASE WHEN emp.data_real_devolucao IS NULL THEN 1 END) AS emprestimos_ativos
FROM livro li
JOIN exemplar ex ON li.codigo = ex.codigo_livro
JOIN emprestimo emp ON ex.codigo = emp.codigo_exemplar
GROUP BY li.codigo, li.titulo, li.categoria
ORDER BY total_emprestimos DESC;

/*
+----------------------------------+-----------+-------------------+--------------------+
| titulo                           | categoria | total_emprestimos | emprestimos_ativos |
+----------------------------------+-----------+-------------------+--------------------+
| Dom Casmurro                     | Ficcao    |                 3 |                  2 |
| Harry Potter e a Pedra Filosofal | Fantasia  |                 3 |                  2 |
| A Hora da Estrela                | Ficcao    |                 3 |                  2 |
| It - A Coisa                     | Terror    |                 1 |                  1 |
+----------------------------------+-----------+-------------------+--------------------+
*/

-- Leitores mais ativos
SELECT 
le.nome,
le.tipo,
COUNT(emp.codigo) AS total_emprestimos,
COUNT(CASE WHEN emp.data_real_devolucao IS NULL THEN 1 END) AS emprestimos_ativos
FROM leitor le
JOIN emprestimo emp ON le.CPF = emp.CPF_leitor
GROUP BY le.CPF, le.nome, le.tipo
ORDER BY total_emprestimos DESC;

/*
+----------------------+-------------+-------------------+--------------------+
| nome                 | tipo        | total_emprestimos | emprestimos_ativos |
+----------------------+-------------+-------------------+--------------------+
| Joao Silva Santos    | estudante   |                 2 |                  1 |
| Maria Oliveira Costa | professor   |                 2 |                  1 |
| Pedro Henrique Souza | estudante   |                 2 |                  1 |
| Ana Paula Ferreira   | funcionario |                 1 |                  1 |
| Carlos Eduardo Lima  | professor   |                 1 |                  1 |
| Julia Martins Rocha  | estudante   |                 1 |                  1 |
| Fernanda Costa Lima  | estudante   |                 1 |                  1 |
+----------------------+-------------+-------------------+--------------------+
*/

--  Reservas ativas (fila de espera)
SELECT 
li.titulo,
le.nome AS leitor,
le.email,
r.data_reserva,
r.data_validade,
r.posicao_fila,
DATEDIFF(r.data_validade, CURDATE()) AS dias_ate_expirar
FROM reserva r
JOIN livro li ON r.codigo_livro = li.codigo
JOIN leitor le ON r.CPF_leitor = le.CPF
WHERE r.status = 'A'
ORDER BY li.titulo, r.posicao_fila;

/*
+----------------------------------+------------------------+--------------------------+--------------+---------------+--------------+------------------+
| titulo                           | leitor                 | email                    | data_reserva | data_validade | posicao_fila | dias_ate_expirar |
+----------------------------------+------------------------+--------------------------+--------------+---------------+--------------+------------------+
| Harry Potter e a Pedra Filosofal | Roberto Carlos Alves   | roberto.alves@email.com  | 2024-11-10   | 2024-11-12    |            1 |             -367 |
| Harry Potter e a Pedra Filosofal | Lucas Pereira Santos   | lucas.santos@email.com   | 2024-11-11   | 2024-11-13    |            2 |             -366 |
| It - A Coisa                     | Patricia Almeida Silva | patricia.silva@email.com | 2024-11-12   | 2024-11-14    |            1 |             -365 |
+----------------------------------+------------------------+--------------------------+--------------+---------------+--------------+------------------+
*/

-- Livros com mais reservas
SELECT 
li.titulo,
li.categoria,
COUNT(r.codigo) AS total_reservas_ativas
FROM livro li
JOIN reserva r ON li.codigo = r.codigo_livro
WHERE r.status = 'A'
GROUP BY li.codigo, li.titulo, li.categoria
ORDER BY total_reservas_ativas DESC;

/*
+----------------------------------+-----------+-----------------------+
| titulo                           | categoria | total_reservas_ativas |
+----------------------------------+-----------+-----------------------+
| Harry Potter e a Pedra Filosofal | Fantasia  |                     2 |
| It - A Coisa                     | Terror    |                     1 |
+----------------------------------+-----------+-----------------------+
*/

--  Multas pendentes por leitor
SELECT 
le.nome AS leitor,
le.email,
le.tipo,
COUNT(m.codigo) AS total_multas_pendentes,
SUM(m.valor) AS valor_total_devido
FROM leitor le
JOIN emprestimo emp ON le.CPF = emp.CPF_leitor
JOIN multa m ON emp.codigo = m.codigo_emprestimo
WHERE m.status = 'P'
GROUP BY le.CPF, le.nome, le.email, le.tipo
ORDER BY valor_total_devido DESC;

/*
+----------------------+-------------------------+-----------+------------------------+--------------------+
| leitor               | email                   | tipo      | total_multas_pendentes | valor_total_devido |
+----------------------+-------------------------+-----------+------------------------+--------------------+
| Pedro Henrique Souza | pedro.souza@email.com   | estudante |                      1 |              48.00 |
| Julia Martins Rocha  | julia.rocha@email.com   | estudante |                      1 |              44.00 |
| Fernanda Costa Lima  | fernanda.lima@email.com | estudante |                      1 |              24.00 |
+----------------------+-------------------------+-----------+------------------------+--------------------+
*/

--  Historico de pagamentos
SELECT 
p.codigo AS cod_pagamento,
le.nome AS leitor,
li.titulo AS livro,
m.valor AS valor_multa,
p.valor_pago,
p.forma_pagamento,
p.data_pagamento,
f.nome AS funcionario_recebeu
FROM pagamento p
JOIN multa m ON p.codigo_multa = m.codigo
JOIN emprestimo emp ON m.codigo_emprestimo = emp.codigo
JOIN leitor le ON emp.CPF_leitor = le.CPF
JOIN exemplar ex ON emp.codigo_exemplar = ex.codigo
JOIN livro li ON ex.codigo_livro = li.codigo
JOIN funcionario f ON p.codigo_funcionario = f.codigo
ORDER BY p.data_pagamento DESC;

/*
+---------------+----------------------+----------------------------------+-------------+------------+-----------------+----------------+-----------------------+
| cod_pagamento | leitor               | livro                            | valor_multa | valor_pago | forma_pagamento | data_pagamento | funcionario_recebeu   |
+---------------+----------------------+----------------------------------+-------------+------------+-----------------+----------------+-----------------------+
|             4 | Maria Oliveira Costa | Harry Potter e a Pedra Filosofal |       12.00 |      12.00 | Dinheiro        | 2024-10-21     | Ricardo Alves Pereira |
|             3 | Joao Silva Santos    | Dom Casmurro                     |       14.00 |      14.00 | Pix             | 2024-10-10     | Sandra Maria Santos   |
+---------------+----------------------+----------------------------------+-------------+------------+-----------------+----------------+-----------------------+
*/

--  Leitores inadimplentes ou suspensos
SELECT 
le.nome,
le.email,
le.tipo,
CASE le.status
	WHEN 'A' THEN 'Ativo'
	WHEN 'S' THEN 'Suspenso'
	WHEN 'I' THEN 'Inadimplente'
END AS status,
COUNT(m.codigo) AS total_multas_pendentes,
COALESCE(SUM(m.valor), 0) AS valor_devido
FROM leitor le
LEFT JOIN emprestimo emp ON le.CPF = emp.CPF_leitor
LEFT JOIN multa m ON emp.codigo = m.codigo_emprestimo AND m.status = 'P'
WHERE le.status IN ('S', 'I')
GROUP BY le.CPF, le.nome, le.email, le.tipo, le.status;

/*
+---------------------+-------------------------+-----------+--------------+------------------------+--------------+
| nome                | email                   | tipo      | status       | total_multas_pendentes | valor_devido |
+---------------------+-------------------------+-----------+--------------+------------------------+--------------+
| Fernanda Costa Lima | fernanda.lima@email.com | estudante | Inadimplente |                      1 |        24.00 |
| Julia Martins Rocha | julia.rocha@email.com   | estudante | Suspenso     |                      1 |        44.00 |
+---------------------+-------------------------+-----------+--------------+------------------------+--------------+
*/