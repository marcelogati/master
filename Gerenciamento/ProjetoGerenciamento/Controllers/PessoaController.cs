using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using ProjetoGerenciamento.Model;
using System.Data;

[ApiController]
[Route("api/[controller]")]
public class PessoaController : ControllerBase
{
    private readonly string _connectionString;

    public PessoaController(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection");
    }

    [HttpPost]
    public async Task<IActionResult> InserirPessoa([FromBody] Pessoa request)
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                await conn.OpenAsync();

                using (SqlCommand cmd = new SqlCommand("Inserir_Pessoas", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@NM_Pessoa", request.NM_Pessoa);
                    cmd.Parameters.AddWithValue("@Email_Pessoa", request.Email_Pessoa);
                    cmd.Parameters.AddWithValue("@Idade_Pessoa", request.Idade_Pessoa);
                    cmd.Parameters.AddWithValue("@CPF", request.CPF);

                    SqlParameter mensagem = new SqlParameter("@Mensagem", SqlDbType.VarChar, 255);
                    mensagem.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(mensagem);

                    await cmd.ExecuteNonQueryAsync();

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