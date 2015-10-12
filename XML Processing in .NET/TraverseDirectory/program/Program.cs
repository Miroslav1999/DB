using System;
using System.Text;
using System.Xml;
using System.IO;

namespace program
{
    class Program
    {
        static void Main(string[] args)
        {
            using (XmlTextWriter writer = new XmlTextWriter("../../dir.xml", Encoding.UTF8))
            {
                writer.Formatting = Formatting.Indented;
                writer.IndentChar = ' ';
                writer.Indentation = 3;

                string filePath = Environment.GetFolderPath(Environment.SpecialFolder.Desktop);

                writer.WriteStartDocument();
                writer.WriteStartElement("Desktop");
                Traverse(filePath, writer);
                writer.WriteEndDocument();
            }

            Console.WriteLine("The new document is saved");
        }

        static void Traverse(string dir, XmlTextWriter writer)
        {
            foreach (var directory in Directory.GetDirectories(dir))
            {
                writer.WriteStartElement("dir");
                writer.WriteAttributeString("path", directory);
                Traverse(dir, writer);
                writer.WriteEndDocument();
            }

            foreach (var file in Directory.GetDirectories(dir))
            {
                writer.WriteStartElement("file");
                writer.WriteAttributeString("name", Path.GetFileNameWithoutExtension(file));
                writer.WriteAttributeString("extension", Path.GetExtension(file));
                writer.WriteEndDocument();

            }
        }
    }
}
