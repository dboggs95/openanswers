class AddCodeToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :code, :text
    add_column :questions, :license, :string
  end
end
