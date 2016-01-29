require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it "has a valid factory" do
    expect(build(:ticket)).to be_valid
  end

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to validate_presence_of :assignee_id }
  it { is_expected.to validate_presence_of :severity }
  
  
end