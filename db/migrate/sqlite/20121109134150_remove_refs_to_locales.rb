class RemoveRefsToLocales < ActiveRecord::Migration
  def self.up
    remove_column :locales, :refs
  end

  def self.down
    add_column :locales, :refs, :text
  end
end
