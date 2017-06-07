Rails.application.routes.draw do

  # Cleaned up by: Michael Loptien

  root    'login_session#new'
  get     '/home' ,           to: 'teachers#home'
  get     'static_pages/help'
  
  get     '/csv1',            to: 'reports#csv1'


  # Super, admin, and schools routes
  # Author: Robert Herrera
  get     '/admin_report',    to: 'teachers#admin_report' 
  get     '/super_report',    to: 'teachers#super_report'
  get     '/admin',           to: 'teachers#admin'
  get     '/super',           to: 'schools#super'
  post    '/super',           to: 'teachers#updateFocus',    as: :updateFocus
  get     '/school_backup',   to: 'schools#backup'
  get     '/school_suspend',  to: 'schools#suspend'  
  post    '/school_suspend',  to: 'schools#suspend',         as: :suspend
  get     '/school_restore',  to: 'schools#restore'

  # Teacher routes
  # Author: Kevin M and Tommy B
  # to disguise teachers/id/edit_password as just /password
  get     '/password',                    to: 'teachers#edit_password'
  patch 'teachers/:id/change_password',   to: 'teachers#change_password'
  get     'teachers/:id/login_settings',  to: 'teachers#login_settings'

  # Login Session Controller Routing 
  # Author: Meagan Moore & Steven Royster
  get     'login',            to: 'login_session#new'
  post    'login',            to: 'login_session#create'
  get     'logout',           to: 'login_session#logout'
  get     'about',            to: 'static_pages#about1'
  get     'about2',           to: 'static_pages#about2'

  get     'help',             to: 'static_pages#help'
  get     'notes',            to: 'session_notes#index'

  get     'graph/main'
  get     'graph/example'
  get     'graph/random'
  get     'graph/todo'
  get     'graph/other'
  
  #route to create and delete session events during the session
  post    '/session_events',  to: 'session_events#create'
  post    '/session_events/undo',  to: 'session_events#undo'
  
  #route to pdf from session page
  post    '/report1',  to: 'reports#report1'
  
  #route to end session page
  post    'sessions/:id/end_session', to: 'sessions#end_session', as: :end_session
  
  #utilized http://stackoverflow.com/questions/25490308/
  #             ruby-on-rails-two-different-edit-pages-and-forms-how-to for help
  resources :teachers do
    member do
      get :edit_password
    end
  end
  
  #allow for custom controller function
  resources :sessions do
    member do
      get :end_session
    end
  end
  
  #Carolyn C - send student to analysis page
  resources :students do
    member do
      get :analysis
      get :analysis2
      get :analysis3
      get :analysis4
      get :report1
    end
  end
  
  #Carolyn C routes for analysis
  get 'student/:id/analysis2', to: 'students#analysis', as: :analysis2
  get 'student/:id/analysis3', to: 'students#analysis', as: :analysis3
  get 'student/:id/analysis4', to: 'students#analysis', as: :analysis4
  
  resources :roster_students
  resources :roster_squares
  resources :session_notes 
  resources :squares
  resources :schools
end
