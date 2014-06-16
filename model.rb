require 'JSON'
require 'open-uri'
require 'sanitize'

class Topic
  attr_accessor :topic, :summary
  def initialize(topic)
    @topic = topic
    @summary = nil
  end

  def get_summary
    wiki_entry = json_creater
    json_sanitizer(wiki_entry)
  end

  def json_creater
    @topic.gsub!(" ", "%20")
    wiki_entry = JSON.parse(URI.parse("http://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exlimit=1&exintro=&exsectionformat=plain&titles=#{topic}").read)
  end

  def json_sanitizer (wiki_entry)
    @summary = Sanitize.clean(wiki_entry["query"]["pages"][wiki_entry["query"]["pages"].keys[0]]["extract"])
  end
end
