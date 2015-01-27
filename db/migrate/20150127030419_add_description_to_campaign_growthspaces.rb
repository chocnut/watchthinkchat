class AddDescriptionToCampaignGrowthspaces < ActiveRecord::Migration
  def up
    add_column :campaign_growthspaces, :description, :text
    Campaign::Growthspace.add_translation_fields! description: :text
  end

  def down
    remove_column :campaign_growthspace_translations, :description
    remove_column :campaign_growthspaces, :description
  end
end
