ALTER PROCEDURE Inserir_Usuario @CD_Usuario     Char(6)
                                ,@NM_Usuario    Varchar(100)
                                ,@Email_Usuario Varchar(50)
                                ,@Senha_Usuario Varchar(32)
                                ,@Idade_Usuario Integer
                                ,@Mensagem_Erro Varchar(255) OUTPUT

AS 
BEGIN

  SET @Mensagem_Erro = '';

  IF (@CD_Usuario = '')  OR (@CD_Usuario IS NULL) 
  BEGIN
    SET @Mensagem_Erro = 'Código do Usuario não pode ser nulo'; 
    RETURN;
  END

  IF (@NM_Usuario = '') OR (@NM_Usuario IS NULL) 
  BEGIN
    SET @Mensagem_Erro = 'Nome do Usuario não pode ser nulo'; 
    RETURN;
  END

  IF (@Email_Usuario = '') OR (@Email_Usuario IS NULL) 
  BEGIN
    SET @Mensagem_Erro = 'Email do Usuario não pode ser nulo'; 
    RETURN;
  END

  IF (@Senha_Usuario = '') OR (@Senha_Usuario IS NULL)
  BEGIN
    SET @Mensagem_Erro = 'Senha do Usuario não pode ser nulo'; 
    RETURN;
  END

  IF (@Idade_Usuario = 0) OR (@Idade_Usuario IS NULL)
  BEGIN
    SET @Mensagem_Erro = 'Idade do Usuario não pode ser nulo'; 
    RETURN;
  END
  
  INSERT INTO Usuario ( CD_Usuario
                       ,NM_Usuario
                       ,Email_Usuario
                       ,Senha_Usuario
                       ,Idade_usuario)
  SELECT @CD_Usuario
        ,@NM_Usuario
        ,@Email_Usuario
        ,@Senha_Usuario
        ,@Idade_Usuario

END

