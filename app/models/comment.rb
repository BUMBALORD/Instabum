class Comment < ActiveRecord::Base
  validates :content, length: { minimum: 1, maximum: 300 }

  belongs_to :user
  belongs_to :post
end
