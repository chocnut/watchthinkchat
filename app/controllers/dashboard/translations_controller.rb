module Dashboard
  class TranslationsController < Dashboard::BaseController
    def index
      load_translations
    end

    def edit
      load_translation
      raise "LOL"
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
        :intro,
        :description,
        growthspace_attributes:
          [:id, :title, :description],
        engagement_player_attributes:
          [:id, :media_link],
        share_attributes:
          [:id, :title, :description, :subject, :message],
        community_attributes:
          [:id, :title, :url, :description],
        survey_attributes:
          [questions_attributes:
            [:id, :title, :help_text, options_attributes:
              [:id, :title]
            ]
          ]
      )
    end
    # rubocop:enable Metrics/MethodLength
  end
end
