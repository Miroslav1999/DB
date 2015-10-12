using System;
using System.Xml.Xsl;

namespace program
{
    class Program
    {
        static void Main(string[] args)
        {
            XslCompiledTransform transform = new XslCompiledTransform();
            transform.Load("../../style.xslt");
            transform.Transform("../../catalog.xml", "../../catalog.html");
            Console.WriteLine("The file is saved");
        }
    }
}
