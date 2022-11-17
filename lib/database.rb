module Lib
  class ::DataBase
    CURRENT_PATH = File.dirname(__FILE__)
    DATABASE = 'db.yml'.freeze

    attr_reader :db_name

    def initialize(db = DATABASE)
      @db_name = db
    end

    def load_database
      YAML.safe_load(File.read("#{CURRENT_PATH}/db/#{db_name}"))
    end
  end
end
