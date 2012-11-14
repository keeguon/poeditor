class CreateLocales < ActiveRecord::Migration
  def self.up
    create_table :locales do |t|
      t.text :refs
      t.text :msgid
      t.text :msgid_plural
      t.text :msgstr_0
      t.text :msgstr_1
      t.string :locale

      t.timestamps
    end
  end

  def self.down
    drop_table :locales
  end
end
