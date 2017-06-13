class AddCompletedToLists < ActiveRecord::Migration
  def change
    add_column :lists, :completed, :boolean
    add_column :lists, :completed_at, :datetime
  end
end
