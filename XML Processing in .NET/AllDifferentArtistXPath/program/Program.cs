using System;
using System.Collections.Generic;
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

            foreach (var pair in UniqueArtist(element))
            {
                Console.WriteLine("{0} with {1} album.", pair.Key, pair.Value);
            }
        }

        private static Dictionary<string, int> UniqueArtist(XmlElement element)
        {
            var artistWithAlbums = new Dictionary<string, int>();
            var artists = element.SelectNodes("/catalog/album/artist");

            foreach (XmlNode artist in artists)
            {
                var artistName = artist.InnerText;

                if (artistWithAlbums.ContainsKey(artistName))
                {
                    artistWithAlbums[artistName] += 1;
                }
                else
                {
                    artistWithAlbums.Add(artistName, 1);
                }
            }

            return artistWithAlbums;
        }
    }
}
