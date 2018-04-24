require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'recipe'
require_relative 'cookbook'
require_relative 'parsing'

csv_file = File.join(__dir__, 'recipes.csv')
scrap = Scraping.new

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  cookbook = Cookbook.new(csv_file)
  @recipes = cookbook.all
  erb :index
end

get '/team/:username' do
  puts params[:username]
  "The username is #{params[:username]}"
end

