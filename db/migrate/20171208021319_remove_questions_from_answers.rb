class RemoveQuestionsFromAnswers < ActiveRecord::Migration[5.1]
  def change
    remove_reference :answers, :questions, foreign_key: true
  end
end
