class Question < ActiveRecord::Base

  belongs_to :user

  belongs_to :author, class_name: 'User'

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255 }
end
