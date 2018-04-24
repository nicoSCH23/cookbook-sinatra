require 'csv'
require_relative 'recipe'

class Cookbook # Repository, Fake Database
  def initialize(csv_file)
    @recipes = []
    @csv_file = csv_file
    load_csv
  end

  def all
    @recipes
  end

  def mark_as_done(index)
    @recipes[index].mark_as_done!
    save_to_csv
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_to_csv
  end

  def remove_recipe(recipe_id)
    @recipes.delete_at(recipe_id)
    save_to_csv
  end

  private

  def save_to_csv
    CSV.open(@csv_file, 'w') do |csv|
      @recipes.each do |recipe|
        csv.puts([recipe.name, recipe.description, recipe.prep_time, recipe.done, recipe.difficulty])
      end
    end
  end

  def load_csv
    return unless File.exist?(@csv_file)

    CSV.foreach(@csv_file) do |row|
      attributes = {
        name: row[0],
        description: row[1],
        prep_time: row[2],
        done: row[3],
        difficulty: row[4]
      }
      @recipes << Recipe.new(attributes)
    end
  end
end
