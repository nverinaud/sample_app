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

require 'spec_helper'

describe FollowRelationship do
  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }
  let(:relationship) do
    follower.follow_relationships.build(followed_id: followed.id)
  end

  subject { relationship }

  it { should be_valid }
end
