namespace test1
{
    partial class Form1
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.label1 = new System.Windows.Forms.Label();
            this.progressBar1 = new System.Windows.Forms.ProgressBar();
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tabPage4 = new System.Windows.Forms.TabPage();
            this.richTextBox1 = new System.Windows.Forms.RichTextBox();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.buttonPrePatch = new System.Windows.Forms.Button();
            this.buttonPreDL = new System.Windows.Forms.Button();
            this.richTextBox2 = new System.Windows.Forms.RichTextBox();
            this.tabPage2 = new System.Windows.Forms.TabPage();
            this.buttonWinlogPatch = new System.Windows.Forms.Button();
            this.buttonWinlogDL = new System.Windows.Forms.Button();
            this.richTextBox3 = new System.Windows.Forms.RichTextBox();
            this.tabPage3 = new System.Windows.Forms.TabPage();
            this.button1 = new System.Windows.Forms.Button();
            this.buttonMissingDL = new System.Windows.Forms.Button();
            this.richTextBox4 = new System.Windows.Forms.RichTextBox();
            this.tabControl1.SuspendLayout();
            this.tabPage4.SuspendLayout();
            this.tabPage1.SuspendLayout();
            this.tabPage2.SuspendLayout();
            this.tabPage3.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.Font = new System.Drawing.Font("Segoe UI", 20F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(80, 8);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(640, 43);
            this.label1.TabIndex = 0;
            this.label1.Text = "Easy-Patcher NT5 Source Patcher";
            this.label1.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            this.label1.Click += new System.EventHandler(this.label1_Click_1);
            // 
            // progressBar1
            // 
            this.progressBar1.Location = new System.Drawing.Point(8, 416);
            this.progressBar1.Name = "progressBar1";
            this.progressBar1.Size = new System.Drawing.Size(784, 23);
            this.progressBar1.TabIndex = 1;
            this.progressBar1.Click += new System.EventHandler(this.progressBar1_Click);
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tabPage4);
            this.tabControl1.Controls.Add(this.tabPage1);
            this.tabControl1.Controls.Add(this.tabPage2);
            this.tabControl1.Controls.Add(this.tabPage3);
            this.tabControl1.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tabControl1.Location = new System.Drawing.Point(8, 64);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(784, 344);
            this.tabControl1.TabIndex = 5;
            // 
            // tabPage4
            // 
            this.tabPage4.Controls.Add(this.richTextBox1);
            this.tabPage4.Location = new System.Drawing.Point(4, 26);
            this.tabPage4.Name = "tabPage4";
            this.tabPage4.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage4.Size = new System.Drawing.Size(776, 314);
            this.tabPage4.TabIndex = 3;
            this.tabPage4.Text = "Home";
            this.tabPage4.UseVisualStyleBackColor = true;
            // 
            // richTextBox1
            // 
            this.richTextBox1.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.richTextBox1.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.richTextBox1.Location = new System.Drawing.Point(8, 8);
            this.richTextBox1.Name = "richTextBox1";
            this.richTextBox1.ReadOnly = true;
            this.richTextBox1.Size = new System.Drawing.Size(488, 304);
            this.richTextBox1.TabIndex = 0;
            this.richTextBox1.Text = resources.GetString("richTextBox1.Text");
            this.richTextBox1.TextChanged += new System.EventHandler(this.richTextBox1_TextChanged);
            // 
            // tabPage1
            // 
            this.tabPage1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.tabPage1.Controls.Add(this.buttonPrePatch);
            this.tabPage1.Controls.Add(this.buttonPreDL);
            this.tabPage1.Controls.Add(this.richTextBox2);
            this.tabPage1.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tabPage1.Location = new System.Drawing.Point(4, 26);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(776, 314);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "Win2K3 Patch";
            this.tabPage1.UseVisualStyleBackColor = true;
            // 
            // buttonPrePatch
            // 
            this.buttonPrePatch.Location = new System.Drawing.Point(625, 208);
            this.buttonPrePatch.Name = "buttonPrePatch";
            this.buttonPrePatch.Size = new System.Drawing.Size(135, 64);
            this.buttonPrePatch.TabIndex = 2;
            this.buttonPrePatch.Text = "Download and Patch Now..";
            this.buttonPrePatch.UseVisualStyleBackColor = true;
            this.buttonPrePatch.Click += new System.EventHandler(this.buttonPrePatch_Click);
            // 
            // buttonPreDL
            // 
            this.buttonPreDL.Location = new System.Drawing.Point(624, 104);
            this.buttonPreDL.Name = "buttonPreDL";
            this.buttonPreDL.Size = new System.Drawing.Size(136, 64);
            this.buttonPreDL.TabIndex = 1;
            this.buttonPreDL.Text = "Download Only and Save As..";
            this.buttonPreDL.UseVisualStyleBackColor = true;
            this.buttonPreDL.Click += new System.EventHandler(this.buttonPreDL_Click);
            // 
            // richTextBox2
            // 
            this.richTextBox2.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.richTextBox2.Location = new System.Drawing.Point(8, 8);
            this.richTextBox2.Name = "richTextBox2";
            this.richTextBox2.ReadOnly = true;
            this.richTextBox2.Size = new System.Drawing.Size(608, 296);
            this.richTextBox2.TabIndex = 0;
            this.richTextBox2.Text = resources.GetString("richTextBox2.Text");
            this.richTextBox2.TextChanged += new System.EventHandler(this.richTextBox2_TextChanged);
            // 
            // tabPage2
            // 
            this.tabPage2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.tabPage2.Controls.Add(this.buttonWinlogPatch);
            this.tabPage2.Controls.Add(this.buttonWinlogDL);
            this.tabPage2.Controls.Add(this.richTextBox3);
            this.tabPage2.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tabPage2.Location = new System.Drawing.Point(4, 26);
            this.tabPage2.Name = "tabPage2";
            this.tabPage2.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage2.Size = new System.Drawing.Size(776, 314);
            this.tabPage2.TabIndex = 1;
            this.tabPage2.Text = "Winlogon Port";
            this.tabPage2.UseVisualStyleBackColor = true;
            // 
            // buttonWinlogPatch
            // 
            this.buttonWinlogPatch.Location = new System.Drawing.Point(624, 208);
            this.buttonWinlogPatch.Name = "buttonWinlogPatch";
            this.buttonWinlogPatch.Size = new System.Drawing.Size(136, 64);
            this.buttonWinlogPatch.TabIndex = 2;
            this.buttonWinlogPatch.Text = "Download and Patch Now..";
            this.buttonWinlogPatch.UseVisualStyleBackColor = true;
            this.buttonWinlogPatch.Click += new System.EventHandler(this.buttonWinlogPatch_Click);
            // 
            // buttonWinlogDL
            // 
            this.buttonWinlogDL.Location = new System.Drawing.Point(624, 104);
            this.buttonWinlogDL.Name = "buttonWinlogDL";
            this.buttonWinlogDL.Size = new System.Drawing.Size(136, 64);
            this.buttonWinlogDL.TabIndex = 1;
            this.buttonWinlogDL.Text = "Download Only and Save As..";
            this.buttonWinlogDL.UseVisualStyleBackColor = true;
            this.buttonWinlogDL.Click += new System.EventHandler(this.buttonWinlogDL_Click);
            // 
            // richTextBox3
            // 
            this.richTextBox3.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.richTextBox3.Location = new System.Drawing.Point(8, 8);
            this.richTextBox3.Name = "richTextBox3";
            this.richTextBox3.ReadOnly = true;
            this.richTextBox3.Size = new System.Drawing.Size(608, 296);
            this.richTextBox3.TabIndex = 0;
            this.richTextBox3.Text = resources.GetString("richTextBox3.Text");
            // 
            // tabPage3
            // 
            this.tabPage3.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.tabPage3.Controls.Add(this.button1);
            this.tabPage3.Controls.Add(this.buttonMissingDL);
            this.tabPage3.Controls.Add(this.richTextBox4);
            this.tabPage3.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tabPage3.Location = new System.Drawing.Point(4, 26);
            this.tabPage3.Name = "tabPage3";
            this.tabPage3.Size = new System.Drawing.Size(776, 314);
            this.tabPage3.TabIndex = 2;
            this.tabPage3.Text = "Missing x86";
            this.tabPage3.UseVisualStyleBackColor = true;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(624, 208);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(136, 63);
            this.button1.TabIndex = 2;
            this.button1.Text = "Download and Patch Now..";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // buttonMissingDL
            // 
            this.buttonMissingDL.Location = new System.Drawing.Point(624, 104);
            this.buttonMissingDL.Name = "buttonMissingDL";
            this.buttonMissingDL.Size = new System.Drawing.Size(139, 64);
            this.buttonMissingDL.TabIndex = 1;
            this.buttonMissingDL.Text = "Download Only and Save As..";
            this.buttonMissingDL.UseVisualStyleBackColor = true;
            this.buttonMissingDL.Click += new System.EventHandler(this.buttonMissingDL_Click);
            // 
            // richTextBox4
            // 
            this.richTextBox4.Location = new System.Drawing.Point(8, 8);
            this.richTextBox4.Name = "richTextBox4";
            this.richTextBox4.Size = new System.Drawing.Size(608, 296);
            this.richTextBox4.TabIndex = 0;
            this.richTextBox4.Text = resources.GetString("richTextBox4.Text");
            this.richTextBox4.TextChanged += new System.EventHandler(this.richTextBox4_TextChanged);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.tabControl1);
            this.Controls.Add(this.progressBar1);
            this.Controls.Add(this.label1);
            this.Font = new System.Drawing.Font("Segoe UI", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.Name = "Form1";
            this.Text = "Easy-Patcher ";
            this.tabControl1.ResumeLayout(false);
            this.tabPage4.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.tabPage2.ResumeLayout(false);
            this.tabPage3.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ProgressBar progressBar1;
        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tabPage4;
        private System.Windows.Forms.RichTextBox richTextBox1;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.TabPage tabPage2;
        private System.Windows.Forms.TabPage tabPage3;
        private System.Windows.Forms.Button buttonPrePatch;
        private System.Windows.Forms.Button buttonPreDL;
        private System.Windows.Forms.RichTextBox richTextBox2;
        private System.Windows.Forms.RichTextBox richTextBox3;
        private System.Windows.Forms.Button buttonWinlogPatch;
        private System.Windows.Forms.Button buttonWinlogDL;
        private System.Windows.Forms.RichTextBox richTextBox4;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button buttonMissingDL;
    }
}

