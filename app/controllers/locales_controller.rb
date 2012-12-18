require "csv"

class LocalesController < ApplicationController
  respond_to :html, :json

  def index
    filter = params[:filter] || "locales"
    limit  = params[:limit].to_i || 25
    page   = params[:page].to_i || 1

    @locales = case filter
      when "locales"
        locales = Dir.entries("#{Rails.root}/po").select do |entry|
          File.directory?(File.join(Rails.root, "po", entry)) and !(entry =='.' || entry == '..')
        end
      when "locale"
        locales = GetPomo::PoFile.parse(File.read("#{Rails.root}/po/#{params[:locale]}/#{Rails.application.class.to_s.split('::').first.downcase}.po"))
        locales.reject!{|l| l.msgid == ""}

        if params.has_key?(:fuzzy) and (params[:fuzzy] =~ /(t|1|true|on)/i)
          fuzzy = (params[:fuzzy] =~ /(t|1|true|on)/i) ? true : false

          if fuzzy
            locales.reject{|l| l.fuzzy?.nil?}[((page - 1) * limit + (page - 1))..(((page - 1) * limit) + limit + (page - 1))]
          else
            locales.select{|l| l.fuzzy?.nil?}[((page - 1) * limit + (page - 1))..(((page - 1) * limit) + limit + (page - 1))]
          end
        else
          locales[((page - 1) * limit + (page - 1))..(((page - 1) * limit) + limit + (page - 1))]
        end
      else nil
    end

    respond_with @locales
  end

  def show ; end

  def new ; end

  def create ; end

  def edit ; end

  def update
    data    = params.except(:action, :controller, :options)
    options = params[:options]

    translations = GetPomo::PoFile.parse(File.read("#{Rails.root}/po/#{options["locale"]}/#{Rails.application.class.to_s.split('::').first.downcase}.po"))
    locales = lambda do |translations|
      translations.reject!{|t| t.msgid == ""}

      if options.has_key?("fuzzy") and (options["fuzzy"] =~ /(t|1|true|on)/i)
        fuzzy = (options["fuzzy"] =~ /(t|1|true|on)/i) ? true : false

        if fuzzy
          translations.reject{|t| t.fuzzy?.nil?}
        else
          translations.select{|t| t.fuzzy?.nil?}
        end
      else
        translations
      end
    end.call(translations)

    # Find and replace translation
    index = translations.find_index(locales[data["id"].to_i])
    @locale = locales[data["id"].to_i]
    @locale.msgid   = data["msgid"]
    @locale.msgstr  = data["msgstr"]
    @locale.comment = data["comment"]
    translations[index] = @locale

    # Create delayed job to rewrite the PO file asynchronously
    Delayed::Job.enqueue WritePo.new(options["locale"], GetPomo::PoFile.to_text(translations))

    render :json => @locale
  end

  def destroy
    translations = GetPomo::PoFile.parse(File.read("#{Rails.root}/po/#{params[:locale]}/#{Rails.application.class.to_s.split('::').first.downcase}.po"))
    locales = lambda do |translations|
      translations.reject!{|t| t.msgid == ""}

      if params.has_key?(:fuzzy) and (params[:fuzzy] =~ /(t|1|true|on)/i)
        fuzzy = (params[:fuzzy] =~ /(t|1|true|on)/i) ? true : false

        if fuzzy
          translations.reject{|t| t.fuzzy?.nil?}
        else
          translations.select{|t| t.fuzzy?.nil?}
        end
      else
        translations
      end
    end.call(translations)

    # Find and delete translation
    index = translations.find_index(locales[params[:id].to_i])
    @locale = translations.delete_at(index)

    # Create delayed job to rewrite the PO file asynchronously
    Delayed::Job.enqueue WritePo.new(params[:locale], GetPomo::PoFile.to_text(translations))

    render :json => @locale
  end
end
