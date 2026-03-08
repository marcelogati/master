using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using ProjetoGerenciamento.Model;
using System.Data;

[ApiController]
[Route("api/[controller]")]
public class CategoriaController : ControllerBase
{
    private readonly string _connectionString;

    public CategoriaController(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection");
    }

    [HttpPost]
    public async Task<IActionResult> InserirCategoria([FromBody] Categoria request)
    {
        try
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();

                using (SqlCommand comando = new SqlCommand("Inserir_Categoria", connection))
                {
                    comando.CommandType = CommandType.StoredProcedure;

                    comando.Parameters.AddWithValue("@Descricao", request.Descricao);
                    comando.Parameters.AddWithValue("@Finalidade", request.Finalidade);

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