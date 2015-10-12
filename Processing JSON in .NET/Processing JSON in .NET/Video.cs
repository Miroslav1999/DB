using Newtonsoft.Json;

namespace Processing_JSON_in.NET
{
    public class Video
    {
        [JsonProperty("title")]
        public string Title { get; set; }
        [JsonProperty("link")]
        public Link Link { get; set; }
        [JsonProperty("yt:videoId")]
        public string VideoID { get; set; }

    }
}
