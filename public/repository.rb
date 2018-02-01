require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file)  # csv_file is a String (file path)
    @csv_file = csv_file

    @recipes = []  # IMPORTANT: Array of `Recipe` instances.

    load_csv if File.exist?(@csv_file)
  end

  def all
    return @recipes
  end

  def find(index)
    return @recipes[index]
  end

  def add_recipe(recipe)  # recipe is a `Recipe` instance.
    @recipes << recipe
    write_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    write_csv
  end

  def save
    write_csv
  end

  private

  def load_csv
    csv_options = { col_sep: ";", force_quotes: true }
    CSV.foreach(@csv_file, csv_options) do |row|
      name = row[0]
      description = row[1]
      cooking_time = row[3]
      recipe = Recipe.new(name, description, cooking_time)
      if row[2] == "true"
        recipe.mark_as_tested
      end

      @recipes << recipe
    end
  end

  def write_csv
    csv_options = { col_sep: ";", force_quotes: true }
    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      @recipes.each do |recipe|
        # recipe is a `Recipe` instance
        csv << [recipe.name, recipe.description, recipe.tested?, recipe.cooking_time]
      end
    end
  end
end
