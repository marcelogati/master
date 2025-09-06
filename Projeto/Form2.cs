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
    public partial class Form2 : Form
    {
        public Form2()
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
                    command.Parameters.AddWithValue("@Idade_Usuario", int.Parse(txtIdadeUsuario.Text));
                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();
                    MessageBox.Show("Usuario cadastrado com sucesso!");
                    txtCodUsuario.Clear();
                    txtNomeUsuario.Clear();
                    txtEmailUsuario.Clear();
                    txtSenhaUsuario.Clear();
                    txtIdadeUsuario.Clear();
                }
            }
        }
    }
}
