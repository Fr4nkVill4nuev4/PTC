using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Credaris.Formulario;

namespace Credaris
{
    public partial class FormularioUsuario : Form
    {
        public FormularioUsuario()
        {
            InitializeComponent();
        }
        private void txtName_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtPassword_TextChanged(object sender, EventArgs e)
        {

        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            pdcFormulario pf = new pdcFormulario();
            if (string.IsNullOrEmpty(txtName.Text) || string.IsNullOrEmpty(txtPassword.Text))
            {
                MessageBox.Show("Ingrese el usuario y la contrseña");
            }else
            {
                pf.Show();
                txtName.Text = "";
                txtPassword.Text = "";
            }
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
