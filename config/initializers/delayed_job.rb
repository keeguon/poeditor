Delayed::Job.class_eval do
  establish_connection ActiveRecord::Base.configurations["mysql_#{Rails.env}"]
end