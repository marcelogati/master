CREATE OR ALTER PROCEDURE ListagemPessoa @Data_Inicial Datetime
                                        ,@Data_Final   Datetime
                                        ,@Mensagem     Varchar(255) OUTPUT

AS 
BEGIN
  SET NOCOUNT ON;

  DECLARE @Receita_Total Numeric(18,2)
         ,@Despesa_Total Numeric(18,2)

  SELECT @Mensagem = '';

  --Verificando se está deixando a Data Inicial em branco ou nula.
  IF (@Data_Inicial = '') OR (@Data_Inicial IS NULL)
  BEGIN
    SET @Mensagem = 'Data Inicial Inválida'; 
    GOTO FIM;
  END

  --Verificando se está deixando a Data Final em branco ou nula.
  IF (@Data_Final = '') OR (@Data_Final IS NULL)
  BEGIN
    SET @Mensagem = 'Data Final Inválida'; 
    GOTO FIM;
  END
  
  DECLARE @TMP table ( NM_Pessoa            Varchar(200)
                      ,Receita_Total_Pessoa Numeric(18,2)
                      ,Despesa_Total_Pessoa Numeric(18,2)
                      ,Receita_Total        Numeric(18,2)
                      ,Despesa_Total        Numeric(18,2)
                      ,Saldo                Numeric(18,2));

--Pegando o valor total de despesas e receitas no períodos de todas pessoas juntas.
  SELECT @Receita_Total =    SUM(CASE 
                                 WHEN CadastroTransacao.Tipo = 'R' --Receita 
                                 THEN CadastroTransacao.Valor 
                                 ELSE 0 
                                 END)
        ,@Despesa_Total = SUM(CASE 
                              WHEN CadastroTransacao.Tipo = 'D'  -- Despesa
                              THEN CadastroTransacao.Valor 
                              ELSE 0 
                              END)
  FROM dbo.CadastroTransacao
  WHERE Data_Inclusao BETWEEN @Data_Inicial AND @Data_Final 

  --Inserindo os dados na tabela temporária
  INSERT INTO @TMP ( NM_Pessoa
                    ,Receita_Total_Pessoa
                    ,Despesa_Total_Pessoa
                    ,Receita_Total
                    ,Despesa_Total
                    ,Saldo)
  SELECT Pessoas.NM_Pessoa
    ,SUM(CASE 
         WHEN Transacao.Tipo = 'R' THEN Transacao.Valor  --Total Receita por pessoa
         ELSE 0 
         END) AS TotalReceita
    ,SUM(CASE 
         WHEN Transacao.Tipo = 'D'  --Despesa Total por Pessoa
         THEN Transacao.Valor 
         ELSE 0 
         END) AS TotalDespesa
         ,@Receita_Total  --Total receita de todas as pessoas
         ,@Despesa_Total  --Total despesa de todas as pessoas
         ,@Receita_Total - @Despesa_Total --Calculando o Saldo
  FROM dbo.CadastroPessoas Pessoas
  INNER JOIN CadastroTransacao Transacao
  ON Transacao.Identificador_Pessoa = Pessoas.Identificador_Pessoa
  WHERE Data_Inclusao BETWEEN @Data_Inicial AND @Data_Final
  GROUP BY Pessoas.NM_Pessoa


  SELECT NM_Pessoa
        ,Receita_Total_Pessoa
        ,Despesa_Total_Pessoa
        ,Receita_Total
        ,Despesa_Total
        ,Saldo 
  FROM @TMP;

  Return

  FIM:
  SELECT @Mensagem
  RAISERROR(@Mensagem, 18, 1);

  Return

END

