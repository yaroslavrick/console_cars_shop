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

      def find(search_rules)
        searches_data.find { |car| car[:rules] == search_rules }
      end

      def find_total_requests(search_rules)
        match_requests = find(search_rules)
        return match_requests[:stats][:requests_quantity] if match_requests

        1
      end

      private

      def increase_quantity(search_rules)
        searches_data.map! do |data|
          data[:stats][:requests_quantity] += 1 if data[:rules] == search_rules
          data
        end
      end

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
