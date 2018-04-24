class View
  def display_recipes(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1} #{recipe.done ? "[X]" : "[ ]"} - #{recipe.name} - (#{recipe.prep_time}) * #{recipe.difficulty}"
    end
  end

  def display_description(recipe)
    "\t\*#{recipe.name}* \n\n #{recipe.description}"
  end

  def select_recipe
    puts "Which recipe do you need? (index)"
    index = gets.chomp.to_i
    return index - 1
  end

  def display_imported_recipes(titles_array)
    titles_array.each_with_index do |title, index|
      puts "#{index + 1} - #{title}"
    end
  end

  def ask_for_done_index
    puts "Which recipe did you do? (enter index)"
    index = gets.chomp.to_i
    return index - 1
  end

  def ask_for_index
    puts "Which recipe would you like to import? (enter index)"
    index = gets.chomp.to_i
    return index - 1
  end

  def ask_for_inputs
    attributes = {}
    puts "What's the recipe name?"
    print "> "
    attributes[:name] = gets.chomp
    puts "Please describe your recipe"
    print "> "
    attributes[:description] = gets.chomp
    puts "What's the preparation time in min?"
    print "> "
    attributes[:prep_time] = "#{gets.chomp.to_i} min"
    puts "What's the difficulty?"
    print "> "
    attributes[:difficulty] = "#{gets.chomp}"
    return attributes
  end

  def ask_for_ingredient
    puts "What ingredient would you like a recipe for?"
    ingredient = gets.chomp
    return ingredient
  end

  def ask_for_id_to_destroy
    puts "What's the recipe index you want to remove?"
    index = gets.chomp.to_i
    return index - 1
  end

  # def ask_for_id_to_create
  #   puts "What's the recipe index you want to remove?"
  #   index = gets.chomp.to_i
  #   return index - 1
  # end
end
