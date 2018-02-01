require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"

require_relative "public/recipe"
require_relative "public/letscookfrench"
require_relative "public/repository"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file_path = "public/recipes.csv"
repository = Cookbook.new(csv_file_path)


get '/' do
  @recipes = repository.all
  erb :index
end

post '/' do
  new_recipe = Recipe.new(params[:name], params[:description], params[:cooking_time])
  repository.add_recipe(new_recipe)
  @recipes = repository.all
  erb :index
end

get '/delete/' do
  recipe_index = params[:id].to_i
  repository.remove_recipe(recipe_index)
  @recipes = repository.all
  erb :index
  redirect to '/'
end
