class RemoveColumnFromGame < ActiveRecord::Migration
  def change
    remove_column :games, :players, :integer
  end
end
