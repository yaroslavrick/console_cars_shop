# frozen_string_literal: true

module Lib
  module Models
    class Statistics < DataBase
      attr_reader :searches_data, :total_requests

      def load(log = LOG_FILE)
        YAML.load_file(log) || []
      end

      def update(search_rules)
        @searches_data = load
        find(search_rules) ? increase_quantity(search_rules) : initialize_search_data(search_rules)
        save
      end

      private

      def initialize_search_data(search_rules)
        searches_data.push({ rules: search_rules, stats: { requests_quantity: 1 } })
      end

      def save(log = LOG_FILE)
        entry = searches_data.to_yaml.gsub("---\n", '')
        file = File.open(File.expand_path(log), WRITE)
        file.puts(entry)
        file.close
      end
    end
  end
end
