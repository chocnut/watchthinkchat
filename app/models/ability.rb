class Ability
  include CanCan::Ability

  def initialize(user)
    define_aliases
    can :manage, Dashboard if user.is?(:manager) || user.is?(:translator)
    can :create, Campaign if user.is? :manager
    user.permissions.each do |permission|
      can permission.state.to_sym, permission.resource
    end
  end

  private

  def define_aliases
    alias_action :manage, to: :owner
    alias_action :read, :update, to: :editor
    alias_action :read, to: :viewer
    alias_action :read, to: :translator
  end
end
