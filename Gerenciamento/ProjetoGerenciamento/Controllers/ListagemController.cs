using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;

namespace ProjetoGerenciamento.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ListagemController : ControllerBase
    {
        private readonly string _connectionString;

        public ListagemController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        [HttpGet("listagem")]
        public async Task<IActionResult> ListagemPessoa(DateTime dataInicial, DateTime dataFinal)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync();

                using (SqlCommand cmd = new SqlCommand("dbo.ListagemPessoa", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Data_Inicial", dataInicial);
                    cmd.Parameters.AddWithValue("@Data_Final", dataFinal);

                    SqlParameter mensagem = new SqlParameter("@Mensagem", SqlDbType.VarChar, 255);
                    mensagem.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(mensagem);

                    SqlDataReader reader = await cmd.ExecuteReaderAsync();

                    List<object> pessoas = new List<object>();

                    while (reader.Read())
                    {
                        pessoas.Add(new
                        {
                            Nome               = reader["NM_Pessoa"].ToString(),
                            ReceitaTotalPessoa = reader["Receita_Total_Pessoa"],
                            DespesaTotalPessoa = reader["Despesa_Total_Pessoa"],
                            ReceitaTotal       = reader["Receita_Total"],
                            DespesaTotal       = reader["Despesa_Total"],
                            Saldo              = reader["Saldo"]
                        });
                    }

                    return Ok(pessoas);
                }
            }
        }
    }
}