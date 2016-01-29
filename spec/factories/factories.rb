require 'ffaker'
FactoryGirl.define do 
  factory :user do
    email 'john.doe@example.com'
    password 'password'
    password_confirmation 'password'
  end
  factory :assignee, class: :user do
    email 'jane.doe@example.com'
    password 'password'
    password_confirmation 'password'
  end
  factory :ticket do
    user
    assignee
    sequence(:title) { |n| "A Very Long Title No. #{n}" }
    body {FFaker::HipsterIpsum.paragraphs}
    severity {['Critical', 'Major', 'Minor', 'Cosmetic'].sample}
  end
  factory :status do
    category {['Assigned', 'In Process', 'On Hold', 'Submitted', 'Resolved'].sample}
    sequence(:note) {|n| "Most Beautiful Note No. #{n}"}
    trait :assignee do
      association assignee, class: :user
    end
    trait :user do
      user
    end

  end

end