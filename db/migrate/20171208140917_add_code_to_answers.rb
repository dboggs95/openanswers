class AddCodeToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :code, :text
    add_column :answers, :license, :string
  end
end
