using System;
using System.IO;
using System.Xml;
using System.Xml.Linq;

namespace program
{
    class Program
    {
        static void Main(string[] args)
        {
            var person = new Person();

            using (StreamReader reader = new StreamReader("../../Person.txt"))
            {
                person.Name = reader.ReadLine();
                person.Address = reader.ReadLine();
                person.Phone = reader.ReadLine();
            }

            var personElement = new XElement("person",
                new XElement("name"),
                new XElement("address"),
                new XElement("phone"));

            personElement.Save("person.xml");
            Console.WriteLine("The file is save.");
            personElement.Save("person.xml");
        }
    }
}
