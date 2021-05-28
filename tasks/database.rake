require 'yaml'
require 'sequel'

Dir["helpers/*.rb"].each do |file| 
  load file
end

namespace :db do
  task yaml: :environment do
    puts "#{ENV["RACK_ENV"]} => #{db_yaml[ENV["RACK_ENV"]]}"
  end

	task create: :environment do
    puts "DB [created], and [droped] if exists.[#{ENV["RACK_ENV"]}]"
    database_credentials = db_yaml[ENV["RACK_ENV"]]
    Sequel.connect(database_credentials.merge('database' => 'postgres')) do |db|
      db.execute "DROP DATABASE IF EXISTS #{database_credentials['database']}"
      db.execute "CREATE DATABASE #{database_credentials['database']}"
    end
	end

  task migrate: :environment do
    puts "Migrations.[#{ENV["RACK_ENV"]}]"
    database_credentials = db_yaml[ENV["RACK_ENV"]]
    DB = Sequel.connect(database_credentials)
    Dir["db/*.rb"].each do |file| 
      load file
    end
  end

  task seed: :environment do
    puts "DB [seeeded].[#{ENV["RACK_ENV"]}]"
    database_credentials = db_yaml[ENV["RACK_ENV"]]
    DB = Sequel.connect(database_credentials)
    Dir["./app/models/*.rb"].each do |file| 
      require file
    end
    Rider.find_or_create(email: "manchagd@example.com")
    Driver.create
    Driver.create
  end
end
