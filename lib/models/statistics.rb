module Lib
  module Models
    class Statistics < DataBase

      attr_reader :searches_data, :total_requests

      def load_log(log = LOG_FILE)
        file = File.open(File.expand_path(log), APPEND_PLUS)
        log_arr = YAML.load_file(file) || []
        file.close
        log_arr
      end

      def update_old(search_rules)
        @searches_data = load_log
        current_search = nil
        searches_data.each { |hash| current_search = hash if hash[:rules] == search_rules }

        if current_search
          current_search[:stats][:requests_quantity] += 1
        else
          create(search_rules)
        end
      end

      def update(search_rules)
        @searches_data = load_log

        data = create_data(search_rules)
        return @searches_data.push(data) if @searches_data.empty?

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

      def create(search_rules, log = LOG_FILE)
        data = searches_data
        entry = data.to_yaml.gsub("---\n", '')
        file = File.open(File.expand_path(log), WRITE)
        file.puts(entry)
        file.close
      end

      def create_data(search_rules)
        requests_quantity = total_requests || 1
         { rules: search_rules, stats: { requests_quantity: requests_quantity } }
      end
    end
  end
end
