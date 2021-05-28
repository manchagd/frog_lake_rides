def db_yaml
  YAML.load_file("./config/database.yml")
end

def secrets
  YAML.load_file("./secrets.yml")
end