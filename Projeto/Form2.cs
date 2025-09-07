using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace Projeto
{
    public partial class frmCadastroUsuario : Form
    {
        public frmCadastroUsuario()
        {
            InitializeComponent();
        }

        private void btnSair_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnGravar_Click(object sender, EventArgs e)
        {
           string connectionString = @"Data Source=DESKTOP-GKLCG8E\SQLEXPRESS;Initial Catalog=Sistema;User ID=Marcelo;Password=123456";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {           
                using (SqlCommand command = new SqlCommand("dbo.Inserir_Usuario", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@CD_Usuario"   , txtCodUsuario.Text);
                    command.Parameters.AddWithValue("@NM_Usuario"   , txtNomeUsuario.Text);
                    command.Parameters.AddWithValue("@Email_Usuario", txtEmailUsuario.Text);
                    command.Parameters.AddWithValue("@Senha_Usuario", txtSenhaUsuario.Text);

                    // --- Idade: TryParse e envia DBNull se vazio/inválido ---
                    int idade;
                    if (int.TryParse(txtIdadeUsuario.Text, out idade))
                    {
                        command.Parameters.AddWithValue("@Idade_Usuario", idade);
                    }
                    else
                    {
                        // envia NULL para o banco (procedure deve aceitar NULL)
                        command.Parameters.AddWithValue("@Idade_Usuario", DBNull.Value);
                    }

                    // parâmetro de saída
                    SqlParameter mensagemParam = new SqlParameter("@Mensagem_Erro", SqlDbType.VarChar, 255);
                    mensagemParam.Direction = ParameterDirection.Output;
                    command.Parameters.Add(mensagemParam);

                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();

                    string mensagem = mensagemParam.Value?.ToString();

                    if (!string.IsNullOrEmpty(mensagem)) // Se veio uma mensagem de erro mostra pro usuário
                    {
                       MessageBox.Show(mensagem, "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    }
                    else
                    {
                       MessageBox.Show("Usuário cadastrado com sucesso!");
                       txtCodUsuario.Clear();
                       txtNomeUsuario.Clear();
                       txtEmailUsuario.Clear();
                       txtSenhaUsuario.Clear();
                       txtIdadeUsuario.Clear();
                    }
                }
            }
        }

        private void btnMostrarSenha_Click(object sender, EventArgs e)
        {
          if (txtSenhaUsuario.UseSystemPasswordChar == false)
            {
                txtSenhaUsuario.UseSystemPasswordChar = true;
            }
            else
            {
                txtSenhaUsuario.UseSystemPasswordChar = false;
            }
        }
    }
}
