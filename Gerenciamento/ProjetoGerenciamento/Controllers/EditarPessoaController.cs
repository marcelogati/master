using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using ProjetoGerenciamento.Model;
using System.Data;

namespace ProjetoGerenciamento.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PessoaController : ControllerBase
    {
        private readonly string _connectionString;

        public PessoaController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        [HttpPut("editar")]
        public async Task<IActionResult> EditarPessoa([FromBody] EditarPessoa request)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(_connectionString))
                {
                    await connection.OpenAsync();

                    using (SqlCommand comando = new SqlCommand("dbo.Editar_Pessoas", connection))
                    {
                        comando.CommandType = CommandType.StoredProcedure;

                        comando.Parameters.AddWithValue("@Identificador_Pessoa", request.Identificador_Pessoa);
                        comando.Parameters.AddWithValue("@NM_Pessoa", request.NM_Pessoa);
                        comando.Parameters.AddWithValue("@Email_Pessoa", request.Email_Pessoa);
                        comando.Parameters.AddWithValue("@Idade_Pessoa", request.Idade_Pessoa);
                        comando.Parameters.AddWithValue("@CPF", request.CPF);

                        SqlParameter mensagem = new SqlParameter("@Mensagem", SqlDbType.VarChar, 255);
                        mensagem.Direction = ParameterDirection.Output;
                        comando.Parameters.Add(mensagem);

                        await comando.ExecuteNonQueryAsync();

                        string msg = mensagem.Value?.ToString();

                        if (!string.IsNullOrEmpty(msg))
                        {
                            if (msg.Contains("sucesso"))
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