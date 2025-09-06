namespace Projeto
{
    partial class Form2
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.lblNomeUsuario = new System.Windows.Forms.Label();
            this.lblEmail = new System.Windows.Forms.Label();
            this.lblSenha = new System.Windows.Forms.Label();
            this.txtNomeUsuario = new System.Windows.Forms.TextBox();
            this.txtEmailUsuario = new System.Windows.Forms.TextBox();
            this.txtSenhaUsuario = new System.Windows.Forms.TextBox();
            this.btnGravar = new System.Windows.Forms.Button();
            this.btnSair = new System.Windows.Forms.Button();
            this.txtIdadeUsuario = new System.Windows.Forms.TextBox();
            this.lblIdade = new System.Windows.Forms.Label();
            this.txtCodUsuario = new System.Windows.Forms.TextBox();
            this.lblCodUsuario = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // lblNomeUsuario
            // 
            this.lblNomeUsuario.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblNomeUsuario.Location = new System.Drawing.Point(20, 39);
            this.lblNomeUsuario.Name = "lblNomeUsuario";
            this.lblNomeUsuario.Size = new System.Drawing.Size(69, 20);
            this.lblNomeUsuario.TabIndex = 0;
            this.lblNomeUsuario.Text = "Nome";
            // 
            // lblEmail
            // 
            this.lblEmail.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblEmail.Location = new System.Drawing.Point(20, 65);
            this.lblEmail.Name = "lblEmail";
            this.lblEmail.Size = new System.Drawing.Size(69, 26);
            this.lblEmail.TabIndex = 1;
            this.lblEmail.Text = "Email";
            // 
            // lblSenha
            // 
            this.lblSenha.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblSenha.Location = new System.Drawing.Point(20, 91);
            this.lblSenha.Name = "lblSenha";
            this.lblSenha.Size = new System.Drawing.Size(80, 26);
            this.lblSenha.TabIndex = 2;
            this.lblSenha.Text = "Senha";
            // 
            // txtNomeUsuario
            // 
            this.txtNomeUsuario.Location = new System.Drawing.Point(160, 37);
            this.txtNomeUsuario.Name = "txtNomeUsuario";
            this.txtNomeUsuario.Size = new System.Drawing.Size(215, 22);
            this.txtNomeUsuario.TabIndex = 3;
            // 
            // txtEmailUsuario
            // 
            this.txtEmailUsuario.Location = new System.Drawing.Point(160, 65);
            this.txtEmailUsuario.Name = "txtEmailUsuario";
            this.txtEmailUsuario.Size = new System.Drawing.Size(215, 22);
            this.txtEmailUsuario.TabIndex = 4;
            // 
            // txtSenhaUsuario
            // 
            this.txtSenhaUsuario.Location = new System.Drawing.Point(160, 91);
            this.txtSenhaUsuario.Name = "txtSenhaUsuario";
            this.txtSenhaUsuario.Size = new System.Drawing.Size(215, 22);
            this.txtSenhaUsuario.TabIndex = 5;
            // 
            // btnGravar
            // 
            this.btnGravar.Location = new System.Drawing.Point(160, 168);
            this.btnGravar.Name = "btnGravar";
            this.btnGravar.Size = new System.Drawing.Size(75, 23);
            this.btnGravar.TabIndex = 6;
            this.btnGravar.Text = "Gravar";
            this.btnGravar.UseVisualStyleBackColor = true;
            this.btnGravar.Click += new System.EventHandler(this.btnGravar_Click);
            // 
            // btnSair
            // 
            this.btnSair.Location = new System.Drawing.Point(260, 168);
            this.btnSair.Name = "btnSair";
            this.btnSair.Size = new System.Drawing.Size(78, 23);
            this.btnSair.TabIndex = 7;
            this.btnSair.Text = "Sair";
            this.btnSair.UseVisualStyleBackColor = true;
            this.btnSair.Click += new System.EventHandler(this.btnSair_Click);
            // 
            // txtIdadeUsuario
            // 
            this.txtIdadeUsuario.Location = new System.Drawing.Point(160, 121);
            this.txtIdadeUsuario.Name = "txtIdadeUsuario";
            this.txtIdadeUsuario.Size = new System.Drawing.Size(215, 22);
            this.txtIdadeUsuario.TabIndex = 9;
            // 
            // lblIdade
            // 
            this.lblIdade.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblIdade.Location = new System.Drawing.Point(20, 117);
            this.lblIdade.Name = "lblIdade";
            this.lblIdade.Size = new System.Drawing.Size(80, 43);
            this.lblIdade.TabIndex = 8;
            this.lblIdade.Text = "Idade";
            // 
            // txtCodUsuario
            // 
            this.txtCodUsuario.Location = new System.Drawing.Point(160, 9);
            this.txtCodUsuario.Name = "txtCodUsuario";
            this.txtCodUsuario.Size = new System.Drawing.Size(215, 22);
            this.txtCodUsuario.TabIndex = 11;
            // 
            // lblCodUsuario
            // 
            this.lblCodUsuario.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblCodUsuario.Location = new System.Drawing.Point(20, 9);
            this.lblCodUsuario.Name = "lblCodUsuario";
            this.lblCodUsuario.Size = new System.Drawing.Size(134, 20);
            this.lblCodUsuario.TabIndex = 10;
            this.lblCodUsuario.Text = "Cod. Usuario";
            // 
            // Form2
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
            this.ClientSize = new System.Drawing.Size(398, 198);
            this.Controls.Add(this.txtCodUsuario);
            this.Controls.Add(this.lblCodUsuario);
            this.Controls.Add(this.txtIdadeUsuario);
            this.Controls.Add(this.lblIdade);
            this.Controls.Add(this.btnSair);
            this.Controls.Add(this.btnGravar);
            this.Controls.Add(this.txtSenhaUsuario);
            this.Controls.Add(this.txtEmailUsuario);
            this.Controls.Add(this.txtNomeUsuario);
            this.Controls.Add(this.lblSenha);
            this.Controls.Add(this.lblEmail);
            this.Controls.Add(this.lblNomeUsuario);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "Form2";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Cadastro de Usuário";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblNomeUsuario;
        private System.Windows.Forms.Label lblEmail;
        private System.Windows.Forms.Label lblSenha;
        private System.Windows.Forms.TextBox txtNomeUsuario;
        private System.Windows.Forms.TextBox txtEmailUsuario;
        private System.Windows.Forms.TextBox txtSenhaUsuario;
        private System.Windows.Forms.Button btnGravar;
        private System.Windows.Forms.Button btnSair;
        private System.Windows.Forms.TextBox txtIdadeUsuario;
        private System.Windows.Forms.Label lblIdade;
        private System.Windows.Forms.TextBox txtCodUsuario;
        private System.Windows.Forms.Label lblCodUsuario;
    }
}