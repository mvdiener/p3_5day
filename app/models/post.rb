class Post < ActiveRecord::Base
  validates :satisfied, inclusion: {in: [true, false]}
  validates :text, presence: true, length: { maximum: 140 }
end
