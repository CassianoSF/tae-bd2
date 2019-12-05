CREATE TABLE IF NOT EXISTS Filmes (
    id     SERIAL PRIMARY KEY NOT NULL, 
    titulo CHAR(200)          NOT NULL, 
    ano    INT                NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS titulo_ano
ON Filmes(titulo, ano);

CREATE TABLE IF NOT EXISTS Pessoas (
    id         SERIAL PRIMARY KEY NOT NULL, 
    nome       CHAR(50)           NOT NULL, 
    sexo       CHAR(10)           NOT NULL, 
    data_nasc  DATE               NOT NULL
);

CREATE TABLE IF NOT EXISTS Tipos (
    id SERIAL PRIMARY KEY NOT NULL, 
    descricao CHAR(50)    NOT NULL
);

CREATE TABLE IF NOT EXISTS Creditos (
    pessoa_id INT NOT NULL REFERENCES Pessoas(id), 
    filme_id  INT NOT NULL REFERENCES Filmes(id), 
    tipo_id   INT NOT NULL REFERENCES Tipos(id), 
    personagem CHAR(255)
);

CREATE TABLE IF NOT EXISTS Generos (
    id SERIAL PRIMARY KEY NOT NULL,
    descricao CHAR(50)    NOT NULL
);

CREATE TABLE IF NOT EXISTS Genero_Filme (
    filme_id  INT NOT NULL REFERENCES Filmes(id) , 
    genero_id INT NOT NULL REFERENCES Generos(id) 
);

CREATE TABLE IF NOT EXISTS Linguas (
    filme_id INT NOT NULL REFERENCES Filmes(id) , 
    lingua   CHAR(50)
);
