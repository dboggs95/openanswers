class RemoveFreezeFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :freeze, :boolean
  end
end
