class CreateCampaignGrowthspaces < ActiveRecord::Migration
  def change
    create_table :campaign_growthspaces do |t|
      t.integer :campaign_id
      t.boolean :enabled, default: true
      t.string :title
      t.string :api_key
      t.string :api_secret

      t.timestamps
    end
  end
end
