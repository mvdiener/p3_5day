class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :flight

  validates :satisfied, inclusion: {in: [true, false]}
  validates :text, presence: true, length: { maximum: 140 }
  validates :user, presence: true
  validates :flight, presence: true
end
