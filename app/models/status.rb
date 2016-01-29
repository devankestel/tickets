class Status < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  scope :recent, -> {order(created_at: :desc)}
  scope :current, -> {order(created_at: :desc).limit(1)}
  validates :category, :user_id, presence: :true
end
