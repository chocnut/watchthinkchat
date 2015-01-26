class CreateCampaignGrowthspacesTranslations < ActiveRecord::Migration
  def up
    Campaign::Growthspace.create_translation_table! title: :string
  end

  def down
    Campaign::Growthspace.drop_translation_table!
  end
end
