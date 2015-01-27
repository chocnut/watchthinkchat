class AddIntroAndDescriptionToCampaigns < ActiveRecord::Migration
  def up
    add_column :campaigns, :intro, :string
    add_column :campaigns, :description, :text
    Campaign.add_translation_fields! intro: :string, description: :text
  end

  def down
    remove_column :campaign_translations, :intro
    remove_column :campaign_translations, :description
    remove_column :campaigns, :intro
    remove_column :campaigns, :description
  end
end
