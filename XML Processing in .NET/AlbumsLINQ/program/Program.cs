using System;
using System.Linq;
using System.Xml.Linq;

namespace program
{
    class Program
    {
        static void Main(string[] args)
        {
            var document = XDocument.Load("../../catalog.xml");

            var albumsName = from album in document.Descendants("album")
                             where int.Parse(album.Element("year").Value) > 1996
                             select album.Element("name").Value;

            Console.WriteLine(string.Join(Environment.NewLine, albumsName));
        }
    }
}
