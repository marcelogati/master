ALTER PROCEDURE Inserir_Usuario @CD_Usuario     Char(6)
                                ,@NM_Usuario    Varchar(100)
                                ,@Email_Usuario Varchar(50)
                                ,@Senha_Usuario Varchar(32)
                                ,@Idade_Usuario Integer

AS 
BEGIN

  IF (@CD_Usuario = '')  OR (@CD_Usuario IS NULL) 
  BEGIN
    RAISERROR ('C�digo do Usuario n�o pode ser nulo',16,1); 
    RETURN;
  END

  IF (@NM_Usuario = '') OR (@NM_Usuario IS NULL) 
  BEGIN
    RAISERROR ('Nome do Usuario n�o pode ser nulo',16,1); 
    RETURN;
  END

  IF (@Email_Usuario = '') OR (@Email_Usuario IS NULL) 
  BEGIN
    RAISERROR ('Email do Usuario n�o pode ser nulo',16,1); 
    RETURN;
  END

  IF (@Senha_Usuario = '') OR (@Senha_Usuario IS NULL)
  BEGIN
    RAISERROR ('Senha do Usuario n�o pode ser nulo',16,1); 
    RETURN;
  END

  IF (@Idade_Usuario = 0) OR (@Idade_Usuario IS NULL)
  BEGIN
    RAISERROR ('Idade do Usuario n�o pode ser nulo',16,1); 
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

