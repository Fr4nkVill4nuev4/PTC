using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace Credaris.Formulario
{
    public partial class FormularioCDP : Form
    {
       


        public FormularioCDP()
        {
            InitializeComponent();
        }


        SqlConnection conexion = new SqlConnection("server=LAB02-DS-EQ19\\SQLEXPRESS; Database=CREDARIS; Integrated Security=True");

        private void FormularioCDP_Load(object sender, EventArgs e)
        {
            string consulta = "select id_usuario, monto, numeroCuotas, tasaInteres, fechaInicio, estado from Prestamos";
            SqlDataAdapter adaptador = new SqlDataAdapter(consulta, conexion);
            DataTable dt = new DataTable();
            adaptador.Fill(dt);
            DVpagos.DataSource = dt;
            DGVpr.DataSource = dt;
        }

        private void btnP_Click(object sender, EventArgs e)
        {
            FormnularioPE pe = new FormnularioPE();
            pe.Show();
        }

        private void btnCDP_Click(object sender, EventArgs e)
        {
            if (this.Visible) 
            {
                return;
            }
            else
            {
                FormularioCDP CDP = new FormularioCDP();
                CDP.Show();
            }
        }

        private void btnPDC_Click(object sender, EventArgs e)
        {
            pdcFormulario pf = new pdcFormulario();
            pf.Show();
        }


        private void btnMC_Click(object sender, EventArgs e)
        {
            conexion.Open();
            string consulta = "select *  from Usuarios";
            SqlCommand comando = new SqlCommand(consulta, conexion);
            comando.ExecuteNonQuery();
            MessageBox.Show("Datos mostrados");
        }

        private void DVpagos_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void DGVpr_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

   

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void DVpagos_CellClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
