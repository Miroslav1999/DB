using System;
using System.Collections.Generic;
using System.Xml;

namespace program
{
    class Program
    {
        static void Main(string[] args)
        {
            var doc = new XmlDocument();
            doc.Load("../../catalogue.xml");
            var element = doc.DocumentElement;

            foreach (var pair in UniqueArtist(element))
            {
                Console.WriteLine("{0} with {1} albums", pair.Key, pair.Value);
            }
        }

        private static Dictionary<string, int> UniqueArtist(XmlElement element)
        {
            var artistWithAlbum = new Dictionary<string, int>();
            var artists = element.GetElementsByTagName("artist");

            foreach (XmlElement artist in artists)
            {
                var artistName = artist.InnerText;

                if (artistWithAlbum.ContainsKey(artistName))
                {
                    artistWithAlbum[artistName] += 1;
                }
                else
                {
                    artistWithAlbum.Add(artistName, 1);
                }
            }

            return artistWithAlbum;
        }
    }
}
