using System;
using System.Xml;
using System.Xml.Linq;
using System.Linq;
using System.Collections.Generic;

namespace program
{
    class Program
    {
        static void Main(string[] args)
        {
            var document = XDocument.Load("../../catalog.xml");
            var albums = document.Element("catalog").Element("album");

            var titles = from title in albums.Descendants("title") select title.Value;

            foreach (var title in titles)
            {
                Console.WriteLine(title);
            }
        }
    }
}
