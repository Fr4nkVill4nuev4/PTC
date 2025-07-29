using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Credaris.Formulario
{
    public partial class pdcFormulario : Form
    {
        public pdcFormulario()
        {
            InitializeComponent();
        }

        private void pdcFormulario_Load(object sender, EventArgs e)
        {

        }


 

        private void btnPDC_Click(object sender, EventArgs e)
        {

            if (this.Visible)
            {
                return;
            }
            else
            {
                pdcFormulario pf = new pdcFormulario();
                pf.Show();
            }

        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnP_Click(object sender, EventArgs e)
        {
                FormnularioPE pe = new FormnularioPE();
                pe.Show();
   
        }

        private void btnCDP_Click(object sender, EventArgs e)
        {
            FormularioCDP CDP = new FormularioCDP();
            CDP.Show();
        }

        private void pictureBox10_Click(object sender, EventArgs e)
        {

        }
    }
}
