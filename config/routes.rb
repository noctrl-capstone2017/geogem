Rails.application.routes.draw do

  root    'login_session#new'

  # login, logout, and static pages 
  get     'login',            to: 'login_session#new'
  post    'login',            to: 'login_session#create'
  get     'logout',           to: 'login_session#logout'
  get     'about',            to: 'static_pages#about'
  get     'about_student_art',  to: 'static_pages#about_student_art'
  get     'help',             to: 'static_pages#help'

  # core teacher pages: home, profile, password 
  get     'home',             to: 'teachers#home'
  get     'profile',          to: 'teachers#profile'
  patch   'profile',          to: 'teachers#change_profile'
  get     'password',         to: 'teachers#password'
  patch   'password',         to: 'teachers#change_password'

  # admin routes
  get     'admin',            to: 'teachers#admin'
  get     'admin_report',     to: 'teachers#admin_report'



  # super and school routes for super user only
  get     '/super',           to: 'teachers#super'
  patch   '/super',           to: 'teachers#update_super_focus'
  get     '/super_report',    to: 'teachers#super_report'

  get     '/school_backup',   to: 'schools#backup'
  patch   '/school_backup',  to: 'schools#do_backup'
  get     '/school_suspend',  to: 'schools#suspend'  
  patch   '/school_suspend',  to: 'schools#do_suspend'
  get     '/school_restore',  to: 'schools#restore'
  patch   '/school_restore',  to: 'schools#do_restore'


  #route to create and delete session events during the session
  post    '/session_events',  to: 'session_events#create'
  post    '/session_events/undo',  to: 'session_events#undo'
  
  #route to pdf from session page
  post    '/report1',  to: 'reports#report1'
  
  #route to end session page
  post    'sessions/:id/end_session', to: 'sessions#end_session', as: :end_session

  # get   'teachers/:id/edit2',  to: 'teachers#edit2'
  # patch 'teachers/:id/edit2',  to: 'teachers#update2'

  # REST-ful resources
  resources :roster_students
  resources :roster_squares
  resources :session_notes 
  resources :squares
  resources :schools
  resources :teachers do
    member do
      get :edit2, :edit3
    end
  end

  #allow for custom controller function
  resources :sessions do
    member do
      get :end_session
    end
  end




##########
# Bill - issues below this line, also fix only issues in resources above
##########

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

#  get     'static_pages/help'
  get     '/csv1',            to: 'reports#csv1'

  #Carolyn C routes for analysis
  get 'student/:id/analysis2', to: 'students#analysis', as: :analysis2
  get 'student/:id/analysis3', to: 'students#analysis', as: :analysis3
  get 'student/:id/analysis4', to: 'students#analysis', as: :analysis4
  
  get     'notes',            to: 'session_notes#index'
  
  get     'graph/main'
  get     'graph/example'
  get     'graph/random'
  get     'graph/todo'
  get     'graph/other'
end
