class Question < ApplicationRecord
    searchable do
        text :title, :body
    end
    has_many :comments, dependent: :destroy
    has_many :answers, dependent: :destroy
    validates :title, presence: true, length: {maximum: 150}
    validates :body, presence: true, length: {maximum: 1000}
end
