Rails.application.routes.draw do

  root    'login_session#new'

  # login, logout, and static pages 
  get     'login',            to: 'login_session#new'
  post    'login',            to: 'login_session#create'
  get     'logout',           to: 'login_session#logout'
  get     'about',            to: 'static_pages#about'
  get   'about_student_art',  to: 'static_pages#about_student_art'
  get     'help',             to: 'static_pages#help'

  # core teacher pages: home, profile, password 
  get     'home',             to: 'teachers#home'
  patch   'home',             to: 'teachers#update_home'
  get     'profile',          to: 'teachers#profile'
  get     'properties',       to: 'teachers#properties'
  patch   'properties',       to: 'teachers#update_properties'
  get     'password',         to: 'teachers#password'
  patch   'password',         to: 'teachers#update_password'

  # admin routes
  get     'admin',            to: 'teachers#admin'
  get     'admin_report',     to: 'teachers#admin_report'

  # super and school routes for super user only
  get     '/super',           to: 'teachers#super'
  patch   '/super',           to: 'teachers#update_super_focus'
  get     '/super_report',    to: 'teachers#super_report'

  get     '/backup_school',   to: 'schools#backup'
  patch   '/backup_school',  to: 'schools#do_backup'
  get     '/suspend_school',  to: 'schools#suspend'  
  patch   '/suspend_school',  to: 'schools#do_suspend'
  get     '/restore_school',  to: 'schools#restore'
  patch   '/restore_school',  to: 'schools#do_restore'

  # REST-ful resources
  resources :roster_students
  resources :roster_squares
  resources :session_notes 
  resources :squares
  resources :schools, except: [:show, :destroy]
  resources :teachers do
    member do
      get :edit2, :edit3
    end
  end

  resources :students do
    member do
      get :edit2
    end
  end

  resources :sessions do
    member do
      get :end_session
    end
  end

  # session-related routes
  post    '/session_events',  to: 'session_events#create'
  post    '/session_events/undo',  to: 'session_events#undo'
  post    'sessions/:id/end_session', to: 'sessions#end_session', as: :end_session

  # routes for student analysis pages: report, export, graph
  get   'students/:id/analysis',          to: 'students#analysis',          as: :analysis
  get   'students/:id/analysis_emerald',  to: 'students#analysis_emerald',  as: :analysis_emerald
  get   'students/:id/analysis_ruby',     to: 'students#analysis_ruby',     as: :analysis_ruby
  get   'students/:id/emerald_export',    to: 'students#emerald_export',    as: :emerald_export

end
