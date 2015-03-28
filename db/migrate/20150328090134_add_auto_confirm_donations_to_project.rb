class AddAutoConfirmDonationsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :auto_confirm_contribution, :boolean
    add_column :projects, :paypal_email_address, :string
  end
end
