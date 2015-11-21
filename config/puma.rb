workers 1
threads_count = Integer(ENV['MAX_THREADS'] || 8)
threads threads_count, threads_count
 
preload_app!
 
on_worker_boot do
  ActiveRecord::Base.establish_connection
end