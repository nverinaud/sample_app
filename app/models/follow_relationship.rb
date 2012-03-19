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

	# Accessible attributes
	attr_accessible :followed_id

	# Relationships
	belongs_to :follower, class_name: "User"
  	belongs_to :followed, class_name: "User"

  	# Validation
  	validates :follower_id, presence: true
  	validates :followed_id, presence: true
end
