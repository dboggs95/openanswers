class AddFreezeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :freeze, :boolean, default: false
  end
end
