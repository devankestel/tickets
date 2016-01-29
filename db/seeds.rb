# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'ffaker'
password = "password"

user_1_params = {email: FFaker::Internet.safe_email, password: password, password_confirmation: password}
user_2_params = {email: FFaker::Internet.safe_email, password: password, password_confirmation: password}
user_3_params = {email: FFaker::Internet.safe_email, password: password, password_confirmation: password}
user_4_params = {email: FFaker::Internet.safe_email, password: password, password_confirmation: password}
user_5_params = {email: FFaker::Internet.safe_email, password: password, password_confirmation: password}

puts user_1_params
puts user_2_params
puts user_3_params
puts user_4_params
puts user_5_params

#Create 5 users with password set to "password"
5.times do 
  User.create({email: FFaker::Internet.safe_email, password: password, password_confirmation: password})
end

#Each user issues 10 tickets, may either be assigned to themselves or someone else
severity = ["Critical", "Major", "Minor", "Cosmetic"]
assignee = User.all.pluck(:id)
User.all.each do |user|
  10.times do
    ticket = user.tickets.create({title: FFaker::HipsterIpsum.phrase, body: FFaker::HipsterIpsum.paragraphs.join(" "), 
      severity: severity.sample, assignee_id: assignee.sample})
    ticket.statuses.create(category: "Assigned", note: "Ticket assigned to #{ticket.assignee.email}", user_id: user.id)
    # Assign a random number of statuses to the ticket, aside from resolved
    rand(0..10).times do
      changer= [ticket.assignee, ticket.user].sample
      options = ticket.set_status_options(changer)
      #So that resolved will only be the last status change, to make more realistic.
      options -= ["Resolved"]
      #In reality, ticket can be reassigned by issuer, but difficult to simulate that mode in seeds.
      options -= ["Assigned"]
      ticket.statuses.create(note: FFaker::HipsterIpsum.phrase, category: options.sample, user_id: changer.id)
    end
    # Randomly have issuer resolve the ticket
    rand(0..1).times do
      ticket.statuses.create(note: "Issue resolved!", category: "Resolved", user_id: user.id)
    end
  end
end



