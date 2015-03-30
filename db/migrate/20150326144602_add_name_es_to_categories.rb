class AddNameEsToCategories < ActiveRecord::Migration
  def up
    add_column :categories, :name_es, :string
    Category.all.each do |c|
      c.update_attribute(:name_es, c.name_en)
    end
  end
  def down
    remove_column :categories, :name_es, :string
  end
end
