require 'rails_helper'

RSpec.describe Status, type: :model do
  it "has a valid factory" do
    expect(build(:status, :from_user)).to be_valid
    expect(build(:status, :from_assignee)).to be_valid
  end

  it { is_expected.to validate_presence_of :category }
  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.not_to validate_presence_of :note }
  it { is_expected.to belong_to :ticket}
  
end