class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :flight

  validates :satisfied, inclusion: {in: [true, false]}
  validates :text, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  validates :flight_id, presence: true
end
