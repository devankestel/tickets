require 'rails_helper'
RSpec.feature "ticket controller" do
  scenario "A User can add a ticket from the new form" do
    user = create(:user)
    visit user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_on("Log in")
    visit new_ticket_path
    fill_in "Title", with: "My Awesome Title"
    fill_in "Body", with: "The best ticket you've ever seen."
    select('Critical', :from => 'Severity')
    select(user.email, :from => 'Assignee')
    click_on("Create Ticket")

    expect(page).to have_content("Ticket created successfully.")
    expect(page).to have_content("My Awesome Title")
    expect(page).to have_content("The best ticket you've ever seen.")
    expect(page).to have_content("john.doe@example.com")
    expect(page).to have_content("Critical")
  end
  
end