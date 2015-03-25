class UserDecorator < Draper::Decorator
  delegate_all

  def name
    "#{first_name} #{last_name}".strip
  end

  def profile_pic
    object.profile_pic.sub(/^https?\:/, '') if object.profile_pic
  end
end
