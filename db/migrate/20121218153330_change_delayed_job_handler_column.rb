class ChangeDelayedJobHandlerColumn < ActiveRecord::Migration
  def self.up
    change_column :delayed_jobs, :handler, :text, :limit => 4294967295
  end

  def self.down
    change_column :delayed_jobs, :handler, :text, :limit => 65535
  end
end
