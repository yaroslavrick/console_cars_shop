module Lib
  class ::DataBase
    CURRENT_PATH = File.dirname(__FILE__)
    DATABASE = 'db.yml'.freeze
    LOG_FILE = File.join(CURRENT_PATH, '/db/searches.yml').freeze

    attr_reader :db_name

    def initialize(db = DATABASE)
      @db_name = db
    end

    def load
      YAML.safe_load(File.read("#{CURRENT_PATH}/db/#{db_name}"))
    end

    def load_log(log = LOG_FILE)
      file = File.open(File.expand_path(log), 'a+')
      log_arr = YAML.load_file(file) || []
      file.close
      log_arr
    end

    def save_log(search_rules, requests_quantity, total_quantity, log = LOG_FILE)
      data = {
        rules: {
          make: search_rules[:rules][:make],
          model: search_rules[:rules][:model],
          year_from: search_rules[:rules][:year_from],
          year_to: search_rules[:rules][:year_to],
          price_from: search_rules[:rules][:price_from],
          price_to: search_rules[:rules][:price_to],
          sort_option: search_rules[:rules][:sort_option],
          sort_direction: search_rules[:rules][:sort_direction]
        },
        stats: {
          requests_quantity:,
          total_quantity:
        }
      }
      entry = [data].to_yaml.gsub("---\n", '')
      file = File.open(File.expand_path(log), 'a')
      file.puts(entry)
      file.close
    end
  end
end
