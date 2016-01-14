class Comment < ActiveRecord::Base
  validates :text, length: { minimum: 2 }
  belongs_to :user
  belongs_to :post
end
