class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :rounds

  validates :name, presence: true
  validates :username, uniqueness: {case_sensitive: true},presence: true
  validates :password, presence: true
  validates_length_of :password, :in => 6..20

  def self.authenticate(username, password)
    user = User.find_by_username(username)
    if user && user.password == password
      return user
    end
    return nil
  end

end
