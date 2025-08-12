using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml.Linq;

namespace Credaris.Formulario
{
    public partial class FormnularioPE : Form
    {
        public FormnularioPE()
        {
            InitializeComponent();
        }


        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnPDC_Click(object sender, EventArgs e)
        {
            string nombreUsuario = "test";
            pdcFormulario pf = new pdcFormulario(nombreUsuario);

            pf.Show();
        }

        private void btnCDP_Click(object sender, EventArgs e)
        {
            FormularioCDP CDP = new FormularioCDP();
            CDP.Show();
        }

        private void btnP_Click(object sender, EventArgs e)
        {
            if (this.Visible) {
                return;
            }else
            {
                FormnularioPE pe = new FormnularioPE();
                pe.Show();
            }
        }

        private void FormnularioPE_Load_1(object sender, EventArgs e)
        {

        }

        private void FormnularioPE_Load(object sender, EventArgs e)
        {

        }

        private void DVGpdc_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void dgvNombre_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
