class AddTranslationTables < ActiveRecord::Migration
  def up
    Campaign.create_translation_table! name: :string
    Campaign::Survey::Question.create_translation_table! title: :string, help_text: :text
    Campaign::Survey::Question::Option.create_translation_table! title: :string
    Campaign::Community.create_translation_table! url: :string, description: :text, title: :string
    Campaign::EngagementPlayer.create_translation_table! media_link: :string
    Campaign::Share.create_translation_table! title: :string, description: :string
  end

  def down
    Campaign.drop_translation_table!
    Campaign::Survey::Question.drop_translation_table!
    Campaign::Survey::Question::Option.drop_translation_table!
    Campaign::Community.drop_translation_table!
    Campaign::EngagementPlayer.drop_translation_table!
    Campaign::Share.drop_translation_table!
  end
end
