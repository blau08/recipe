require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

ENV['RACK_ENV'] = 'test'
get('/') do

  erb(:index)
end

get('/recipes') do
  @recipes = Recipe.all()
  erb(:recipes)
end

post('/recipes') do
  recipe = Recipe.new({:name => params.fetch('name')})
  recipe.save
  @recipes = Recipe.all()
  erb(:recipes)
end

get('/recipes/:id') do
  recipe_id = params.fetch('id').to_i()
  @recipe = Recipe.find(recipe_id)
  erb(:recipe)
end

post('/recipes/:id') do

  recipe_id = params.fetch('id').to_i()
  @recipe = Recipe.find(recipe_id)
  @recipe.ingredients.create({:name => params.fetch('ingredients')})
  @recipe.update({:instructions => params.fetch('instruction')})
  erb(:recipe)
end

# patch('/recipes/:id') do
#   ingredients = params.fetch('ingredients')
#   recipe_id = params.fetch('id').to_i()
#   @recipe = Recipe.find(recipe_id)
#   erb(:recipe)
# end
