class CreatePokemon < ActiveRecord::Migration

    def change

        create_table :pokemons do |t|
            t.string :name 
            t.string :poke_type
            

        end

    end

end