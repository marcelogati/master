CREATE TABLE Usuario ( ID_Usuario    Integer INT IDENTITY(1,1) PRIMARY KEY,
                       CD_Usuario    Char(6),
                       NM_Usuario    Varchar(100),
                       Email_Usuario Varchar(50),
                       Senha_Usuario Varchar(32),
                       Idade_Usuario Integer
);


--Criando indice pra não poder criar outro usuario com o mesmo email de um que ja foi registrado
CREATE UNIQUE INDEX IX_Usuario_Email
ON dbo.Usuario (Email_Usuario);