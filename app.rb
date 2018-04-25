require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'recipe'
require_relative 'cookbook'
require_relative 'parsing'
require_relative 'top'
require_relative 'top_repo'


configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

post '/recipes' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  recipe = Recipe.new({name: params[:name],description: params[:description], prep_time: "#{params[:prep_time]} min", difficulty: params[:difficulty]})
  cookbook.add_recipe(recipe)
  redirect to '/'
end

get '/search' do
  erb :search
end

post '/scrap' do
  ingredient = params[:ingredient]
  scrap = Scraping.new
  top_five_hash = scrap.search_recipes(ingredient)
  top_repo = TopRepo.new(File.join(__dir__, 'tops.csv'))
  top_five_hash.each do |top|
    attributes = scrap.scrape_details(top[1])
    t = Top.new({path: top[1], name: attributes[:name], description: attributes[:description], prep_time: attributes[:prep_time], difficulty: attributes[:difficulty], picture_path: attributes[:picture_path]})
    top_repo.add_top(t)
  end
  # erb :top_results, :locals => {:top_five_hash => top_five_hash }
  redirect to '/select'
end

get '/select' do
  top_repo = TopRepo.new(File.join(__dir__, 'tops.csv'))
  @top_five = top_repo.top_five
  erb :top_results
end


get '/what/recettes/:path' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  scrap = Scraping.new
  path = "/recettes/#{params[:path]}"
  attributes = scrap.scrape_details(path)
  recipe = Recipe.new(attributes)
  cookbook.add_recipe(recipe)
  redirect to '/'
end

get '/recipes/:index' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  cookbook.remove_recipe(params[:index].to_i)
  redirect to '/'
end
