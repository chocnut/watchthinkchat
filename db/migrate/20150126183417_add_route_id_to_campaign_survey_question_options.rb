class AddRouteIdToCampaignSurveyQuestionOptions < ActiveRecord::Migration
  def change
    add_column :campaign_survey_question_options, :route_id, :integer
  end
end
