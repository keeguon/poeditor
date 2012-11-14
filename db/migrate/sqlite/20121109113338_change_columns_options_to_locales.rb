class ChangeColumnsOptionsToLocales < ActiveRecord::Migration
  def self.up
    change_column :locales, :msgid, :text, :null => false
    change_column :locales, :msgstr_0, :text, :null => false
    change_column :locales, :locale, :string, :null => false
  end

  def self.down
    change_column :locales, :msgid, :text, :null => true
    change_column :locales, :msgstr_0, :text, :null => true
    change_column :locales, :locale, :string, :null => true
  end
end
