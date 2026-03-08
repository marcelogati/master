CREATE OR ALTER PROCEDURE Inserir_Categoria @Descricao  Varchar(400)
                                           ,@Finalidade Char(1)  --D = Despesa, R = Receita
                                           ,@Mensagem   Varchar(255) OUTPUT

AS 
BEGIN
  SET NOCOUNT ON;

  DECLARE @Identificador  Integer;

  SELECT @Mensagem = '';

    --Verificando se está deixando a descrição da categoria em branco ou nula.
  IF (@Descricao = '') OR (@Descricao IS NULL)
  BEGIN
    SET @Mensagem = 'Descrição Inválida'; 
    GOTO FIM;
  END

      --Verificando se está deixando a Finalidade da categoria em branco ou nula, ou se for enviado algo diferente de R ou D.
  IF ((@Finalidade = '') OR (@Finalidade IS NULL) OR (@Finalidade NOT IN ('R','D')))
  BEGIN
    SET @Mensagem = 'Finalidade Inválida, a finalidade deve ser uma RECEITA(R) ou uma DESPESA(D)'; 
    GOTO FIM;
  END

  --Verificando se está deixando a Finalidade da categoria em branco ou nula, ou se for enviado algo diferente de R ou D.
  IF EXISTS (SELECT 1 FROM dbo.CadastroCategoria
             WHERE Descricao  = @Descricao
               AND Finalidade = @Finalidade)
  BEGIN
    SET @Mensagem = 'Finalidade já cadastrada.'; 
    GOTO FIM;
  END

  --Insere os dados na tabela.
  INSERT INTO dbo.CadastroCategoria ( Descricao
                                     ,Finalidade)
  SELECT @Descricao
        ,@Finalidade;
    
  IF (@@ERROR <> 0 )
  BEGIN
  --Se deu um erro de inserção registra na tabela de log
    INSERT INTO tb_Log(Complemento)
    SELECT 'Proc: Inserir_Categoria. Erro ao inserir na tabela CadastroCategoria' + 'Descrição ' + @Descricao; 

    --E volta uma mensagem amigável pro usuário.
    SELECT @Mensagem = 'Erro no sistema, consulte um técnico';    
    GOTO FIM;
  END
  --Aqui pega o ultimo registro inserido na tabela, se inseriu é pq deu certo.
  SET @Identificador = SCOPE_IDENTITY();

  --Se tiver valor na variável deu certo e volta uma mensagm pro usuário dizendo que deu certo.
  IF (ISNULL(@Identificador,0) > 0)
  BEGIN
     SELECT @Mensagem = 'Cadastro de categoria efetuado com sucesso';
     Return;
  END

  RETURN 
  
  FIM:
  SELECT @Mensagem;
  RAISERROR(@Mensagem, 18, 1);

  Return;

END

