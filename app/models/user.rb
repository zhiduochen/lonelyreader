class User < ApplicationRecord
  validates :username, presence: true, length: {maximum: 25}

  has_many :favorites
  has_many :collected_products, :through => :favorites, :source => :product
  has_many :identifies

  has_many :orders

  has_many :boards

  has_many :relationships
  has_many :participated_boards, :through => :relationships, :source => :board

  has_many :posts
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  def admin?
    is_admin
  end

  def has_collected?(product)
    collected_products.include?(product)

  end

  def collect!(product)
    collected_products << product

  end

  def discollect!(product)
    collected_products.delete(product)
  end

  def self.from_google(access_token, signed_in_resource=nil)
  	data = access_token.info
  	identify = Identify.find_by(:provider => access_token.provider, :uid => access_token.uid)

  	if identify
  		return identify.user
  	else
  		user = User.find_by(:email => access_token.email)
  		if !user
  			user = User.create(
  				username: data["name"],
  				email: data["email"],
  				image: data["image"],
  				password: Devise.friendly_token[0,20]
  			)
  		end
			identify = Identify.create(
				provider: access_token.provider,
				uid: access_token.uid,
				user: user
			)
		return user
  	end
  end

  def is_member_of?(board)
    participated_boards.include?(board)
  end

  def join!(board)
    participated_boards << board
  end

  def quit!(board)
    participated_boards.delete(board)
  end
end
