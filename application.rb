# encoding: utf-8
require 'bundler'
Bundler.require

Dir["helpers/*.rb"].each do |file| 
  require_relative file
end

database_credentials = db_yaml[ENV["RACK_ENV"]]
Sequel.connect(database_credentials)

%w{app/** routes}.each do |dir|
  Dir["#{dir}/*.rb"].each do |file| 
    require_relative file
  end
end


class FrogLakeRidesApplication < Sinatra::Application
  get '/*' do
    MultiJson.dump({response: 'You will find no path there.'})
  end

  post '/*' do
    MultiJson.dump({response: 'You will find no path there.'})
  end
end



