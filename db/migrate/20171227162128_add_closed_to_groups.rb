class AddClosedToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :closed?, :boolean, default: false
  end
end
