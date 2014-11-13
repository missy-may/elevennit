class Post < ActiveRecord::Base
  :acts_as_commentable
  validates :title, length: { maximum: 255 }, presence: true
  validates :link, presence: true, if: :link?
  validates :link, length: { maximum: 2000 }
  validates :body, presence: true, if: :text?
  enum post_type: [:link, :text]
  validates :category_id, presence: true
  belongs_to :category
  belongs_to :user
  default_scope { order('updated_at DESC').includes(:category).includes(:user) }
  scope :with_categories, -> {includes(:category)}


  self.per_page = 5
end
