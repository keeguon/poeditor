class AddFuzzyToLocales < ActiveRecord::Migration
  def self.up
    add_column :locales, :fuzzy, :boolean
  end

  def self.down
    remove_column :locales, :fuzzy
  end
end
