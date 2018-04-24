require_relative 'recipe'
require_relative 'cookbook'
require_relative 'view'
require_relative 'parsing'
require "pry-byebug"


class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
    @scrap = Scraping.new
  end

  def list
    recipes = @cookbook.all
    @view.display_recipes(recipes)
  end

  def display_recipe
    list
    recipes = @cookbook.all
    index = @view.select_recipe #return index
    puts @view.display_description(recipes[index])
  end


  def create
    attributes = @view.ask_for_inputs
    recipe = Recipe.new(attributes)
    @cookbook.add_recipe(recipe)
  end

  def mark_as_done
    list
    index = @view.ask_for_done_index
    recipe = @cookbook.mark_as_done(index)
    list
  end

  def destroy
    list
    id = @view.ask_for_id_to_destroy
    @cookbook.remove_recipe(id)
  end

  def select_import_recipe
    ingredient = @view.ask_for_ingredient
    top_five_hash = @scrap.search_recipes(ingredient)
    @view.display_imported_recipes(top_five_hash.keys)
    title = top_five_hash.keys[@view.ask_for_index]
    attributes = @scrap.scrape_details(top_five_hash[title])
    recipe = Recipe.new(attributes)
    @cookbook.add_recipe(recipe)
  end
end

