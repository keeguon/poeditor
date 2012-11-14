namespace :locales do
  desc "Import locales from a PO file"
  task :import, [:locale, :po_file] => :environment do |t, args|
    translations = GetPomo::PoFile.parse(File.read(args[:po_file]))

    translations.each do |translation|
      locale = Locale.new :locale => args[:locale]

      # msgids
      if translation.msgid.is_a?(Array)
        locale.msgid = translation.msgid[0]
        locale.msgid_plural = translation.msgid[1]
      elsif translation.msgid.is_a?(String)
        locale.msgid = translation.msgid
      end

      # msgstrs
      if translation.msgstr.is_a?(Array)
        locale.msgstr_0 = translation.msgstr[0]
        locale.msgstr_1 = translation.msgstr[1]
      elsif translation.msgstr.is_a?(String)
        locale.msgstr_0 = translation.msgstr
      end

      # fuzzy flag
      locale.fuzzy = true if translation.fuzzy?

      # Save and log
      saved = locale.save
      p (saved ? "> The locale was successfully imported." : "> There was an error importing the locale.")
    end
  end
end