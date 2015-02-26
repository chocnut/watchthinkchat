class User < ActiveRecord::Base
  include RoleModel

  # associations
  has_many :permissions, dependent: :destroy
  has_many :campaigns,
           through: :permissions,
           source: :resource,
           source_type: 'Campaign'

  # definintions
  devise :invitable, :registerable,
         :trackable,
         :database_authenticatable,
         :rememberable,
         :recoverable

  devise :omniauthable, omniauth_providers: [:facebook]

  roles_attribute :roles_mask
  roles :nobody, :manager, :translator

  attr_writer :invitation_instructions
  attr_accessor :invite

  def as(role)
    return becomes "User::#{role.to_s.camelize}".constantize if self.is? role
    fail ActiveRecord::ActiveRecordError
  end

  def self.invite_translator!(attributes = {}, invited_by = nil, invitation)
    self.invite!(attributes, invited_by) do |invitable|
      invitable.invite = invitation
      invitable.invitation_instructions = :translator_invitation_instructions
    end
  end

  def deliver_invitation
    if @invitation_instructions.present?
      ::Devise.mailer.send(@invitation_instructions, self).deliver
    else
      super
    end
  end
end
