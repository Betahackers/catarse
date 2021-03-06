class AddNameCaToCategories < ActiveRecord::Migration
  def up
    add_column :categories, :name_ca, :string
    Category.all.each do |c|
      c.update_attribute(:name_ca, c.name_en)
    end
  end
  def down
    remove_column :categories, :name_ca, :string
  end
end
