namespace :proposals do
  desc 'Closes all open proposals that have expired'
  task :close_expired => :environment do
    Proposal.state(:open).expired.each { |proposal| proposal.close! }
  end
end