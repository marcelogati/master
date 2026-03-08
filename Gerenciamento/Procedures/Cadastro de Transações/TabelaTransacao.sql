CREATE TABLE CadastroTransacao ( Identificador_Transacao Integer Identity(1,1) Primary key,
                                 Descricao               Varchar(400)  NOT NULL, 
                                 Valor                   Numeric(18,2) NOT NULL,
                                 Tipo                    Char(1)       NOT NULL,
                                 Identificador_Categoria Integer       NOT NULL,
                                 Identificador_Pessoa    Integer       NOT NULL,
                                 Data_Inclusao           Datetime      NOT NULL
CONSTRAINT FK_Transacao_Categoria 
        FOREIGN KEY (Identificador_Categoria) REFERENCES CadastroCategoria(Identificador_Categoria),

CONSTRAINT FK_Transacao_Pessoa 
        FOREIGN KEY (Identificador_Pessoa) REFERENCES CadastroPessoas(Identificador_Pessoa)

);



