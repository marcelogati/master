using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Projeto
{
    public partial class frmLogin : Form
    {
        public frmLogin()
        {
            InitializeComponent();
        }

        private void button4_Click(object sender, EventArgs e)
        {
          frmCadastroUsuario form2 = new frmCadastroUsuario();
            form2.ShowDialog();
        }

        private void btnSair_Click(object sender, EventArgs e)
        {
          this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
          if (txtSenha.UseSystemPasswordChar == false)
          {
                txtSenha.UseSystemPasswordChar = true;
          }
          else
          {
                txtSenha.UseSystemPasswordChar = false;
          }
        }
    }
}
