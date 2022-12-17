# frozen_string_literal: true

module Lib
  module Models
    class DataBase
      include Lib::Modules::Constants::ReadWriteType
      include Lib::Modules::Constants::FilePaths

      attr_reader :db_name

      def initialize(db = DATABASE)
        @db_name = db
      end

      def find(search_rules, searches_data)
        searches_data.find { |car| car[:rules] == search_rules }
      end

      def find_total_requests(search_rules)
        all_users_searches_data = load(LOG_FILE)
        match_requests = find(search_rules, all_users_searches_data)
        return match_requests[:stats][:requests_quantity] if match_requests

        1
      end

      def increase_quantity(search_rules)
        searches_data.map! do |data|
          data[:stats][:requests_quantity] += 1 if data[:rules] == search_rules
          data
        end
      end

      def save(data, write_type, filepath)
        entry = data.to_yaml.gsub("---\n", '')
        file = open_file(filepath, write_type)
        file.puts(entry)
        file.close
      end

      def load(filepath = DATABASE)
        YAML.load_file(filepath) || []
      end

      private

      def open_file(file, flag)
        File.open(File.expand_path(file), flag)
      end
    end
  end
end
