class Post < ApplicationRecord
  belongs_to :blog
  has_rich_text :content
  has_one_attached :cover
end
