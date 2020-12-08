class PokemonsController < ApplicationController

  # GET: /pokemons
  get "/pokemons" do
    @pokemons = Pokemon.all
    
    erb :"/pokemons/index.html"
  end

  # GET: /pokemons/new
  get "/pokemons/new" do
    redirect_if_not_logged_in
    erb :"/pokemons/new.html"
  end

  # POST: /pokemons
  post "/pokemons" do
    
    redirect_if_not_logged_in
    pokemon = Pokemon.create(params[:pokemon])
    redirect to "/pokemons/#{pokemon.id}"
  end

  # GET: /pokemons/5
  get "/pokemons/:id" do
    
    if @pokemon = Pokemon.find_by_id(params[:id])
    erb :"/pokemons/show.html"
    else
      redirect to "/pokemons"
    end
  end

  # GET: /pokemons/5/edit
  get "/pokemons/:id/edit" do
    #compare pokemons user to the current user
    redirect_if_not_logged_in
    @pokemon = Pokemon.find_by_id(params[:id])
    
    if @pokemon.user == current_user
      erb :"/pokemons/edit.html"
    else
      sry_not_your_pokemon
      redirect to "/pokemons/#{@pokemon.id}"
    end
    #erb :"/pokemons/edit.html"
  end

  # PATCH: /pokemons/5
  patch "/pokemons/:id" do
    redirect_if_not_logged_in
    pokemon = Pokemon.find_by_id(params[:id])
    if pokemon.user == current_user 
      pokemon.update(params[:pokemon])
      redirect to "/pokemons/#{pokemon.id}"
    else
      sry_not_your_pokemon
    end
    
      

  end

  # DELETE: /pokemons/5/delete
  delete "/pokemons/:id" do
    pokemon = Pokemon.find_by_id(params[:id])
    if pokemon.user == current_user
      pokemon.destroy
      redirect to "/pokemons"
    else
      sry_not_your_pokemon
      redirect to "/pokemons/#{pokemon.id}"

    end
  end

    get "/users/:id/pokemons" do 
    redirect_if_not_logged_in
    user = User.find_by_id(params[:id])
  
    @poke_all = user.pokemons
      erb :"/pokemons/user_all"
  end


end
