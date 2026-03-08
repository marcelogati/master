using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using ProjetoGerenciamento.Model;
using System.Data;

namespace ProjetoGerenciamento.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DeletarPessoaController : ControllerBase
    {
        private readonly string _connectionString;

        public DeletarPessoaController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        [HttpDelete("deletar")]
        public async Task<IActionResult> DeletarPessoa([FromBody] DeletarPessoa request)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(_connectionString))
                {
                    await connection.OpenAsync();

                    using (SqlCommand comando = new SqlCommand("dbo.Deletar_Pessoas", connection))
                    {
                        comando.CommandType = CommandType.StoredProcedure;

                        comando.Parameters.AddWithValue("@Identificador_Pessoa", request.Identificador_Pessoa);

                        SqlParameter mensagem = new SqlParameter("@Mensagem", SqlDbType.VarChar, 255);
                        mensagem.Direction = ParameterDirection.Output;
                        comando.Parameters.Add(mensagem);

                        await comando.ExecuteNonQueryAsync();

                        string msg = mensagem.Value?.ToString();

                        if (!string.IsNullOrEmpty(msg))
                        {
                            if (msg.ToLower().Contains("sucesso"))
                            {
                                return Ok(msg);
                            }

                            return BadRequest(msg);
                        }

                        return Ok(msg);
                    }
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
    }
}