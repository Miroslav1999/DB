using System;
using System.Xml;

namespace program
{
    public class Program
    {
        static void Main()
        {
            XmlDocument document = new XmlDocument();
            document.Load("../../catalog.xml");
            var query = "/catalog/album[year>1996]/name";

            var albumsName = document.SelectNodes(query);

            foreach (XmlNode name in albumsName)
            {
                Console.WriteLine(name.InnerText);
            }
        }
    }
}
