class Visitor < ActiveRecord::Base
  has_many :interactions, dependent: :destroy
  before_validation :ensure_tokens
  devise :database_authenticatable

  def as(role)
    becomes "VisitorInvite::#{role.to_s.camelize}".constantize
  end

  private

  def ensure_tokens
    self.share_token = generate_token('share_token') unless share_token
    return if authentication_token
    self.authentication_token = generate_token('authentication_token')
  end

  def generate_token(field)
    loop do
      token = Devise.friendly_token
      break token unless Visitor.where('? = ?', field, token).first
    end
  end
end
