class Ticket < ActiveRecord::Base
  has_many :statuses, dependent: :destroy
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
  
  def set_status_options(user)
    if user == self.user && user == self.assignee
      ["Accepted", "In Process", "On Hold", "Submitted", "Resolved"]
    elsif user == self.user
      ["On Hold", "Resolved"]
    elsif user == self.assignee
      ["Accepted", "In Process", "On Hold", "Submitted"]
    else
      []
    end
  end
  def self.table_display(str, len)
    if str.length > len
      "#{str.slice(0..len-3)}..."
    else
      str
    end
  end
end
