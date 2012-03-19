# == Schema Information
#
# Table name: follow_relationships
#
#  id          :integer         not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

#
# follower_id follows followed_id
# get Doe's feed : all followed_id where follower_id = doe_id
# get Doe's followers : all follower_id where followed_id = doe_id
#

class FollowRelationship < ActiveRecord::Base
	attr_accessible :followed_id
end
