class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  default_scope -> { includes(:user).order(created_at: :desc) }
end
