class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #ROOT PAGE
  # code actions here!
  get '/' do
  end

  #INDEX PAGE
  #shows all recipes
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  #CREATE
  #new page with form to create new recipe
  get '/recipes/new' do
    erb :new
  end

  #READ
  #find each recipe by id && renders it in the show page
  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  #CREATE
  #creates a new recipe and posts it to its own page
  post '/recipes' do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time]) 
    redirect to "/recipes/#{@recipe.id}"
  end 

  #UPDATE
  #load an edit page
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  #UPDATE
  #edit a recipe page
  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  #DELETE
  #remember to add delete form to show.erb
  delete '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect "/recipes"
  end

end
