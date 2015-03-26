class AddOrientatedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :orientated, :boolean
  end
end
