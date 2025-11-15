📚 Sistema de Biblioteca Digital "LêMais"
Projeto completo de modelagem de banco de dados para gestão de biblioteca com acervo físico e digital, desenvolvido como projeto de portfólio demonstrando domínio do ciclo completo de modelagem de dados.

📋 Sobre o Projeto
Sistema completo de gerenciamento de biblioteca que permite controle de acervo físico e digital, empréstimos, reservas, multas e gestão de diferentes perfis de leitores. O projeto foi desenvolvido seguindo todas as etapas da modelagem de dados, desde a fase conceitual até a implementação física em MySQL.

🎯 Funcionalidades Principais
✅ Gestão de Acervo: Controle de livros físicos e digitais com múltiplos exemplares
✅ Sistema de Empréstimos: Registro completo com prazos diferenciados por tipo de leitor
✅ Fila de Reservas: Sistema de reservas com controle de validade e posição na fila
✅ Cálculo de Multas: Geração automática de multas para empréstimos atrasados
✅ Controle de Pagamentos: Registro de quitação de multas com rastreabilidade
✅ Múltiplos Perfis: Estudantes, professores, funcionários e público geral com regras distintas
✅ Histórico Completo: Rastreamento de todas as operações realizadas

🏗️ Arquitetura do Projeto
Fases de Desenvolvimento
1. Levantamento de Requisitos

   └── Requisitos funcionais e regras de negócio

3. Modelagem Conceitual (DER)

   └── Entidades, relacionamentos e cardinalidades

5. Modelagem Lógica

   └── Normalização (3FN) e esquema relacional

7. Modelagem Física

   └── Implementação em MySQL com constraints e índices
   
📊 Modelagem de Dados
1️⃣ Modelo Conceitual (DER)
![DER_projeto_biblioteca](https://github.com/user-attachments/assets/8c09b010-8a20-47c8-aa89-880a1309beac)




Principais Decisões de Modelagem:

Separação Livro vs Exemplar: Um livro representa a obra (informação bibliográfica), enquanto exemplar representa cada cópia física ou digital

Especialização Total: Exemplares são classificados como Físicos OU Digitais (disjuntos)

Entidades Associativas: Empréstimo e Reserva possuem atributos próprios e relacionam múltiplas entidades

Atributos Multivalorados: Telefone e pseudônimo separados em tabelas próprias

Atributo Composto: Endereço decomposto em seus elementos atômicos

Entidades do Sistema:

Principais:


Livro: Obra literária (título, ISBN, categoria, etc)

Autor: Escritores das obras

Exemplar: Cópias físicas ou digitais de livros

Leitor: Usuários da biblioteca

Funcionário: Operadores do sistema

Empréstimo: Registro de empréstimos realizados

Reserva: Fila de espera para livros indisponíveis

Multa: Penalidades por atrasos

Pagamento: Quitação de multas

Auxiliares:


livro_autor, pseudonimo_autor, telefone_leitor, endereco_leitor

exemplar_fisico, exemplar_digital

2️⃣ Modelo Lógico Relacional
<img width="1430" height="1001" alt="Imagem_Modelo_Logico_Biblioteca" src="https://github.com/user-attachments/assets/f02735e0-0081-4380-bab7-46d5368b4562" />




Normalização Aplicada:

✅ Primeira Forma Normal (1FN)


Todos os atributos são atômicos

Não há grupos repetitivos

Atributos multivalorados separados em tabelas

✅ Segunda Forma Normal (2FN)


Eliminadas dependências parciais

Atributos dependem totalmente da chave primária

✅ Terceira Forma Normal (3FN)


Eliminadas dependências transitivas

Não há redundância de dados

Estrutura de Tabelas:

15 Tabelas Normalizadas:


livro, autor, livro_autor, pseudonimo_autor
exemplar, exemplar_fisico, exemplar_digital
leitor, telefone_leitor, endereco_leitor
funcionario, emprestimo, reserva, multa, pagamento

3️⃣ Modelo Físico (Implementação MySQL)

Características Técnicas:

SGBD: MySQL 8.0+

Charset: UTF-8

Engine: InnoDB (transacional)

Total de Tabelas: 15

Total de Índices: 23 (otimização de performance)

Constraints Implementadas:

Chaves Primárias (PK):


Todas as tabelas possuem PK definida

AUTO_INCREMENT para chaves surrogate

CPF como chave natural em Leitor

Chaves Estrangeiras (FK):


Integridade referencial em todos os relacionamentos

18 FKs implementadas

UNIQUE:


ISBN (livro)

Email (leitor)

CPF e Login (funcionario)

CHECK:


Status válidos (ativo, suspenso, inadimplente, etc)

Renovações máximas (0 a 2)

Valor de multa (R$ 0,00 a R$ 60,00)

Ano de publicação (>= 1000 e <= ano atual)

Formas de pagamento válidas

DEFAULT:


Data de cadastro/empréstimo = data atual

Status inicial = 'A' (ativo)

Renovações = 0

🗂️ Estrutura do Projeto
Sistema-Biblioteca-Digital/

📄 README.md                              ← Este arquivo

📁 Diagrama-conceitual/

├── CONCEITUAL_2.brM                      ← Arquivo brModelo

└── DER_projeto_biblioteca.jpg            ← DER visual

📁 Diagrama-logico

├── Imagem_Modelo_Logico_Biblioteca.png   ← Modelo lógico no Workbench

└── modelo_logico_biblioteca.mwb          ← Arquivo modelo lógico

📁 Normalização/

├── Normalização_Biblioteca.pdf           ← Normalização

📁 Requisitos/

├── Requisitos de Negócios - Sistema de Biblioteca Digital.pdf       ← Requisitos de negócio

📁 Scripts/

├── script_biblioteca_sql.sql              ← Script criação do banco de dados

└── script_insercao_de_dados_biblioteca.sql     ← Script da inserção de dados dentro do bd

└── script_queries_biblioteca.sql          ← Script com exemplo de queries com resultados


📊 Dados de Teste
O script de inserção inclui:

8 autores (Machado de Assis, J.K. Rowling, George Orwell, etc)
10 livros (Dom Casmurro, Harry Potter, 1984, It, etc)
23 exemplares (19 físicos + 4 digitais)
10 leitores (diferentes tipos e status)
4 funcionários
10 empréstimos (devolvidos, ativos e atrasados)
5 reservas (ativas e expiradas)
5 multas (pagas e pendentes)

🎯 Regras de Negócio Implementadas
Código	Regra	Implementação
RN01	Limite de empréstimos simultâneos por tipo	Verificação via query
RN02	Notificação para atrasos > 30 dias	Calculado via DATEDIFF
RN03	Máximo 2 reservas por leitor	Verificação via query
RN04	Exemplares em manutenção não emprestam	Status em exemplar_fisico
RN05	Livro deve ter pelo menos 1 autor	FK obrigatória em livro_autor
RN06	ISBN único	UNIQUE constraint
RN07	Leitores suspensos não emprestam	Status verificado na aplicação
RN08	Multa máxima R$ 60,00	CHECK constraint
RN09	Máximo 2 renovações	CHECK constraint (0-2)
RN10	Multa = R$ 2,00/dia	Calculado na geração

🔍 Índices Criados
Total de 23 índices para otimização de performance:

Índices em Chaves de Busca:

IDX_livro_titulo, IDX_livro_ISBN

IDX_leitor_email

IDX_livro_categoria

Índices em Status (filtros frequentes):

IDX_leitor_status, IDX_emprestimo_status

IDX_multa_status, IDX_reserva_status

Índices em Datas:

IDX_emprestimo_devolucao

IDX_emprestimo_data_prev_devolucao

IDX_multa_data_geracao

Índices Compostos:

IDX_emprestimo_leitor_status (CPF_leitor, status)

IDX_reserva_livro_status (codigo_livro, status)

IDX_emprestimo_atraso (data_real_devolucao, data_prev_devolucao)

Nota: MySQL 8 cria automaticamente índices nas FKs.


🛠️ Tecnologias Utilizadas
Banco de Dados: MySQL 8.0
Modelagem Conceitual: brModelo30
Modelagem Lógica: MySQL Workbench 8.0
Linguagem: SQL (DDL, DML, DQL)
Normalização: Até 3ª Forma Normal
Controle de Versão: Git


📚 Decisões Técnicas
Por que separar Livro e Exemplar?
Um livro é a obra (informação bibliográfica única), enquanto exemplar é cada cópia física ou digital. Isso permite:

Controlar múltiplas cópias do mesmo título
Rastrear localização e estado de cada cópia
Diferenciar exemplares físicos de digitais
Gerenciar empréstimos de itens específicos
Por que Reserva relaciona com Livro e não Exemplar?
Quando um leitor reserva, ele quer a obra, não uma cópia específica. Qualquer exemplar disponível pode atender a reserva.

Por que Multa está relacionada a Empréstimo?
Mantém histórico correto e rastreabilidade. Um empréstimo pode gerar múltiplas multas (renovações com atraso).

Por que usar CHAR(1) para status?
Decisão de trade-off: economia de espaço vs legibilidade. Em produção, considerar ENUM ou VARCHAR com nomes completos.


📖 Documentação Adicional
Requisitos de Negócio Completos
Esquema de Normalização

🎓 Conceitos Demonstrados
Este projeto demonstra conhecimento em:

✅ Modelagem Conceitual: DER, entidades, relacionamentos, cardinalidades ✅ Modelagem Lógica: Normalização, integridade referencial, esquema relacional
✅ Modelagem Física: DDL, constraints, índices, otimização ✅ SQL Avançado: JOINs múltiplos, subqueries, agregações, window functions ✅ Regras de Negócio: Implementação de RNs via constraints ✅ Performance: Índices estratégicos para consultas frequentes ✅ Documentação: README completo, comentários, exemplos


📈 Métricas do Projeto
15 tabelas normalizadas
18 relacionamentos (FKs)
23 índices de performance
40+ queries de exemplo
10 regras de negócio implementadas
3 níveis de normalização (3FN)

👤 Autor

Cauã de Godoy Araujo


GitHub: @Caua-Godoy

LinkedIn: www.linkedin.com/in/caua-de-godoy-araujo202007

Email: contato.cauadegodoy@gmail.com


