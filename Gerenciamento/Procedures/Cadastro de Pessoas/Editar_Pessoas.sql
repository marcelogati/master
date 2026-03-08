CREATE OR ALTER PROCEDURE Editar_Pessoas @Identificador_Pessoa Integer
                                        ,@NM_Pessoa            Varchar(200)
                                        ,@Email_Pessoa         Varchar(50)
                                        ,@Idade_Pessoa         Integer
                                        ,@CPF                  Varchar(11)
                                        ,@Mensagem             Varchar(255) OUTPUT

AS 
BEGIN
  SET NOCOUNT ON;

  SELECT @Mensagem = '';

  DECLARE @Identificador Integer;

  --Verificando se está deixando o nome da pessoa em branco ou nula.
  IF (@NM_Pessoa = '') OR (@NM_Pessoa IS NULL)
  BEGIN
    SET @Mensagem = 'Nome Inválido'; 
    GOTO FIM 
  END

    --Verificando se está deixando o email da pessoa em branco ou nula.
  IF (@Email_Pessoa = '') OR (@Email_Pessoa IS NULL)
  BEGIN
    SET @Mensagem = 'Email Inválido'; 
    GOTO FIM 
  END

    --Verificando se está deixando a idade da pessoa em zero ou nulo.
  IF (@Idade_Pessoa = 0) OR (@Idade_Pessoa IS NULL)
  BEGIN
    SET @Mensagem = 'Idade Inválida'; 
    GOTO FIM 
  END

  --Verificando se está informando CPF igual a zero ou deixando em branco, volta  uma mensagem pro usuário do sistema.
  IF (@CPF = '') OR (@CPF IS NULL)
  BEGIN
    SET @Mensagem = 'CPF Inválido'; 
    GOTO FIM 
  END

  --Verificando se está informando uma pessoa igual a zero ou deixando em branco, volta  uma mensagem pro usuário do sistema.
  IF (@Identificador_Pessoa = 0) OR (@Identificador_Pessoa IS NULL)
  BEGIN
    SET @Mensagem = 'Pessoa Inválida'; 
    GOTO FIM 
  END

  --Aqui faz uma verificação se já possui uma outra pessoa cadastrada com o CPF que está tentando alterar
  IF EXISTS (SELECT 1 FROM dbo.CadastroPessoas
             WHERE CPF = @CPF
               AND Identificador_Pessoa <> @Identificador_Pessoa)
  BEGIN
    SELECT @Mensagem = 'CPF já cadastrado em outra pessoa' + 'CPF: ' +@CPF;    
    GOTO FIM 
  END

  --Aqui faz uma verificação se a pessoa está cadastrada no sistema.
  IF NOT EXISTS (SELECT 1 FROM dbo.CadastroPessoas
                 WHERE Identificador_Pessoa = @Identificador_Pessoa)
  BEGIN
    SELECT @Mensagem = 'Pessoa não está cadastrada no sistema' + 'Identificador Pessoa: ' +@NM_Pessoa;    
    GOTO FIM 
  END

  --Atualização simples que altera todos os dados informados da pessoa,
  --Se não mudou nada, vai continuar o mesmo.
  UPDATE dbo.CadastroPessoas
  SET  NM_Pessoa    = @NM_Pessoa
      ,Email_Pessoa = @Email_Pessoa
      ,Idade_Pessoa = @Idade_Pessoa
      ,CPF          = @CPF
  WHERE Identificador_Pessoa = @Identificador_Pessoa
    
  IF (@@ERROR <> 0 )
  BEGIN
    INSERT INTO tb_Log(Complemento)
    SELECT 'Proc: Editar_Pessoas. Erro na atualização da tabela CadastroPessoas'
           + 'Nome da Pessoa ' + @NM_Pessoa + 'CPF ' + @CPF; 
  
    SELECT @Mensagem = 'Erro no sistema, consulte um técnico';    
    GOTO FIM 
  END
  ELSE
  BEGIN
    SELECT @Mensagem = 'Alteração de pessoa efetuado com sucesso ';
    RETURN;
  END

  RETURN

  FIM:
  SELECT @Mensagem
  RAISERROR(@Mensagem, 18, 1);

  RETURN;

END

