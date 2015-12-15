# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
org_1 =  Organization.create(
  name: "Heart and stroke",
  email: "heart@stroke.com",
  website_url: "www.heart.ca",
  description: "something");
org_2 =  Organization.create(
  name: "Fake Bamboo",
  email: "Fake@bamboo.com",
  website_url: "www.FBamboo.ca",
  description: "something about fake bamboo");
opp_1 = Opportunity.create(
  organization_id: 1,
  name: "Walk for the cure",
  location: "2300 Yonge Street #1300, Toronto, ON M4P 1E4",
  start_time: Time.new(2016, 1, 12, 6, 0, 0) ,
  end_time: Time.new(2016, 1, 12, 12, 0, 0),
  description: "Walking to cure heart disease",
  max_capacity: 10
  );
opp_2 = Opportunity.create(
  organization_id: 1,
  name: "Run for the cure",
  location: "220 King St W, Suite 200, Toronto, ON M5H 1K4",
  start_time: Time.new(2016, 1, 12, 6, 0, 0) ,
  end_time: Time.new(2016, 1, 12, 12, 0, 0),
  description: "Running to cure heart disease",
  max_capacity: 100
  );

user_1 = User.create(
  first_name: "Betty",
  last_name: "Maker",
  email: "betty@maker.com",
  password: "blah",
  password_confirmation: "blah"
  );
user_2 = User.create(
  first_name: "John",
  last_name: "Doe",
  email: "john@doe.com",
  password: "blah",
  password_confirmation: "blah"
  );