using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Xml;

namespace Processing_JSON_in.NET
{
    public class Solution
    {
        public IEnumerable<Video> GetVideos(JObject json)
        {
            var videos = json["feed"]["entry"].Select(entry => JsonConvert.DeserializeObject<Video>(entry.ToString()));
            return videos;
        }         

        public void DownloadRss(string url, string fileName)
        {
            var webClient = new WebClient();
            webClient.DownloadFile(url, fileName);
        }

        public XmlDocument GetXml(string path)
        {
            XmlDocument document = new XmlDocument();
            document.Load(path);

            return document;
        }

        public void SaveHTML(string html, string htmlName)
        {
            using (StreamWriter writer = new StreamWriter("../../" + htmlName, true, Encoding.UTF8))
            {
                writer.Write(html);
            }

            var currentDirectory = Directory.GetCurrentDirectory();
            var htmlDirectory = currentDirectory.Substring(0, currentDirectory.IndexOf("bin\\Debug")) + htmlName;
        }

        public void PrintTitles(IEnumerable<JToken> titles)
        {
            Console.WriteLine(string.Join(Environment.NewLine, titles));
        }

        public JObject GetObject(XmlDocument xmlDocument)
        {
            string json = JsonConvert.SerializeXmlNode(xmlDocument);
            var obj = JObject.Parse(json);

            return obj;
        }

        public IEnumerable<JToken> GetVideosTitles(JObject obj)
        {
            return obj["feed"]["entry"].Select(entry => entry["entry"]);
        }

        public string GetHtmlString(IEnumerable<Video> videos)
        {
            StringBuilder htmlString = new StringBuilder();

            htmlString.Append("<!DOCTYPE html><html><body>");

            foreach (var video in videos)
            {
                htmlString.AppendFormat("<div style=\"float:left; width: 500px; height: 400px; " + 
                    "background-color: #8EFFFF; border-radius: 5px\">"
                    + "<iframe width:\"500\" height=\"400\" " + "src=\"http://www.youtube.com/embed/{1}?autoplay=0\" " + "frameborder=\"0\" allowfullscreen></iframe>" +
                    "<h2>{2}</h2><a href=\"{0}\">YouTube</a></div>", video.Link.Href, video.VideoID, video.Title);
            }

            htmlString.Append("</body></html>");
            return htmlString.ToString();
        }
    }
}
