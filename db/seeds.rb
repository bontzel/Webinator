# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.new({ :email => "user1@users.com", :password => "pass1234", :password_confirmation => "pass1234"}).save(false)

profile1 = Profile.create(:user_id => user1.id, :first_name => "John", :last_name => "Doe")
wall1 = Wall.create(:user_id => user1.id)
feed1 = Feed.create(:user_id => user1.id)
feedHistory1 = FeedHistory.create(:feed_id => feed1.id)

user2 = User.new({ :email => "user2@users.com", :password => "pass1234", :password_confirmation => "pass1234"}).save(false)

profile2 = Profile.create(:user_id => user2.id, :first_name => "Mark", :last_name => "Johnson")
wall2 = Wall.create(:user_id => user2.id)
feed2 = Feed.create(:user_id => user2.id)
feedHistory2 = FeedHistory.create(:feed_id => feed2.id)

user3 = User.new({ :email => "user3@users.com", :password => "pass1234", :password_confirmation => "pass1234"}).save(false)

profile3 = Profile.create(:user_id => user3.id, :first_name => "Bill", :last_name => "Collin")
wall3 = Wall.create(:user_id => user3.id)
feed3 = Feed.create(:user_id => user3.id)
feedHistory3 = FeedHistory.create(:feed_id => feed3.id)


user4 = User.new({ :email => "user4@users.com", :password => "pass1234", :password_confirmation => "pass1234"}).save(false)

profile4 = Profile.create(:user_id => user4.id, :first_name => "Ana", :last_name => "McKenzie")
wall4 = Wall.create(:user_id => user4.id)
feed4 = Feed.create(:user_id => user4.id)
feedHistory4 = FeedHistory.create(:feed_id => feed4.id)

user5 = User.new({ :email => "user5@users.com", :password => "pass1234", :password_confirmation => "pass1234"}).save(false)

profile5 = Profile.create(:user_id => user5.id, :first_name => "Joe", :last_name => "Dickens")
wall5 = Wall.create(:user_id => user5.id)
feed5 = Feed.create(:user_id => user5.id)
feedHistory5 = FeedHistory.create(:feed_id => feed5.id)


user1ToUser2Friendship = user1.friendships.build(:friend_id => user2.id, :pending => false, :accepted => true, :read => true)
user2ToUser3Friendship = user2.friendships.build(:friend_id => user3.id, :pending => true, :accepted => false, :read => false)
user3ToUser5Friendship = user3.friendships.build(:friend_id => user5.id, :pending => false, :accepted => false, :read => true)
