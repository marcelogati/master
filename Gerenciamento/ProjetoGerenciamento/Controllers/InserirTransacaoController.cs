using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using ProjetoGerenciamento.Model;
using System.Data;

[ApiController]
[Route("api/[controller]")]
public class TransacaoController : ControllerBase
{
    private readonly string _connectionString;

    public TransacaoController(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection");
    }

    [HttpPost]
    public async Task<IActionResult> InserirTransacao([FromBody] Transacao request)
    {
        try
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();

                using (SqlCommand comando = new SqlCommand("Inserir_Transacao", connection))
                {
                    comando.CommandType = CommandType.StoredProcedure;

                    comando.Parameters.AddWithValue("@Descricao", request.Descricao);
                    comando.Parameters.AddWithValue("@Valor", request.Valor);
                    comando.Parameters.AddWithValue("@Tipo", request.Tipo);
                    comando.Parameters.AddWithValue("@Identificador_Categoria", request.Identificador_Categoria);
                    comando.Parameters.AddWithValue("@Identificador_Pessoa", request.Identificador_Pessoa);

                    SqlParameter mensagem = new SqlParameter("@Mensagem", SqlDbType.VarChar, 255);
                    mensagem.Direction = ParameterDirection.Output;
                    comando.Parameters.Add(mensagem);

                    await comando.ExecuteNonQueryAsync();

                    string msg = mensagem.Value?.ToString();

                    return Ok(new
                    {
                        mensagem = msg
                    });
                }
            }
        }
        catch (SqlException ex)
        {
            return BadRequest(new
            {
                mensagem = ex.Message
            });
        }
    }
}