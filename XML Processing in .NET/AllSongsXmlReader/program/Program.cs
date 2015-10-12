using System;
using System.Xml;

namespace program
{
    class Program
    {
        static void Main(string[] args)
        {
            using (XmlReader reader = new XmlTextReader("../../catalog.xml"))
            {
                while (reader.Read())
                {
                    if (reader.Name == "title")
                    {
                        Console.WriteLine(reader.ReadElementString());
                    }
                }
            }
        }
    }
}
