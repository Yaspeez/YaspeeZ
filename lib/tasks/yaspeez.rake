namespace :yaspeez do
  desc "Setup YaspeeZ environment"
  task setup: :environment do
    puts "YaspeeZ environment setup started..."
    Rake::Task["cities:import"].invoke
    Rake::Task["sports:import"].invoke
    puts "YaspeeZ environment setup done."
  end
end
