using System;
using System.IO;
using System.Xml.Linq;

namespace program
{
    class Program
    {
        

        static void Main(string[] args)
        {
            var desktopPath = Traverse(Environment.GetFolderPath(Environment.SpecialFolder.Desktop));
            desktopPath.Save("../../dir.xml");
            Console.WriteLine("The document is saved");
        }

        static XElement Traverse(string dir)
        {
            var element = new XElement("dir", new XAttribute("path", dir));

            foreach (var directory in Directory.GetDirectories(dir))
            {
                element.Add(Traverse(directory));
            }

            foreach (var file in Directory.GetDirectories(dir))
            {
                element.Add(new XElement("file",
                    new XAttribute("name", Path.GetFileNameWithoutExtension(file)),
                    new XAttribute("extension", Path.GetExtension(file))));
            }

            return element;
        }
    }
}
