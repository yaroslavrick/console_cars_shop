module DataBase
  CURRENT_PATH = File.dirname(__FILE__)
  DATABASE = 'db.yml'.freeze

  def load_database(db = DATABASE)
    YAML.safe_load(File.read("#{CURRENT_PATH}/db/#{db}"))
  end
end
