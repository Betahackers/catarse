class AddCountryString < ActiveRecord::Migration
  def change
    add_column :users, :country, :string
    add_column :contributions, :country, :string    
  end
end
