using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace Rodaro
{
    public partial class Form1 : Form
    {
        List<int> ListaLidos = new List<int>();
        DataTable dtVertical = new DataTable();
        List<int> Linha1 = new List<int>() { 1,4,7,10,13,16,19,22,25,28,31,34};
        List<int> Linha2 = new List<int>() { 2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32 };
        List<int> Linha3 = new List<int>() { 3,6,9,12,15,18,21,24,27,30,33,36};

        List<int> Coluna1 = new List<int>() { 1,2,3,4,5,6,7,8,9,10,11,12};
        List<int> Coluna2 = new List<int>() { 13,14,15,16,17,18,19,20,21,22,23,24};
        List<int> Coluna3 = new List<int>() { 25,26,27,28,29,30,31,32,33,34,35,36};

        int OscilacaoLinha1 = 0;
        int OscilacaoLinha2 = 0;
        int OscilacaoLinha3 = 0;

        int OscilacaoColuna1 = 0;
        int OscilacaoColuna2 = 0;
        int OscilacaoColuna3 = 0;

        int UltimoNumero = 0;

        public Form1()
        {
            InitializeComponent();
            dtVertical.Columns.Add("numero",typeof(int));
            dtVertical.Columns.Add("quantidade",typeof(int));
            for (int i=0;i<=36;i++)
            {
                DataRow reg = dtVertical.NewRow();
                reg["numero"] = i;
                dtVertical.Rows.Add(reg);
            }
        }

        private void btnLer_Click(object sender, EventArgs e)
        {
            ler();
        }


        private void VerificaOscilacao(int numeroAnterior, int numeroAtual, List<int> ListaPadrao, ref int Oscilacao)
        {
            if (ListaPadrao.Contains(numeroAnterior) && ListaPadrao.Contains(numeroAtual))
                Oscilacao = 0;

            if (ListaPadrao.Contains(numeroAnterior) )
                if (!ListaPadrao.Contains(numeroAtual))
                    Oscilacao ++;

        }

        private void AtrelaOscilacao(ref TextBox tb, int numero)
        {
            tb.Text = numero.ToString();

            if (numero > 9)
                tb.BackColor = Color.Yellow;
            else
                tb.BackColor = Color.White;
        }
        

        private void ler()
        {


            for (int i = 0; i <= 36; i++)
            {
                dtDataro.Rows[0][i] = Convert.ToInt32(dtDataro.Rows[0][i]) + 1;
                dtVertical.Rows[i]["quantidade"] = Convert.ToInt32(dtDataro.Rows[0][i]) ;
            }
            lblUltimo.Text = tbNumero.Text;
            dtDataro.Rows[0]["Column" + tbNumero.Text] = 0;

            atualiza();

            int NumeroLido = Convert.ToInt32(tbNumero.Text);


            VerificaOscilacao(NumeroLido, UltimoNumero, Linha1, ref OscilacaoLinha1);
            VerificaOscilacao(NumeroLido, UltimoNumero, Linha2, ref OscilacaoLinha2);
            VerificaOscilacao(NumeroLido, UltimoNumero, Linha3, ref OscilacaoLinha3);
            VerificaOscilacao(NumeroLido, UltimoNumero, Coluna1, ref OscilacaoColuna1);
            VerificaOscilacao(NumeroLido, UltimoNumero, Coluna2, ref OscilacaoColuna2);
            VerificaOscilacao(NumeroLido, UltimoNumero, Coluna3, ref OscilacaoColuna3);

            UltimoNumero = NumeroLido;


            AtrelaOscilacao(ref tbOscilacaoLinha1, OscilacaoLinha1);
            AtrelaOscilacao(ref tbOscilacaoLinha2, OscilacaoLinha2);
            AtrelaOscilacao(ref tbOscilacaoLinha3, OscilacaoLinha3);
            AtrelaOscilacao(ref tbOscilacaoColuna1, OscilacaoColuna1);
            AtrelaOscilacao(ref tbOscilacaoColuna2, OscilacaoColuna2);
            AtrelaOscilacao(ref tbOscilacaoColuna3, OscilacaoColuna3);
            


            ListaLidos.Add(Convert.ToInt32(lblUltimo.Text));

            tbNumero.Text = "";
            lblListaUltimos.Text = "";
            for (int a = ListaLidos.Count - 1; a >= 0; a--)
                lblListaUltimos.Text += ListaLidos[a].ToString()+" - ";

            if (ListaLidos.Count == 10)
                ListaLidos.RemoveAt(0);

            for (int i = 0; i <= 36; i++)
            {
                dtVertical.Rows[i]["quantidade"] = Convert.ToInt32(dtDataro.Rows[0][i]);
            }
            dataGridView2.DataSource = dtVertical;
            dataGridView2.Refresh();

            dataGridView2.CurrentCell = dataGridView2.Rows[0].Cells[0];

        }

        private void button1_Click(object sender, EventArgs e)
        {

            dtDataro.Rows.Clear();
            DataRow r = dtDataro.NewRow();

            for (int i = 0; i<= dtDataro.Columns.Count-1; i++)
            {
                r[i] = 0;
            }

            dtDataro.Rows.Add(r);
           // dataGridView1.DataSource = dtDataro;
           // dataGridView1.Refresh();


        }

        private void Form1_Load(object sender, EventArgs e)
        {
            foreach (Control c in panel1.Controls)
            {
                c.Text = c.Name.Replace("label", "");
                c.ForeColor = Color.Black;
            }

            foreach (DataGridViewColumn c in dataGridView1.Columns)
            {
                c.Width = 25;
            }
        }

        private void atualiza()
        {
            for (int i = 0; i <= 36; i++)
            {
                Control[] aControl = panel1.Controls.Find("label" + i, false);
                aControl[0].ForeColor = Color.Black;
            }

            for (int i = 0; i <= 36; i++)
            {
                if (Convert.ToInt32(dtDataro.Rows[0][i]) > 36)
                {
                    Control[] aControl= panel1.Controls.Find("label" +i,false);
                    aControl[0].ForeColor = Color.Red;
                }

                if (Convert.ToInt32(dtDataro.Rows[0][i]) > 70)
                {
                    Control[] aControl = panel1.Controls.Find("label" + i, false);
                    aControl[0].ForeColor = Color.Blue;
                }

                if (Convert.ToInt32(dtDataro.Rows[0][i]) > 130)
                {
                    Control[] aControl = panel1.Controls.Find("label" + i, false);
                    aControl[0].ForeColor = Color.Yellow;
                }



            }
        }

        private void tbNumero_MouseDown(object sender, MouseEventArgs e)
        {
            
        }

        private void tbNumero_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                ler();
            }
        }

        private void textBox1_DoubleClick(object sender, EventArgs e)
        {
            textBox1.ReadOnly = !textBox1.ReadOnly;
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
