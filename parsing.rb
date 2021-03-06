
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
    picture_path = doc.css("#af-diapo-desktop-0_img").map{ |i| i['src'] }.uniq.join('')
    return {name: name, description: description, prep_time: prep_time, difficulty: difficulty, picture_path: picture_path}
  end
end

 # img_urls = doc.css('.gallery img').map{ |i| i['src'] } #search through the CSS in the doc object for img tags with a class of Gallery and grab the element in its SRC tag
 # img_captions = doc.css('.gallery .image_alt').map{ |alt| alt } #grab the ALT element content from the CSS that contains gallery and image alt classes

 # #Prints out unique image urls
 # puts img_urls.uniq

