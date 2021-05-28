task :environment do |cmd, args|
  ENV["RACK_ENV"] = args[:env] || "development"
end