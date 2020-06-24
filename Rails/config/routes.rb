Rails.application.routes.draw do
  root 'thin_reports#index'
  post 'thin_reports/output'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
