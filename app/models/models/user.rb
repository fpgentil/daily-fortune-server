class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :token, type: String
  field :databases, type: Array
  field :active, type: Boolean, default: true

  validates :email, presence: true
  validates :email, uniqueness: true

  before_create :generate_token

  private
  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.where(token: random_token).any?
    end
  end

end