class RenameAlternateLocales < ActiveRecord::Migration
  def change
    rename_table :alternate_locales, :campaign_alternate_locales
  end
end
