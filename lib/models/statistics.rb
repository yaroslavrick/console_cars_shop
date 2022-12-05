# frozen_string_literal: true

module Lib
  module Models
    class Statistics < DataBase
      attr_reader :searches_data, :total_requests

      def load_log(log = LOG_FILE)
        # file = File.open(File.expand_path(log), APPEND_PLUS)
        file = open_file(log, APPEND_PLUS)
        log_arr = YAML.load_file(file) || []
        file.close
        log_arr
      end

      def update(search_rules)
        @searches_data = load_log

        return @searches_data.push(create_data(search_rules)) if @searches_data.empty?

        add_to_searches(search_rules)
      end

      def add_to_searches(search_rules)
        @total_requests = nil
        searches_data.map! do |hash|
          if hash[:rules] == search_rules
            hash[:stats][:requests_quantity] += 1
            @total_requests = hash[:stats][:requests_quantity]
          end
          hash
        end
        searches_data.push(create_data(search_rules)) unless @total_requests
      end

      def total_requests_quantity
        @total_requests || 1
      end

      def create(log = LOG_FILE)
        entry = searches_data.to_yaml.gsub("---\n", '')
        file = File.open(File.expand_path(log), WRITE)
        file.puts(entry)
        file.close
      end

      def create_data(search_rules)
        requests_qty = total_requests || 1
        { rules: search_rules, stats: { requests_quantity: requests_qty } }
      end
    end
  end
end
