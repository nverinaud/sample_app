# == Schema Information
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Micropost < ActiveRecord::Base

  # Protect against mass assignement
  attr_accessible :content

  # Relationships
  belongs_to :user

  # Validation
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  # Sorting
  default_scope order: 'microposts.created_at DESC'

end
