CREATE INDEX Genero_Filme_idx_genero_filme  ON Genero_Filme(genero_id, filme_id);
CREATE INDEX Creditos_idx_filme_pessoa_tipo ON Creditos(filme_id, pessoa_id, tipo_id);
CREATE INDEX Creditos_idx_pessoa_tipo       ON Creditos(pessoa_id, tipo_id);
CREATE INDEX Linguas_idx_lingu              ON Linguas(lingua);
CREATE INDEX Generos_hash_descricao         ON Generos USING hash (descricao);
CREATE INDEX Pessoas_hash_nome              ON Pessoas USING hash (nome);
CREATE INDEX Tipos_hash_descricao           ON Tipos USING hash (descricao);
CREATE INDEX Filmes_hash_titulo             ON Filmes USING hash (titulo);
