using System;
using System.Xml;

namespace program
{
    class Program
    {
        static void Main(string[] args)
        {
            var document = new XmlDocument();
            document.Load("../../catalog.xml");
            var element = document.DocumentElement;

            DeleteAlbum(element, 20.0);
            document.Save("../../newCatalog.xml");
            Console.WriteLine("New catalog are create and save.");

        }

        private static void DeleteAlbum(XmlElement element, double maxPrice)
        {
            foreach (XmlElement album in element.ChildNodes)
            {
                var xmlPrice = album["price"].InnerText;
                var price = double.Parse(xmlPrice);

                if (price > maxPrice)
                {
                    element.RemoveChild(album);
                }
            }
        }
    }
}
