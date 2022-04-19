require "open-uri"
require "nokogiri"

def fetch_movie_urls
  # goes to imdb top and fetch top 5 movies url
  url = "https://www.imdb.com/chart/top"
  html_file = URI.open(url).read
  html_doc = Nokogiri::HTML(html_file)
  movies = []
  html_doc.search(".titleColumn").first(5).each do |title|
    movies << "https://www.imdb.com#{title.search("a").attribute("href").value}"
  end
  movies
end

def scrape_movie(url)
  html_file = URI.open(url).read
  html_doc = Nokogiri::HTML(html_file)
  title = html_doc.search('h1').text.strip
  year = html_doc.search('.sc-8c396aa2-2').text.strip[0..3]
  storyline = html_doc.search('.sc-16ede01-0').text.strip
  director = html_doc.search(".ipc-metadata-list__item:contains('Director') a").first.text.strip
  cast = []
  html_doc.search(".ipc-metadata-list__item:contains('Stars') a.ipc-metadata-list-item__list-content-item").each do |element|
    cast << element.text
  end
  {
    cast: cast.uniq,
    director: director,
    storyline: storyline,
    title: title,
    year: year.to_i
  }
end

#{
#   cast: [ "Christian Bale", "Heath Ledger", "Aaron Eckhart" ],
#   director: "Christopher Nolan",
#   storyline: "When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham. The Dark Knight must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
#   title: "The Dark Knight",
#   year: 2008
# }
