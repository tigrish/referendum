task :cron => :environment do
  Rake::Task["proposals:close_expired"].execute
end