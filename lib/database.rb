module Lib
  class ::DataBase
    CURRENT_PATH = File.dirname(__FILE__)
    DATABASE = 'db.yml'.freeze
    LOG_FILE = File.join(CURRENT_PATH, '/db/searches.yml').freeze
    APPEND_PLUS = 'a+'.freeze

    attr_reader :db_name

    def initialize(db = DATABASE)
      @db_name = db
    end

    def load
      YAML.safe_load(File.read("#{CURRENT_PATH}/db/#{db_name}"))
    end

    def load_log(log = LOG_FILE)
      file = File.open(File.expand_path(log), APPEND_PLUS)
      log_arr = YAML.load_file(file) || []
      file.close
      log_arr
    end

    def save_log(search_rules, requests_quantity, total_quantity, log = LOG_FILE)
      data = create_data(search_rules, requests_quantity, total_quantity)
      entry = [data].to_yaml.gsub("---\n", '')
      file = File.open(File.expand_path(log), 'a')
      file.puts(entry)
      file.close
    end

    private

    def create_data(search_rules, requests_quantity, total_quantity)
      data = {}
      data[:rules] = search_rules
      data[:stats] = {
        requests_quantity:,
        total_quantity:
      }
      data
    end
  end
end
