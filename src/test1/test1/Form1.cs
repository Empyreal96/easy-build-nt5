using System;
using System.ComponentModel;
using System.Windows.Forms;
using System.Net;
using System.Diagnostics;

namespace test1
{
    // public sealed class SaveFileDialog : FileDialog;
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label1_Click_1(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void richTextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void buttonPrePatch_Click(object sender, EventArgs e)
        {
            //
            //This section downloads the latest prepatch zip using the WebClient feature to Download
            //
            
            // 
            {
                //This section downloads the latest prepatch zip using the WebClient feature to Download
                System.Net.ServicePointManager.SecurityProtocol = (SecurityProtocolType)(0xc0 | 0x300 | 0xc00);
                WebClient client = new WebClient();
                client.DownloadProgressChanged += new DownloadProgressChangedEventHandler(client_DownloadProgressChanged);
                client.DownloadFileCompleted += new AsyncCompletedEventHandler(client_DownloadFileCompleted1);

                // Starts the download
                client.DownloadFileAsync(new Uri("https://www.dropbox.com/s/jlg9afgdcier3z2/PATCHER_FILE_1.patch?dl=1"), "win2k3_prepatched_v10.zip");
                
                    

                
               buttonPrePatch.Text = "Download In Progress";
             buttonPrePatch.Enabled = false;
            }
        }

        private static void client_DownloadFileCompleted1(object sender, AsyncCompletedEventArgs e)
        {
            MessageBox.Show("Download Completed, Patching Now.");
            Process process = new Process();
            process.StartInfo.FileName = @"PatchSource.cmd";
            process.StartInfo.WindowStyle = ProcessWindowStyle.Normal;
            process.Start();
            process.WaitForExit();


        }

        private void buttonPreDL_Click(object sender, EventArgs e)
        {
            // Configure save file dialog box
            SaveFileDialog savepre = new SaveFileDialog();
            savepre.InitialDirectory = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
            savepre.FileName = "win2003_prepatched_v10.zip"; // Default file name
            savepre.DefaultExt = ".zip"; // Default file extension
            savepre.Filter = "Archive (.zip)|*.zip"; // Filter files by extension

            // Process save file dialog box results
            if (savepre.ShowDialog() != DialogResult.Cancel)
            // 
            {
                //This section downloads the latest prepatch zip using the WebClient feature to Download
                System.Net.ServicePointManager.SecurityProtocol = (SecurityProtocolType)(0xc0 | 0x300 | 0xc00);
                WebClient client = new WebClient();
                client.DownloadProgressChanged += new DownloadProgressChangedEventHandler(client_DownloadProgressChanged);
                client.DownloadFileCompleted += new AsyncCompletedEventHandler(client_DownloadFileCompleted);

                // Starts the download
                client.DownloadFileAsync(new Uri("https://www.dropbox.com/s/jlg9afgdcier3z2/PATCHER_FILE_1.patch?dl=1"), savepre.FileName);
                // Save document

                string filename = savepre.FileName;
                buttonPreDL.Text = "Download In Progress";
                buttonPreDL.Enabled = false;
            }

        }

        private void progressBar1_Click(object sender, EventArgs e)
        { }
        void client_DownloadProgressChanged(object sender, DownloadProgressChangedEventArgs e)
        {
            double bytesIn = double.Parse(e.BytesReceived.ToString());
            double totalBytes = double.Parse(e.TotalBytesToReceive.ToString());
            double percentage = bytesIn / totalBytes * 100;

            progressBar1.Value = int.Parse(Math.Truncate(percentage).ToString());

        }
        void client_DownloadFileCompleted(object sender, AsyncCompletedEventArgs e)
        {
            MessageBox.Show("Download Completed");
            buttonPreDL.Text = "Download Only and Save As..";
            buttonPreDL.Enabled = true;
        }

        private void buttonWinlogDL_Click(object sender, EventArgs e)
        {
            SaveFileDialog savewlog = new SaveFileDialog();
            savewlog.InitialDirectory = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
            savewlog.FileName = "Winlogon200X_v3b.zip";
            savewlog.DefaultExt = ".zip"; 
            savewlog.Filter = "Archive (.zip)|*.zip"; 
            if (savewlog.ShowDialog() != DialogResult.Cancel) 
            {
                System.Net.ServicePointManager.SecurityProtocol = (SecurityProtocolType)(0xc0 | 0x300 | 0xc00);
                WebClient client = new WebClient();
                client.DownloadProgressChanged += new DownloadProgressChangedEventHandler(client_DownloadProgressChanged);
                client.DownloadFileCompleted += new AsyncCompletedEventHandler(client_DownloadFileCompleted);

                client.DownloadFileAsync(new Uri("https://www.dropbox.com/s/2tp1p2uvt6a258z/PATCHER_FILE_3.patch?dl=1"), savewlog.FileName);

                string filename = savewlog.FileName;
                buttonWinlogDL.Text = "Download In Progress";
                buttonWinlogDL.Enabled = false;
            }
        }

        private void richTextBox4_TextChanged(object sender, EventArgs e)
        {

        }

        private void buttonMissingDL_Click(object sender, EventArgs e)
        {
            SaveFileDialog savemiss = new SaveFileDialog();
            savemiss.InitialDirectory = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
            savemiss.FileName = "win2003_x86-missing-binaries_v2"; 
            savemiss.DefaultExt = ".7z";
            savemiss.Filter = "7z Archive (.7z)|*.7z"; 


            if (savemiss.ShowDialog() != DialogResult.Cancel)
            {

                System.Net.ServicePointManager.SecurityProtocol = (SecurityProtocolType)(0xc0 | 0x300 | 0xc00);
                WebClient client = new WebClient();
                client.DownloadProgressChanged += new DownloadProgressChangedEventHandler(client_DownloadProgressChanged);
                client.DownloadFileCompleted += new AsyncCompletedEventHandler(client_DownloadFileCompleted);

                client.DownloadFileAsync(new Uri("https://www.dropbox.com/s/syctbnu0n5u2amx/PATCHER_FILE_2.patch?dl=1"), savemiss.FileName);

                string filename = savemiss.FileName;
                buttonWinlogDL.Text = "Download In Progress";
                buttonWinlogDL.Enabled = false;
            }
        }

        private void buttonWinlogPatch_Click(object sender, EventArgs e)
        {

            {
                //This section downloads the latest prepatch zip using the WebClient feature to Download
                System.Net.ServicePointManager.SecurityProtocol = (SecurityProtocolType)(0xc0 | 0x300 | 0xc00);
                WebClient client = new WebClient();
                client.DownloadProgressChanged += new DownloadProgressChangedEventHandler(client_DownloadProgressChanged);
                client.DownloadFileCompleted += new AsyncCompletedEventHandler(client_DownloadFileCompleted2);

                // Starts the download
                client.DownloadFileAsync(new Uri("https://www.dropbox.com/s/2tp1p2uvt6a258z/PATCHER_FILE_3.patch?dl=1"), "Winlogon200X_v3b.zip");




                buttonWinlogPatch.Text = "Download In Progress";
                buttonWinlogPatch.Enabled = false;
            }
        }

        private static void client_DownloadFileCompleted2(object sender, AsyncCompletedEventArgs e)
        {
            MessageBox.Show("Download Completed, Patching Now.");
            Process process = new Process();
            process.StartInfo.FileName = @"WinlogonSource.cmd";
            process.StartInfo.WindowStyle = ProcessWindowStyle.Normal;
            process.Start();
            process.WaitForExit();


        }

        private void button1_Click(object sender, EventArgs e)
        {
            { 
            //This section downloads the latest prepatch zip using the WebClient feature to Download
            System.Net.ServicePointManager.SecurityProtocol = (SecurityProtocolType)(0xc0 | 0x300 | 0xc00);
            WebClient client = new WebClient();
            client.DownloadProgressChanged += new DownloadProgressChangedEventHandler(client_DownloadProgressChanged);
            client.DownloadFileCompleted += new AsyncCompletedEventHandler(client_DownloadFileCompleted3);

            // Starts the download
            client.DownloadFileAsync(new Uri("https://www.dropbox.com/s/syctbnu0n5u2amx/PATCHER_FILE_2.patch?dl=1"), "win2003_x86-missing-binaries_v2.7z");




            buttonPrePatch.Text = "Download In Progress";
            buttonPrePatch.Enabled = false;
        }
    }

    private static void client_DownloadFileCompleted3(object sender, AsyncCompletedEventArgs e)
    {
        MessageBox.Show("Download Completed, Patching Now.");
        Process process = new Process();
        process.StartInfo.FileName = @"MissingFiles.cmd";
        process.StartInfo.WindowStyle = ProcessWindowStyle.Normal;
        process.Start();
        process.WaitForExit();


    }

        private void richTextBox2_TextChanged(object sender, EventArgs e)
        {

        }
    }
    }
    



