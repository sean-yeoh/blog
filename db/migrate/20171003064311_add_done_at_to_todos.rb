class AddDoneAtToTodos < ActiveRecord::Migration[5.1]
  def change
    add_column :todos, :done_at, :datetime
  end
end
