class RenameAvailableLocaleToAlternateLocale < ActiveRecord::Migration
  def change
    rename_table :available_locales, :alternate_locales
  end
end
