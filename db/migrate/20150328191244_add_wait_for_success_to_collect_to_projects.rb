class AddWaitForSuccessToCollectToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :wait_for_success_to_collect_funds, :boolean
  end
end
