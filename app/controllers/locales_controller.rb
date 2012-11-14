class LocalesController < ApplicationController
  respond_to :html, :json

  def index
    filter = params[:filter] || "locales"
    limit  = params[:limit] || 25
    page   = params[:page] || 1

    @locales = case filter
      when "locales"
        Locale.select(:locale).group(:locale)
      when "locale"
        if params.has_key?(:fuzzy)
          Locale.where(:locale => params[:locale], :fuzzy => (params[:fuzzy] =~ (/(t|1|true|on)/i)) ? true : false).paginate(:page => page, :per_page => limit)
        else
          Locale.where(:locale => params[:locale]).paginate(:page => page, :per_page => limit)
        end
      else Locale.paginate(:page => page, :per_page => limit)
    end

    respond_with @locales
  end

  def show
    @locale = Locale.find(params[:id])
    render :json => @locale
  end

  def new

  end

  def create
    data    = params.except(:action, :controller)
    created = @locale = Locale.create(data)

    if created
      render :json => @locale
    else
      render :json => @locale.errors.to_hash, :status => 400
    end
  end

  def edit

  end

  def update
    @locale      = Locale.find(params[:id])
    data         = params.except(:action, :controller, :fuzzy)
    data[:fuzzy] = (params[:fuzzy] =~ (/(t|1|true|on)/i)) ? true : false
    updated      = @locale.update_attributes(data)

    if updated
      render :json => @locale
    else
      render :json => @locale.errors.to_hash, :status => 400
    end
  end

  def destroy
    @locale = Locale.find(params[:id])
    render :json => @locale, :status => @locale.destroy ? 200 : 400
  end
end
