class User < ActiveRecord::Base
  has_many :tickets
  has_many :statuses
  has_many :assigned_tickets, class_name: 'Ticket',
            foreign_key: 'assignee_id'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
