CREATE OR ALTER PROCEDURE Inserir_Pessoas @NM_Pessoa     Varchar(200)
                                         ,@Email_Pessoa  Varchar(50)
                                         ,@Idade_Pessoa  Integer
                                         ,@CPF           Varchar(11)
                                         ,@Mensagem      Varchar(255) OUTPUT

AS 
BEGIN
  SET NOCOUNT ON;

  SELECT @Mensagem = '';

  DECLARE @Identificador Integer;

  --Verificando se está deixando o nome da pessoa em branco ou nula.
  IF (@NM_Pessoa = '') OR (@NM_Pessoa IS NULL)
  BEGIN
    SET @Mensagem = 'Nome Inválido'; 
    GOTO FIM;
  END
 
  --Verificando se está deixando o email da pessoa em branco ou nula.
  IF (@Email_Pessoa = '') OR (@Email_Pessoa IS NULL)
  BEGIN
    SET @Mensagem = 'Email Inválido'; 
    GOTO FIM;
  END
  
  --Verificando se está deixando a idade da pessoa em zero ou nulo.
  IF (@Idade_Pessoa = 0) OR (@Idade_Pessoa IS NULL)
  BEGIN
    SET @Mensagem = 'Idade Inválida'; 
    GOTO FIM;
  END

    --Verificando se está deixando o CPF da pessoa em zero ou nulo.
  IF (@CPF = '') OR (@CPF IS NULL)
  BEGIN
    SET @Mensagem = 'CPF Inválido'; 
    GOTO FIM;
  END

  --Se não existe uma pessoa com o cpf ja cadastrado, inserta
  IF NOT EXISTS (SELECT 1 FROM CadastroPessoas
                 WHERE CPF = @CPF )
  BEGIN 
    
    INSERT INTO dbo.CadastroPessoas ( NM_Pessoa
                                     ,Email_Pessoa
                                     ,Idade_Pessoa
                                     ,CPF)
    SELECT @NM_Pessoa
          ,@Email_Pessoa
          ,@Idade_Pessoa
          ,@CPF
      
      IF (@@ERROR <> 0 )
      BEGIN
      -- Se der um erro de sql de inserção, irá gravar uma mensagem na tabela log para ser verificado pelo time técnico
      --Mostrando em qual procedure está o erro e em qual tabela e qual Pessoa pra ficar mais fácil pra debugar.
        INSERT INTO tb_Log(Complemento)
        SELECT 'Proc: Inserir_Pessoas. Erro ao inserir na tabela CadastroPessoas' + 'Nome da Pessoa ' + @NM_Pessoa; 
      
      -- E volta uma mensagem amigável para o usuário.
        SELECT @Mensagem = 'Erro no sistema, consulte um técnico';    
        GOTO FIM;
      END
      --Pegando o ID_Identificador do ultimo registro inserido na tabela CadastroPessoas
      SET @Identificador = SCOPE_IDENTITY()
  END
  ELSE
  BEGIN
    -- Se existir uma pessoa com o mesmo CPF cadastrado, irá voltar uma mensagem avisando.
    SELECT @Mensagem = 'Pessoa já cadastrada no sistema, ' + 'Nome da Pessoa: ' + @NM_Pessoa + ' CPF: ' + @CPF;    
    GOTO FIM;
  END

  --Se tiver valor nesse variável, quer dizer que foi feito o cadastro com sucesso.
  IF (ISNULL(@Identificador,0) > 0)
  BEGIN
    SELECT @Mensagem = 'Cadastro de pessoa efetuado com sucesso ';
    Return;
  END
  

  RETURN 

  FIM:
  SELECT @Mensagem;
  RAISERROR(@Mensagem, 18, 1);

  Return;

END

