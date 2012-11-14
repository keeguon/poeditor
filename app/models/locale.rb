class Locale < ActiveRecord::Base
  # Set DB
  establish_connection ActiveRecord::Base.configurations["sqlite_#{Rails.env}"]

  # After save callback
  after_save { generate_po(locale) }

  # Public: Generate a PO file for a certain locale
  #
  # locale - The String containing the locale for which we want to generate the PO file
  #
  # Examples
  #
  #   generate_po("fr")
  #
  # Returns nothing
  def generate_po(locale)
    locales = Locale.where(:locale => locale)
    po_file = File.open("#{Rails.root}/po/#{locale}/#{Rails.application.class.to_s.split('::').first.downcase}.po", "w")
    
    locales.each do |locale|
      # Add fuzzy flag if necessary
      po_file << "#, fuzzy\n" if locale.fuzzy

      # msgids/msgstrs
      po_file << (locale.obsolete == true ? "#~ msgid \"#{locale.msgid}\"\n" : "msgid \"#{locale.msgid}\"\n")
      po_file << (locale.obsolete == true ? "#~ msgid_plural \"#{locale.msgid_plural}\"\n" : "msgid_plural \"#{locale.msgid_plural}\"\n") unless locale.msgid_plural.nil?
      if locale.msgstr_1.nil?
        po_file << (locale.obsolete == true ? "#~ msgstr \"#{locale.msgstr_0}\"\n" : "msgstr \"#{locale.msgstr_0}\"\n")
      else
        po_file << (locale.obsolete == true ? "#~ msgstr[0] \"#{locale.msgstr_0}\"\n" : "msgstr[0] \"#{locale.msgstr_0}\"\n")
        po_file << (locale.obsolete == true ? "#~ msgstr[1] \"#{locale.msgstr_1}\"\n" : "msgstr[1] \"#{locale.msgstr_1}\"\n")
      end

      # Add line break
      po_file << "\n"
    end

    po_file.close
  end
  handle_asynchronously :generate_po
end
