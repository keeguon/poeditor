class AddObsoleteToLocales < ActiveRecord::Migration
  def self.up
    add_column :locales, :obsolete, :boolean, :default => false
    change_column_default :locales, :fuzzy, false
  end

  def self.down
    remove_column :locales, :obsolete
    change_column_default :locales, :fuzzy, nil
  end
end
