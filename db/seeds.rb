# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.new({ :email => "user1@users.com", :password => "pass1234", :password_confirmation => "pass1234"}).save(:validate => false)
user1 = User.find(1)


profile1 = Profile.create(:user_id => user1.id, :first_name => "John", :last_name => "Doe")
user1.wall = Wall.create()
feed1 = Feed.create(:user_id => user1.id)
feedHistory1 = FeedHistory.create(:feed_id => feed1.id)

user1.skip_confirmation!

user1.save!


User.new({ :email => "user2@users.com", :password => "pass1234", :password_confirmation => "pass1234"}).save(:validate => false)
user2 = User.find(2)

profile2 = Profile.create(:user_id => user2.id, :first_name => "Mark", :last_name => "Johnson")
user2.wall = Wall.create()
feed2 = Feed.create(:user_id => user2.id)
feedHistory2 = FeedHistory.create(:feed_id => feed2.id)

User.new({ :email => "user3@users.com", :password => "pass1234", :password_confirmation => "pass1234"}).save(:validate => false)
user3 = User.find(3)

profile3 = Profile.create(:user_id => user3.id, :first_name => "Bill", :last_name => "Collin")
user3.wall = Wall.create()
feed3 = Feed.create(:user_id => user3.id)
feedHistory3 = FeedHistory.create(:feed_id => feed3.id)


User.new({ :email => "user4@users.com", :password => "pass1234", :password_confirmation => "pass1234"}).save(:validate => false)
user4 = User.find(4)

profile4 = Profile.create(:user_id => user4.id, :first_name => "Ana", :last_name => "McKenzie")
user4.wall = Wall.create()
feed4 = Feed.create(:user_id => user4.id)
feedHistory4 = FeedHistory.create(:feed_id => feed4.id)

User.new({ :email => "user5@users.com", :password => "pass1234", :password_confirmation => "pass1234"}).save(:validate => false)
user5 = User.find(5)

profile5 = Profile.create(:user_id => user5.id, :first_name => "Joe", :last_name => "Dickens")
user5.wall = Wall.create()
feed5 = Feed.create(:user_id => user5.id)
feedHistory5 = FeedHistory.create(:feed_id => feed5.id)


user2.skip_confirmation!
user3.skip_confirmation!
user4.skip_confirmation!
user5.skip_confirmation!


user2.save!
user3.save!
user4.save!
user5.save!



user1ToUser2Friendship = user1.friendships.build(:friend_id => user2.id, :pending => false, :accepted => true, :read => true)
user2ToUser3Friendship = user2.friendships.build(:friend_id => user3.id, :pending => true, :accepted => false, :read => false)
user3ToUser5Friendship = user3.friendships.build(:friend_id => user5.id, :pending => false, :accepted => false, :read => true)
user1ToUser3Friendship = user1.friendships.build(:friend_id => user3.id, :pending => false, :accepted => true, :read => true)
user1ToUser4Friendship = user1.friendships.build(:friend_id => user4.id, :pending => false, :accepted => true, :read => true)
user1ToUser5Friendship = user1.friendships.build(:friend_id => user5.id, :pending => false, :accepted => true, :read => true)

user1ToUser2Friendship.save
user2ToUser3Friendship.save
user3ToUser5Friendship.save
user1ToUser3Friendship.save
user1ToUser4Friendship.save
user1ToUser5Friendship.save

post1 = Post.new
post1.text = "How was your holiday?"
post1.user = user1
post1.wall = user2.wall
post1.save


post2 = Post.new
post2.text = "Good, I had fun!"
post2.user = user2
post2.wall = user1.wall
post2.save

post3 = Post.new
post3.text = "Hello France! :D"
post3.user = user2
post3.wall = user2.wall
post3.save


comment1 = Comment.create(:text => "Random Comment", :user_id => user2.id,  :post_id => post1.id)
comment2 = Comment.create(:text => "Yes indeed :D", :user_id => user2.id, :post_id => post2.id)
comment3 = Comment.create(:text => "I envy you >.<", :user_id => user1.id, :post_id => post3.id)

count = 1


ufp1 = UserFriendsPreference.create(:user_id => user1.id, :entries => [])

3.times do
	postx = Post.new
	postx.text = "Text no. #{count}."
	postx.user = user2
	postx.wall = user2.wall
	postx.save
	
  
  user1.post_likes << postx
  user3.post_likes << postx
  user4.post_likes << postx
  count = count + 1
end

ufp1.entries.push("2:3")

5.times do
	
	postx = Post.new
	postx.text = "Text no. #{count}."
	postx.user = user2
	postx.wall = user2.wall
	postx.save
	
  user1.post_likes << postx
  count = count + 1
end

ufp1.entries.push("3:5")

10.times do
	
	postx = Post.new
	postx.text = "Text no. #{count}."
	postx.user = user4
	postx.wall = user4.wall
	postx.save
	
  user1.post_likes << postx
  count = count + 1
end

ufp1.entries.push("4:10")

ufp1.save


user2.post_likes << post1

UserPopularity.create(:user_id => user4.id, :likers => [user1.id])
UserPopularity.create(:user_id => user3.id, :likers => [user1.id])
UserPopularity.create(:user_id => user5.id, :likers => [user1.id])
UserPopularity.create(:user_id => user1.id, :likers => [user2.id])
UserPopularity.create(:user_id => user2.id, :likers => [user1.id, user3.id, user4.id])

user4.likers_count = 1
user3.likers_count = 1
user5.likers_count = 1
user1.likers_count = 1
user2.likers_count = 3

user4.save
user3.save
user5.save
user1.save
user2.save

Notification.create(:user_id => user1.id, :actor_id => user2.id, :notifiable_id => post1.id, :notifiable_type => 'Post', :message_type => 0, :seen => false)

n1 = Notification.new
n1.user = user1
n1.actor = user2
n1.notifiable = comment1
n1.notifiable_type = 'Comment'
n1.message_type = 0
n1.seen = false
n1.save

Notification.create(:user_id => user1.id, :actor_id => user2.id, :notifiable_id => comment2.id, :notifiable_type => 'Comment', :message_type => 0, :seen => false)
Notification.create(:user_id => user2.id, :actor_id => user1.id, :notifiable_id => comment3.id, :notifiable_type => 'Comment', :message_type => 0, :seen => false)

Tag.create(:name => "Economy")
Tag.create(:name => "Biology")
Tag.create(:name => "Bussiness")
Tag.create(:name => "Programming")
Tag.create(:name => "IT")
Tag.create(:name => "Celebrities")
Tag.create(:name => "Music")
Tag.create(:name => "Sports")
Tag.create(:name => "Politics")
Tag.create(:name => "Lifestyle")
