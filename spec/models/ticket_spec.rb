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

  describe "#set_status options for current user" do
    before :each do 
      @ticket = create(:ticket)
    end
  
    it "returns 'On Hold' and 'Resolved' for ticket issuer" do 
      expect(@ticket.set_status_options(@ticket.user)).to eq ["On Hold", "Resolved"]
    end
    it "returns 'Accepted', 'On Hold', 'Submitted', 'Resolved' for assignee" do
      expect(@ticket.set_status_options(@ticket.assignee)).to eq ["Accepted", "In Process", "On Hold", "Submitted"]
    end
    it "returns all options when issuer and assignee" do
      @ticket.assignee_id = @ticket.user.id
      expect(@ticket.set_status_options(@ticket.assignee)).to eq ["Accepted", "In Process", "On Hold", "Submitted", "Resolved"]
    end
  end

  describe "issued_by_user scope" do
    before :each do
      @ticket = create(:ticket)
    end
    it "includes users who issue tickets" do
      expect(Ticket.all.issued_by_user(@ticket.user)).to include @ticket
    end
    it "excludes users who do not issue tickets" do
      expect(Ticket.all.issued_by_user(@ticket.assignee)).not_to include @ticket
    end
  end

  describe "assigned_to_user scope" do
    before :each do
      @ticket = create(:ticket)
    end
    it "includes users who are assigned tickets" do
      expect(Ticket.all.assigned_to_user(@ticket.assignee)).to include @ticket
    end
    it "excludes users who are not assigned tickets" do
      expect(Ticket.all.assigned_to_user(@ticket.user)).not_to include @ticket
    end
  end
  
  
end