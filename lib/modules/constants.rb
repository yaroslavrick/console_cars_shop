# frozen_string_literal: true

module Lib
  module Modules
    module Constants
      module ReadWriteType
        WRITE = 'w'
        APPEND_PLUS = 'a+'
        APPEND = 'a'
      end

      module FilePaths
        CURRENT_PATH = File.dirname(__FILE__)
        DATABASE = File.join(CURRENT_PATH, '../db/db.yml').freeze
        LOG_FILE = File.join(CURRENT_PATH, '../db/searches.yml').freeze
        USERS_LOGINS_AND_PASSWORDS_FILE = File.join(CURRENT_PATH, '../db/users.yml').freeze
        USER_SEARCHES_FILE = File.join(CURRENT_PATH, '../db/user_searches.yml').freeze
      end
    end
  end
end
