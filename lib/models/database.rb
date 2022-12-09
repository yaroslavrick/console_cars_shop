module Lib
  module Models
    class DataBase
      CURRENT_PATH = File.dirname(__FILE__)
      DATABASE = 'db.yml'.freeze
      LOG_FILE = File.join(CURRENT_PATH, '../db/searches.yml').freeze
      # DB_FILE = File.read("#{CURRENT_PATH}/../db/#{db_name}").freeze
      DB_FILE = File.read("#{CURRENT_PATH}/../db/db.yml").freeze
      WRITE = 'w'.freeze
      APPEND_PLUS = 'a+'.freeze

      attr_reader :db_name

      def initialize(db = DATABASE)
        @db_name = db
      end
    end
  end
end
