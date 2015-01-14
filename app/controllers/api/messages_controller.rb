class Api::MessagesController < ApplicationController
  def create
    chat = Chat.where(:uid => params[:chat_uid]).first
    user = User.where("visitor_uid = ? OR operator_uid = ?", params[:user_uid], params[:user_uid]).first

    if chat && user
      message = chat.messages.create!(:user_id => user.id, :body => params[:message].to_s, :name => user.fullname, message_type: params[:message_type])
      Pusher["chat_#{chat.uid}"].trigger('event', {
        user_uid: params["user_uid"],
        message_type: params["message_type"],
        message: ERB::Util.html_escape(params["message"])
      })

      # store any fb info right away
      case params[:message_type]
      when 'fbName'
        words = params[:message]
        case words.length
        when 0
          first_name = last_name = nil
        when 1
          first_name = words.first
          last_name = nil
        else
          last_name = words.pop # last name is the last word only
          first_name = words.join(' ')
        end
        user.update_attribute(:first_name, first_name)
        user.update_attribute(:last_name, last_name)
      when 'fbEmail'
        if params[:message] =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
          user.update_attribute(:email, params[:message])
        end
      when 'fbId'
        user.update_attribute(:fb_uid, params[:message])
      end

      render json: { success: true }, status: 201
    elsif !chat
      render json: { error: "Chat not found" }, status: 500 
    elsif !user
      render json: { error: "User not found" }, status: 500 
    end
  end
end
