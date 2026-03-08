CREATE OR ALTER PROCEDURE Inserir_Transacao @Descricao               Varchar(400)
                                           ,@Valor                   Numeric(18,2)
                                           ,@Tipo                    Char(1)
                                           ,@Identificador_Categoria Integer
                                           ,@Identificador_Pessoa    Integer
                                           ,@Mensagem                Varchar(255) OUTPUT

AS 
BEGIN
  SET NOCOUNT ON;

  DECLARE @Identificador_Transacao Integer;

  SELECT @Mensagem = '';

  --Verificando se está deixando a descrição da categoria em branco ou nula.
  IF (@Descricao = '') OR (@Descricao IS NULL)
  BEGIN
    SET @Mensagem = 'Descrição Inválida'; 
    GOTO FIM;
  END

   --Verificando se está deixando valor da transção zerado ou nula.
  IF (@Valor = 0) OR (@Valor IS NULL)
  BEGIN
    SET @Mensagem = 'Valor Inválido'; 
    GOTO FIM;
  END
    
  --Verificando se está deixando o Tipo da transação em branco ou nula.
  IF (@Tipo = '') OR (@Tipo IS NULL)
  BEGIN
    SET @Mensagem = 'Tipo Inválido'; 
    GOTO FIM;
  END

  --Verificando se está informando um Identificador_Categoria zerado ou nullo
  IF (@Identificador_Categoria = 0) OR (@Identificador_Categoria IS NULL)
  BEGIN
    SET @Mensagem = 'Categoria Inválida'; 
    GOTO FIM;
  END

  --Verificando se está informando um Identificador_Categoria zerado ou nullo
  IF (@Identificador_Pessoa = 0) OR (@Identificador_Pessoa IS NULL)
  BEGIN
    SET @Mensagem = 'Pessoa Inválida'; 
    GOTO FIM;
  END

  --Verificando se no cadastro de pessoas, se ela é menor de idade e se a pessoa está tentando
  --inserir  transações como Receita(R), volta uma mensagem de erro porque isso não é possível.
  IF EXISTS (SELECT 1 FROM dbo.CadastroPessoas
             WHERE Identificador_Pessoa = @Identificador_Pessoa
               AND Idade_Pessoa < 18
               AND @Tipo = 'R')
  BEGIN
    SELECT @Mensagem  = 'Usuário menor que 18 anos, só poderá cadastrar transações de DESPESAS';
    GOTO FIM;
  END

  --Verificando se está tentando inserir uma categoria Despesa = 'D' em um tipo de transação Receita = 'R'
  --Isso não é possível.
  IF EXISTS (SELECT 1 FROM dbo.CadastroCategoria
             WHERE Identificador_Categoria = @Identificador_Categoria
               AND Finalidade = 'D'
               AND @Tipo      = 'R')
  BEGIN
    SELECT @Mensagem  = 'Não é possível cadastrar uma transação com Categoria de Despesa e Tipo da transação sendo Receita';
    GOTO FIM;
  END

  --Verificando se está tentando inserir uma categoria Despesa = 'R' em um tipo de transação Receita = 'D'
  --Isso não é possível.
  IF EXISTS (SELECT 1 FROM dbo.CadastroCategoria
             WHERE Identificador_Categoria = @Identificador_Categoria
               AND Finalidade = 'R'
               AND @Tipo      = 'D')
  BEGIN
    SELECT @Mensagem  = 'Não é possível cadastrar uma transação com Categoria de Receita e Tipo da transação sendo Despesa';
    GOTO FIM;
  END

    --Verificando se já foi cadastrado uma transação, para não cadastrar novamente. 
  IF EXISTS (SELECT 1 FROM dbo.CadastroTransacao
             WHERE Descricao               = @Descricao
               AND Valor                   = @Valor
               AND Tipo                    = @Tipo
               AND Identificador_Categoria = @Identificador_Categoria
               AND Identificador_Pessoa    = @Identificador_Pessoa)
  BEGIN
    SELECT @Mensagem  = 'Transação já cadastrada';
    GOTO FIM;
  END


  --Inserindo os dados
  INSERT INTO dbo.CadastroTransacao ( Descricao
                                     ,Valor
                                     ,Tipo
                                     ,Identificador_Categoria
                                     ,Identificador_Pessoa
                                     ,Data_Inclusao)
  SELECT @Descricao
        ,@Valor
        ,@Tipo
        ,@Identificador_Categoria
        ,@Identificador_Pessoa
        ,GETDATE();
    
  IF (@@ERROR <> 0 )
  BEGIN
  --Se der erro de inserção, grava na tabela log para o time técnico debugar.
    INSERT INTO tb_Log(Complemento)
    SELECT 'Proc: Inserir_Transacao. Erro ao inserir na tabela CadastroTransacao ' 
         + 'Descrição ' + @Descricao + 'Valor ' + @Valor + 'Tipo' + @Tipo  
         + 'Identificador Categoria ' + @Identificador_Categoria  + 'Identificador Pessoa ' + @Identificador_Pessoa
    
    --Volta uma mensagem amigável para o usuário.
    SELECT @Mensagem = 'Erro no sistema, consulte um técnico';    
    GOTO FIM;
  END

  --Pega o valor do ultimo registro inserido na tabela, se tem valor é pq deu certo a inserção.
  SET @Identificador_Transacao = SCOPE_IDENTITY();

  --Se tiver valor na variável, é pq deu certo a inserção e volta uma mensagem de sucesso para o usuário.
  IF (ISNULL(@Identificador_Transacao,0) > 0)
  BEGIN
     SELECT @Mensagem = 'Cadastro de transação efetuado com sucesso';
     Return;
  END

  RETURN 
  FIM:
  SELECT @Mensagem;
  RAISERROR(@Mensagem, 18, 1);


  Return

END

