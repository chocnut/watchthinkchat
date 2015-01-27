module Dashboard
  module Campaigns
    class BuildController < Dashboard::BaseController
      include Wicked::Wizard::Translated

      steps :basic,
            :engagement_player,
            :growthspace,
            :survey,
            :share,
            :community,
            :opened

      helper_method :campaign_scope

      def show
        load_campaign
        unless @campaign.opened? || @campaign.status == wizard_value(step) ||
               future_step?(I18n.t("wicked.#{@campaign.status}"))
          return redirect_to(campaign_build_path(campaign_id: @campaign, id: I18n.t("wicked.#{@campaign.status}")))
        end
        send wizard_value(step) if self.class.method_defined? wizard_value(step).to_sym
        decorate_campaign
        render_wizard
      end

      def update
        load_campaign
        build_campaign
        save_campaign
        render_wizard @campaign
      end

      protected

      def survey
        return unless @campaign.growthspace.try(:enabled?)
        return if @campaign.growthspace.api_key.blank? || @campaign.growthspace.api_secret.blank?
        Campaign::Growthspace::Route.access_id = @campaign.growthspace.api_key
        Campaign::Growthspace::Route.access_secret = @campaign.growthspace.api_secret
      end

      def load_campaign
        @campaign ||= campaign_scope.find(params[:campaign_id])
        authorize! :read, @campaign
      end

      def build_campaign
        set_i18n
        @campaign.attributes = campaign_params
        return if future_step?(I18n.t("wicked.#{@campaign.status}"))
        @campaign.status = wizard_value(next_step)
        @campaign.status = wizard_value(step) unless @campaign.valid?
      end

      def set_i18n
        return unless campaign_params[:locale_id] || @campaign.locale
        I18n.locale =
          Locale.find(campaign_params[:locale_id] || @campaign.locale).code.to_sym
      end

      def decorate_campaign
        @campaign = @campaign.try(:decorate)
      end

      def campaign_scope
        current_manager.campaigns
      end

      def save_campaign
        authorize! :update, @campaign
        @campaign.save
      end

      # rubocop:disable Metrics/MethodLength
      def campaign_params
        campaign_params = params[:campaign]
        return {} unless campaign_params
        campaign_params.permit(
          :name,
          :locale_id,
          :url,
          :subdomain,
          :intro,
          :description,
          locale_ids: [],
          engagement_player_attributes:
            [:id, :enabled, :media_link, :media_start, :media_stop],
          share_attributes:
            [:id, :title, :description, :enabled, :facebook, :twitter, :email, :link],
          community_attributes:
            [:id, :title, :url, :other_campaign, :child_campaign_id, :description, :enabled],
          growthspace_attributes:
            [:id, :title, :api_key, :api_secret, :description, :enabled]
        )
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
