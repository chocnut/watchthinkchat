class AddUidBackToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :uid, :string
  end
end
