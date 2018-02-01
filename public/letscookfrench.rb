require 'nokogiri'
require 'open-uri'
require_relative "recipe"

class Letscookfrench
  def search(ingredient)
    results = [] # Array of Recipe instances

    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?s=#{ingredient}&type=all"
    html = Nokogiri::HTML(open(url))

    html.search('.recette_classique').each do |node|
      name = node.search('.m_titre_resultat').text.strip
      description = node.search('.m_texte_resultat').text.strip
      cooking_time = node.search('.m_prep_time').first.parent.text.strip

      recipe = Recipe.new(name, description)
      recipe.cooking_time = cooking_time
      results << recipe
    end

    return results
  end
end
