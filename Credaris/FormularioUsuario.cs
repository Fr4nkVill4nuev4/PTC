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
using System.Data.SqlClient;

namespace Credaris
{
    public partial class FormularioUsuario : Form
    {
        public FormularioUsuario()
        {
            InitializeComponent();
        }

        public SqlConnection coneccion = new SqlConnection("server=LAB02-DS-EQ19\\SQLEXPRESS; Database=CREDARIS; Integrated Security=True");

        private void txtName_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtPassword_TextChanged(object sender, EventArgs e)
        {

        }

        private void btnLogin_Click(object sender, EventArgs e)
        {

            string nombreUsuario = txtName.Text;
            pdcFormulario pf = new pdcFormulario(nombreUsuario);

            try
            {
                coneccion.Open();
                SqlCommand comando = new SqlCommand("SELECT usuario, contrasena from Usuarios WHERE usuario = @vusuario AND contrasena = @contrasena", coneccion);
                comando.Parameters.AddWithValue("@vusuario", txtName.Text);
                comando.Parameters.AddWithValue("@contrasena", txtPassword.Text);
                SqlDataReader reader = comando.ExecuteReader();


                if (reader.Read())
                {
                    coneccion.Close();
                    this.Hide();
                    pf.Show();
                }
                else
                {
                    MessageBox.Show("Usuario o contraseña incorrectos. Por favor, inténtelo de nuevo.", "Error de inicio de sesión", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al iniciar sesión: " + ex.Message);
                return;
            }
            finally
            {
                if (coneccion.State == ConnectionState.Open)
                    coneccion.Close();
            }
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
