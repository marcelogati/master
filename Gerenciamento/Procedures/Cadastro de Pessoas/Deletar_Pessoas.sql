CREATE OR ALTER PROCEDURE Deletar_Pessoas @Identificador_Pessoa Integer
                                         ,@Mensagem             Varchar(255) OUTPUT

AS 
BEGIN
  SET NOCOUNT ON;

  SELECT @Mensagem = '';

  DECLARE @Identificador Integer
         ,@NM_Pessoa     Varchar(200);

  --Aqui faz uma verificação se a pessoa está cadastrada no sistema.
  IF NOT EXISTS (SELECT 1 FROM dbo.CadastroPessoas
                 WHERE Identificador_Pessoa = @Identificador_Pessoa)
  BEGIN 
    SELECT @Mensagem = 'Pessoa não está cadastrada no sistema, ' + 'Identificador Pessoa: ' + CAST(@Identificador_Pessoa AS VARCHAR(30));    
    GOTO FIM 
  END

  --Pegando o nome da pessoa para colocar no log caso dê erro.
  SELECT @NM_Pessoa = NM_Pessoa
  FROM dbo.CadastroPessoas
  WHERE Identificador_Pessoa = @Identificador_Pessoa

  --Deletando as transações da pessoa que ja foi apagada.
  DELETE dbo.CadastroTransacao
  WHERE Identificador_Pessoa = @Identificador_Pessoa

    
  IF (@@ERROR <> 0 )
  BEGIN
  --Inserta a mensagem de erro no log para o time técnico.
    INSERT INTO tb_Log(Complemento)
    SELECT 'Proc: Deletar_Pessoas. Erro na exclusão de uma transação da pessoa excluída da tabela CadastroTransacao'
           + 'Nome da Pessoa ' + @NM_Pessoa; 
  
  --Exibe uma mensagem amigável ao usuário.
    SELECT @Mensagem = 'Erro no sistema, consulte um técnico';    
    GOTO FIM;
  END

  --Deletando a pessoa na tabela  CadastroPessoas
  DELETE dbo.CadastroPessoas
  WHERE Identificador_Pessoa = @Identificador_Pessoa
    
  IF (@@ERROR <> 0 )
  BEGIN
  --Inserta a mensagem de erro no log para o time técnico.
    INSERT INTO tb_Log(Complemento)
    SELECT 'Proc: Deletar_Pessoas. Erro na exclusão de uma pessoa da tabela CadastroPessoas'
           + 'Nome da Pessoa ' + @NM_Pessoa; 
  
  --Exibe uma mensagem amigável ao usuário.
    SELECT @Mensagem = 'Erro no sistema, consulte um técnico';    
    GOTO FIM;
  END

  IF NOT EXISTS (SELECT 1 FROM dbo.CadastroPessoas WHERE Identificador_Pessoa = @Identificador_Pessoa)
     AND NOT EXISTS (SELECT 1 FROM dbo.CadastroTransacao WHERE Identificador_Pessoa = @Identificador_Pessoa)

  BEGIN
  --Se deu certo, volta uma mensagem dizendo que foi excluído com sucesso a pessoa e os dados de transação dela.
    SELECT @Mensagem = 'Pessoa  e transações excluídas com sucesso ';
    RETURN;
  END


  RETURN
  FIM:
  SELECT @Mensagem
  RAISERROR(@Mensagem, 18, 1);

  RETURN;

END

