# frozen_string_literal: true

module Lib
  module Models
    class UsersDb < DataBase
      def load
        YAML.unsafe_load(File.read("#{CURRENT_PATH}/../db/#{db_name}"))
      end

      def load_logins_and_passwords(auth_data_file = USERS_LOGINS_AND_PASSWORDS_FILE)
        file = open_file(auth_data_file, APPEND_PLUS)
        auth_arr = YAML.unsafe_load(file) || []
        file.close
        auth_arr
      end

      def add_new_user(login_data, login_file = USERS_LOGINS_AND_PASSWORDS_FILE)
        file = open_file(login_file, APPEND)
        entry = [login_data].to_yaml.gsub("---\n", '')
        file.puts(entry)
        file.close
      end
    end
  end
end
