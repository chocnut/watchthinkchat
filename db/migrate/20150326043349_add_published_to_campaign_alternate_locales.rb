class AddPublishedToCampaignAlternateLocales < ActiveRecord::Migration
  def change
    add_column :campaign_alternate_locales, :published, :boolean
  end
end
