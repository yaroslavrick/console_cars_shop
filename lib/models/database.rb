# frozen_string_literal: true

module Lib
  module Models
    class DataBase
      CURRENT_PATH = File.dirname(__FILE__)
      DATABASE = 'db.yml'
      LOG_FILE = File.join(CURRENT_PATH, '../db/searches.yml').freeze
      USERS_LOGINS_AND_PASSWORDS_FILE = File.join(CURRENT_PATH, '../db/users.yml').freeze
      DB_FILE = File.read("#{CURRENT_PATH}/../db/db.yml").freeze
      WRITE = 'w'
      APPEND_PLUS = 'a+'
      APPEND = 'a'

      attr_reader :db_name

      def initialize(db = DATABASE)
        @db_name = db
      end

      private

      def open_file(file, flag)
        File.open(File.expand_path(file), flag)
      end
    end
  end
end
