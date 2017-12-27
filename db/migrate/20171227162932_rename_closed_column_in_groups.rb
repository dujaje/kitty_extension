class RenameClosedColumnInGroups < ActiveRecord::Migration[5.1]
  def change
    rename_column :groups, :closed?, :closed
  end
end
