class Post < ActiveRecord::Base
  validates :title, length: { maximum: 25}
end
