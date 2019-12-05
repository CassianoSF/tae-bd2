CREATE TABLE IF NOT EXISTS log (
    id SERIAL PRIMARY KEY,
    tabela VARCHAR(50) NOT NULL,
    operacao VARCHAR(10) NOT NULL,
    dadosNovos TEXT,
    dadosAntigos TEXT
);

CREATE OR REPLACE FUNCTION plog_filmes() RETURNS TRIGGER AS $log_filmes$
    BEGIN
        IF TG_OP = 'UPDATE' THEN
            INSERT INTO log (tabela, operacao, dadosNovos, dadosAntigos) VALUES
            ('Filmes', TG_OP, NEW, OLD);
        ELSE
            INSERT INTO log (tabela, operacao, dadosNovos, dadosAntigos) VALUES
            ('Filmes', TG_OP, NULL, OLD);
        END IF;
        RETURN NULL;
    END;
$log_filmes$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION plog_creditos() RETURNS TRIGGER AS $log_creditos$
    BEGIN
        IF TG_OP = 'UPDATE' THEN
            INSERT INTO log (tabela, operacao, dadosNovos, dadosAntigos) VALUES
            ('Creditos', TG_OP, NEW, OLD);
        ELSE
            INSERT INTO log (tabela, operacao, dadosNovos, dadosAntigos) VALUES
            ('Creditos', TG_OP, NULL, OLD);
        END IF;
        RETURN NULL;
    END;
$log_creditos$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS log_filmes ON Filmes;
CREATE TRIGGER log_filmes
AFTER UPDATE OR DELETE ON Filmes
    FOR EACH ROW EXECUTE PROCEDURE plog_filmes();

DROP TRIGGER IF EXISTS log_creditos ON Creditos;
CREATE TRIGGER log_creditos
AFTER UPDATE OR DELETE ON Creditos
    FOR EACH ROW EXECUTE PROCEDURE plog_creditos();







UPDATE Filmes SET titulo='test', ano=2020 
WHERE titulo = 'The Apple';
DELETE FROM Filmes WHERE titulo = 'test';


UPDATE Creditos SET filme_id = 123, pessoa_id=123 
WHERE personagem = 'tough mail robber Jack';
UPDATE Creditos SET filme_id = 123, pessoa_id=123 
WHERE personagem = 'insurance investigato';
DELETE FROM Creditos WHERE personagem = 'insurance investigato';


SELECT * FROM log;