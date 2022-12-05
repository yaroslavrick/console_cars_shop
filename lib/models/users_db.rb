# frozen_string_literal: true

module Lib
  module Models
    class UsersDb < DataBase
      USERS_LOGINS_AND_PASSWORDS_FILE = File.join(CURRENT_PATH, '../db/users.yml').freeze
      LOG_IN_DATA_FILE = File.join(CURRENT_PATH, '../db/users.yml').freeze
      # CURRENT_DIR = File.dirname(__FILE__)

      def load
        YAML.safe_load(File.read("#{CURRENT_PATH}/../db/#{db_name}"))
      end

      def load_logins_and_passwords(auth_data_file = USERS_LOGINS_AND_PASSWORDS_FILE)
        file = File.open(File.expand_path(auth_data_file), APPEND_PLUS)
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
    end
  end
end
# BCrypt::Password.create(

# def load_logins_and_passwords(_auth_data_file = USERS_LOGINS_AND_PASSWORDS_FILE)
#   file = File.join(CURRENT_PATH, './db/users.yml')
#   auth_arr = YAML.load_file(file) || []
#   file.close
#   auth_arr
# end
