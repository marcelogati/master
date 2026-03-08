CREATE TABLE CadastroPessoas ( Identificador_Pessoa Integer Identity(1,1) Primary key,
                               NM_Pessoa            Varchar(200) NOT NULL,
                               Email_Pessoa         Varchar(50) NOT NULL,
                               Idade_Pessoa         Integer     NOT NULL,
                               CPF                  Varchar(11) NOT NULL
);