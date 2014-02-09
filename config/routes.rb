Stepup::Application.routes.draw do

  namespace 'api' do
    get 'events' => 'events#index'
  end
  
end
