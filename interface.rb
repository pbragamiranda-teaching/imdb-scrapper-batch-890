require "yaml"
require_relative "scraper"

puts "Fetching URLs"
urls = fetch_movie_urls

movies = []

urls.each do |url|
  puts "Scraping #{url}"
  movies << scrape_movie(url)
end

puts "Writing movies.yml"
File.open("movies.yml", "w") do |f|
  f.write(movies.to_yaml)
end

puts "Done."
