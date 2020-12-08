class AddUserIdToPokemons < ActiveRecord::Migration
    def change
      add_reference :pokemons, :user, foreign_key: true
    end
  end