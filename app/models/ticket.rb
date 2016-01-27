class Ticket < ActiveRecord::Base
  has_many :statuses
  belongs_to :user
  belongs_to :assignee, class_name: 'User',
              foreign_key: 'assignee_id'
  scope :recent, -> {order(created_at: :desc)}
  scope :issued_by_user, lambda { |user|
    where("tickets.user_id = ?", user.id)
} 
  scope :assigned_to_user, lambda { |user|
    where("tickets.assignee_id = ?", user.id)
} 
  validates :title, :body, :severity, :user_id, :assignee_id, presence: true
end
