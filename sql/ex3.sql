
-- 3.
-- a) Buscar o nome e o ano dos filmes de ação;
SELECT titulo, ano FROM Filmes
JOIN Genero_Filme ON Genero_Filme.filme_id = Filmes.id
JOIN Generos ON Genero_Filme.genero_id = Generos.id
WHERE Generos.descricao = 'Ação';

-- b) Buscar os filmes em que a pessoa ‘Marlon Brando’ possui créditos como ator;
SELECT titulo FROM Filmes
JOIN Creditos ON Creditos.filme_id = Filmes.id
JOIN Pessoas  ON Creditos.pessoa_id = Pessoas.id
JOIN Tipos    ON Creditos.tipo_id = Tipos.id
WHERE Pessoas.nome = 'Marlon Brando' AND Tipos.descricao = 'Atuação';

-- c) Buscar as línguas cadastradas e quantos filmes foram rodados para cada uma.
SELECT COUNT(filme_id) as qtde_filmes, lingua FROM Linguas
JOIN Filmes ON Linguas.filme_id = Filmes.id
GROUP BY Linguas.lingua;

-- d) Buscar as informações do ator (créditos do tipo ‘Atuação’) que mais estrelou filmes.
SELECT COUNT(pessoa_id) AS qtd_de_filmes, Pessoas.* FROM Pessoas
JOIN Creditos ON Creditos.pessoa_id = Pessoas.id
JOIN Tipos    ON Creditos.tipo_id = Tipos.id
WHERE(Tipos.descricao = 'Atuação')
GROUP BY (Pessoas.id)
ORDER BY qtd_de_filmes DESC
LIMIT 1;

-- e) Buscar a média de idade dos atores que participaram de filmes do gênero ‘Comédia’
SELECT AVG(	DATE_PART('year', now()) - DATE_PART('year', data_nasc)) FROM Pessoas
JOIN Creditos     ON Creditos.pessoa_id    = Pessoas.id
JOIN Tipos        ON Creditos.tipo_id      = Tipos.id
JOIN Filmes       ON Creditos.filme_id     = Filmes.id
JOIN Genero_Filme ON Genero_Filme.filme_id = Filmes.id
JOIN Generos      ON Generos.id            = Genero_Filme.genero_id
WHERE(Tipos.descricao = 'Atuação' AND Generos.descricao = 'Comédia');

-- f) Listar os créditos completos do filme ‘Pulp Fiction’. A lista deve apresentar 3 campos: o
-- nome (Pessoa.nome) de todos os envolvidos no filme; qual o tipo do crédito
-- (tipo.descricao); e para atores (tipo.descricao = ‘Atuação’) o nome do personagem.
SELECT Pessoas.nome, Tipos.descricao, Creditos.personagem FROM Pessoas
JOIN Creditos     ON Creditos.pessoa_id    = Pessoas.id
JOIN Tipos        ON Creditos.tipo_id      = Tipos.id
JOIN Filmes       ON Creditos.filme_id     = Filmes.id
WHERE(Filmes.titulo = 'Pulp Fiction');