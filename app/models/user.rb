# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean         default(FALSE)
#

class User < ActiveRecord::Base

  # Accessible Attributes
	attr_accessible :name, :email, :password, :password_confirmation


  # Relationships
  has_many :microposts, dependent: :destroy
  has_many :follow_relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :follow_relationships, source: :followed
  has_many :reverse_follow_relationships, foreign_key: "followed_id", 
                                          class_name: "FollowRelationship", 
                                          dependent: :destroy
  has_many :followers, through: :reverse_follow_relationships #, source: :follower 
                                                              # -> omitted because :followers become follower_id
                                                              # automatically with Rails


  # Callbacks
  before_save :create_remember_token


  # Generate Secure passwords methods / attributes
  has_secure_password


  # Validations
  validates :name,
                presence: true,
                length: { maximum: 50 }

  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
                presence: true,
                format: { with: valid_email_regex },
                uniqueness: { case_sensitive: false }

  validates :password,
                length: { minimum: 6 }


  # Feed
  def feed
    return Micropost.where("user_id = ?", id)
  end


  # Follow Feature
  def following?(other_user)
    return self.follow_relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    self.follow_relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    self.follow_relationships.find_by_followed_id(other_user.id).destroy
  end

  # Remember Token
  private

    def create_remember_token
      self.remember_token ||= SecureRandom.urlsafe_base64
    end

end
