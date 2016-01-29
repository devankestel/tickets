# README

##About

This app is a simple ticket tracker built with Ruby 2.2.2p95 on Rails 4.2.5 with a Postgres 9.4.1 database. For dependencies, please consult the Gemfile.

##Usage

1. Set up the database by running the following series of commands. This assumes you have Postgres already on your system. If not please visit: http://www.postgresql.org/
`createuser tickets`
`createdb -Otickets -Eutf8 tickets_development`
`createdb -Otickets -Eutf8 tickets_test`
`rake db:migrate`
Optional: seed some dummy data with `rake db:seed`
For said dummy data, the initial password for all users is simply 'password'.
2. `bundle install`
3. `rails s` and navigate to `localhost:3000`
4. `sign up for site and begin creating tickets`

##Spec

This app was designed to meet certain specifications. 

* Creating user accounts and logging in, using any authentication gem you choose
  * Implemented with Devise authentication gem and `User` data model. 
  * Note: not currently configured for ActionMailer password recovery.
* CRUD interface for a Ticket
  * Submitting user
    * belongs to :user
  * Assigned user
    * belongs to :assignee, class: User, foreign_key: :assignee_id
  * State 
    * has_many :statuses, accessed via status.category
      * "Assigned", "Accepted", "In Process", "On Hold", "Submitted", "Resolved"
  * Severity
    * :severity
      * "Critical", "Major", "Minor", "Cosmetic"
  * Title
    * :title
  * Body
    * :body

  ##Tests

  ##Extra Features
  * Scopes for recent tickets, tickets issued by user, tickets assigned to user
  * Status history available in addition to current status
  * Status history includes user who changed status and a note
  * Styling using Bourbon.io sass framework with Neat, Bitters, and Refills
  * Seeds file using FFaker gem for demo mode



