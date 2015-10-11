# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
get 'mailer_log', :to => 'mailer#index'
get 'mailer_log/delete_all', :to => 'mailer#delete_all_mail_logs', :as => 'delete_all_mail_logs'
