class RemoveQuestionsFromComments < ActiveRecord::Migration[5.1]
  def change
    remove_reference :comments, :questions, foreign_key: true
  end
end
