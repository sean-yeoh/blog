class RenameItemToDescriptionInTodos < ActiveRecord::Migration[5.1]
  def change
  	rename_column :todos, :item, :description
  end
end
