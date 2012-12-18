Translator::Application.routes.draw do
  resources :locales do
    match 'import', :on => :collection, :via => [:get, :post]
    post 'import_review', :on => :collection
  end
end
