using System;
using System.Net;
using System.Text;

namespace Processing_JSON_in.NET
{
    class Program
    {
        private const string RssLink = " https://www.youtube.com/feeds/videos.xml?channel_id=UCLC-vbm7OWvpbqzXaoAMGGw";
        private const string xmlPath = "videos.xml";
        private const string htmlName = "index.html";
        static void Main()
        {
            Console.OutputEncoding = Encoding.UTF8;

            var solution = new Solution();

            solution.DownloadRss(RssLink, xmlPath);
            var xmlDocument = solution.GetXml(xmlPath);
            var jsonObject = solution.GetObject(xmlDocument);
            var titles = solution.GetVideosTitles(jsonObject);
            solution.PrintTitles(titles);

            var videos = solution.GetVideos(jsonObject);
            var html = solution.GetHtmlString(videos);
            solution.SaveHTML(html, htmlName);
        }
    }
}
