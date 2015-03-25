module Dashboard
  module Campaigns
    class InvitesController < Dashboard::BaseController
      layout 'dashboard/modal'
      def index
      end

      def new
        load_campaign
        build_invite
      end

      def create
        load_campaign
        build_invite
        if save_invite
          redirect_to action: :index
        else
          build_invite
          render action: :new
        end
      end

      protected

      def build_invite
        @invite = User::Translator::Invite.new(campaign: @campaign)
        @invite.attributes = invite_params
        @invite.user = current_manager
        authorize! :read, @campaign
      end

      def save_invite
        authorize! :update, @campaign
        @invite.save
      end

      def load_campaign
        @campaign ||= campaign_scope.find(params[:campaign_id])
        authorize! :read, @campaign
      end

      def campaign_scope
        current_manager.campaigns
      end

      def invite_params
        invite_params = params[:user_translator_invite]
        if invite_params
          invite_params.permit(:first_name, :last_name, :email, :locale_id)
        else
          {}
        end
      end
    end
  end
end
