# frozen_string_literal: true

module Lib
  module Models
    class Statistics < DataBase
      attr_reader :searches_data, :total_requests

      def update(search_rules)
        @searches_data = load(LOG_FILE)
        find(search_rules, searches_data) ? increase_quantity(search_rules) : initialize_search_data(search_rules)
        save(searches_data, WRITE, LOG_FILE)
      end

      private

      def initialize_search_data(search_rules)
        searches_data.push({ rules: search_rules, stats: { requests_quantity: 1 } })
      end
    end
  end
end
