module Dashboard
  class TranslationsController < Dashboard::BaseController
    def index
      load_translations
    end

    def edit
      load_translation
    end

    def update
      load_translation
      I18n.locale = @translation.locale.code.to_sym
      load_campaign
      build_campaign
      save_campaign
      redirect_to action: :edit
    end

    protected

    def load_translations
      @translations ||= translation_scope
    end

    def load_translation
      @translation ||= translation_scope.find(params[:id])
    end

    def translation_scope
      current_translator.permissions.where(resource_type: Campaign).translator
    end

    def load_campaign
      @campaign ||= @translation.campaign
      authorize! :read, @campaign
      @campaign
    end

    def build_campaign
      @campaign.attributes = campaign_params
    end

    def save_campaign
      @campaign.save
    end

    # rubocop:disable Metrics/MethodLength
    def campaign_params
      campaign_params = params[:campaign]
      return {} unless campaign_params
      campaign_params.permit(
        :name,
        engagement_player_attributes:
          [:id,
           :enabled,
           :media_link,
           :media_start,
           :media_stop],
        share_attributes:
          [:id,
           :title,
           :description,
           :subject,
           :message,
           :enabled],
        community_attributes:
          [:id,
           :title,
           :url,
           :other_campaign,
           :child_campaign_id,
           :description,
           :enabled]
      )
    end
    # rubocop:enable Metrics/MethodLength
  end
end
