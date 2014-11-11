class Post < ActiveRecord::Base
  validates :title, :link, presence: true
  validates :title, length: { maximum: 255}, presence: true
end
