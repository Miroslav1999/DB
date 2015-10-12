using Newtonsoft.Json;

namespace Processing_JSON_in.NET
{
    public class Link
    {
        [JsonProperty(@"rel")]
        public string Rel { get; set; }

        [JsonProperty(@"href")]
        public string Href { get; set; }
    }
}
