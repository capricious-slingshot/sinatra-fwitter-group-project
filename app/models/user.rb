class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, email: true, uniqueness: { case_sensitive: false }, length: { minimum: 8 }
  has_secure_password
  has_many :tweets

  #detail of bcrypt
  # def password=(string)
  #   hashed_string = CBcrypt.hash(string)
  #   self.password_digest = hashed_string
  # end

  def slug
    self.username.downcase.gsub(/\W+/, '-')
  end

  def self.find_by_slug(slug)
    User.all.find {|i| i.slug == slug}
  end

end
