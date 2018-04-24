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
        csv.puts([recipe.name, recipe.description, recipe.prep_time, recipe.done, recipe.difficulty, recipe.picture_path])
      end
    end
  end
  def save_to_csv
    CSV.open(@csv_file, 'w', write_headers: true, headers: ["name", "description", "done", "difficulty", "prep_time", "picture_path"]) do |csv|
      @recipes.each do |recipe|
        csv.puts([recipe.name, recipe.description, recipe.done, recipe.difficulty, recipe.prep_time, recipe.picture_path])
      end
    end
  end


  def load_csv
    return unless File.exist?(@csv_file)

    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:name] = row[:name]
      row[:description] = row[:description]
      row[:done] = row[:done]
      row[:difficulty] = row[:difficulty]
      row[:prep_time] = row[:prep_time]
      row[:picture_path] = row[:picture_path]
      @recipes << Recipe.new(row)
    end
  end
end
