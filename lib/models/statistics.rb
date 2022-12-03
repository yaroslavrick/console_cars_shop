module Lib
  module Models
    class Statistics < DataBase

      attr_reader :searches_data

      def load_log(log = LOG_FILE)
        file = File.open(File.expand_path(log), APPEND_PLUS)
        log_arr = YAML.load_file(file) || []
        file.close
        log_arr
      end

      # params => search_rules
      def update(search_rules)
        # searches_data - это масссив со statistics.yml
        @searches_data = load_log
        current_search = nil
        searches_data.each { |hash| current_search = hash if hash[:rules] == search_rules }
        binding.pry
        if current_search
          current_search[:stats][:requests_quantity] += 1
        else
          create(search_rules)
        end
        binding.pry
      end

      def create(params)
        # todo
        # save_log and create_data methods must be here as one
        # REWRITE data: чтобы записывало всю searches_data, но изменить в ней тот же параметр
        binding.pry
        data = searches_data
        entry = [data].to_yaml.gsub("---\n", '')
        file = File.open(File.expand_path(log), 'a+')
        file.puts(entry)
        file.close
      end

      def save_log(search_rules, requests_quantity, total_quantity, log = LOG_FILE)
        data = create_data(search_rules, requests_quantity, total_quantity)
        entry = [data].to_yaml.gsub("---\n", '')
        file = File.open(File.expand_path(log), 'a')
        file.puts(entry)
        file.close
      end

      # def create_data(search_rules, requests_quantity, total_quantity)
      #   { rules: search_rules, stats: { requests_quantity: requests_quantity, total_quantity: total_quantity } }
      # end
    end
  end
end
