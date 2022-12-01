# frozen_string_literal: true
gem 'bcrypt'
module Lib
  class DataBase
    CURRENT_PATH = File.dirname(__FILE__)
    # CURRENT_DIR = File.dirname(__FILE__)
    DATABASE = 'db.yml'
    LOG_FILE = File.join(CURRENT_PATH, '/db/searches.yml').freeze
    APPEND_PLUS = 'a+'
    APPEND = 'a'
    USERS_LOGINS_AND_PASSWORDS_FILE = File.join(CURRENT_PATH, '/db/users.yml').freeze
    LOG_IN_DATA_FILE = File.join(CURRENT_PATH, 'db/users.yml').freeze

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
      file = File.open(File.expand_path(log), APPEND)
      file.puts(entry)
      file.close
    end

    # def load_logins_and_passwords(auth_data_file = USERS_LOGINS_AND_PASSWORDS_FILE)
    #   file = File.open(File.expand_path(auth_data_file), APPEND_PLUS)
    #   auth_arr = YAML.load_file(file) || []
    #   file.close
    #   auth_arr
    # end

    def load_logins_and_passwords(_auth_data_file = USERS_LOGINS_AND_PASSWORDS_FILE)
      file = File.join(CURRENT_PATH, './db/users.yml')
      auth_arr = YAML.load_file(file) || []
      file.close
      auth_arr
    end

    def add_new_user(login_data, login_file = LOG_IN_DATA_FILE)
      file = File.open(File.expand_path(login_file), APPEND)
      # encrypted_password = BCrypt::Password.create(login_data[:password])
      # login_data[:password] = encrypted_password
      entry = [login_data].to_yaml.gsub("---\n", '')
      file.puts(entry)
      file.close
    end

    private

    def create_data(search_rules, requests_quantity, total_quantity)
      data = {}
      data[:rules] = search_rules
      data[:stats] = {
        requests_quantity: requests_quantity,
        total_quantity: total_quantity
      }
      data
    end
  end
end
# BCrypt::Password.create(
