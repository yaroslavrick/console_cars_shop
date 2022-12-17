# frozen_string_literal: true

module Lib
  module Models
    class DataBase
      CURRENT_PATH = File.dirname(__FILE__)
      DATABASE = 'db.yml'
      LOG_FILE = File.join(CURRENT_PATH, '../db/searches.yml').freeze
      DB_FILE = File.read("#{CURRENT_PATH}/../db/db.yml").freeze
      WRITE = 'w'
      APPEND_PLUS = 'a+'

      attr_reader :db_name

      def initialize(db = DATABASE)
        @db_name = db
      end
    end
  end
end
