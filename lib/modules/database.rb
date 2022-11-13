# frozen_string_literal: true

module DataBase
  CURRENT_PATH = File.dirname(__FILE__)
  DATABASE = 'db.yml'
  LOG_FILE = File.join(CURRENT_PATH, '/../db/searches.yml').freeze

  def load_database(db = DATABASE)
    YAML.safe_load(File.read("#{CURRENT_PATH}/../db/#{db}"))
  end

  def load_log(log = LOG_FILE)
    file = File.open(File.expand_path(log), 'a+')
    log_arr = YAML.load_file(file) || []
    file.close
    log_arr
  end

  def save_log(search_rules_hash, requests_quantity, total_quantity, log = LOG_FILE)
    data = {
      rules: {
        make: search_rules_hash[:rules][:make],
        model: search_rules_hash[:rules][:model],
        year_from: search_rules_hash[:rules][:year_from],
        year_to: search_rules_hash[:rules][:year_to],
        price_from: search_rules_hash[:rules][:price_from],
        price_to: search_rules_hash[:rules][:price_to],
        sort_option: search_rules_hash[:rules][:sort_option],
        sort_direction: search_rules_hash[:rules][:sort_direction]
      },
      stats: {
        requests_quantity: requests_quantity,
        total_quantity: total_quantity
      }
    }
    entry = [data].to_yaml.gsub("---\n", '')
    file = File.open(File.expand_path(log), 'a')
    file.puts(entry)
    file.close
  end
end
