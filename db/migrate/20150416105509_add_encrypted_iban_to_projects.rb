class AddEncryptedIbanToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :encrypted_iban, :string
  end
end
