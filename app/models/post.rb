class Post < ActiveRecord::Base
  validates :flight, :user, :text, :satisfied, presence: :true
  validates :text, length: { maximum: 140}
  belongs_to :user
  belongs_to :flight
end
