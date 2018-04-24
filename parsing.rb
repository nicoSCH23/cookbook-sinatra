
require "open-uri"
require "nokogiri"

class Scraping

  MARMITTON_BASE_URL = "http://www.marmiton.org/recettes/recherche.aspx?aqt="
  MARMITTON_BASE_URL_TWO = "http://www.marmiton.org"


  def search_recipes(search_item)
    file = open("#{MARMITTON_BASE_URL}#{search_item}").read
    doc = Nokogiri::HTML(file)
    cards = doc.search(".recipe-card").first(5)
    top_five = {}
    cards.each { |card| top_five[card.search("h4").map(&:text).join("")] = card.attribute('href').to_s }
    return top_five
  end

  def scrape_details(path)
    file = open("#{MARMITTON_BASE_URL_TWO}#{path}").read
    doc = Nokogiri::HTML(file)
    name = doc.search("h1").first.text
    difficulty = doc.search(".recipe-infos__level").first.text.strip
    prep_time = doc.search(".recipe-infos__total-time__value").text
    paragraphs = doc.search(".recipe-preparation__list__item")
    description = paragraphs.map(&:text).join("\n").gsub("\t","#")
    return {name: name, description: description, prep_time: prep_time, difficulty: difficulty}
  end
end
