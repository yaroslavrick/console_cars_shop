module Lib
  module Models
      # “My Searches” option - he should see all the searches made by him
      # before if such searches exists or some message when the searches do not exist.
      # He should see the main menu right after that.
    class UserSearches < DataBase
      attr_reader :data, :search_rules, :email, :searches_history, :searches_data

      def initialize(email:)
        @email = email
      end

      def update(rules:)
        @search_rules = rules
        @searches_data = load
        find(search_rules) ? increase_quantity(search_rules) : initialize_search_data(search_rules)
        save
      end

      def load(user_searches_db = USER_SEARCHES_FILE)
        YAML.load_file(user_searches_db) || []
      end

      def find(search_rules)
        searches_data.find { |car| car[:rules] == search_rules && car[:user] == email}
      end

      def find_total_requests(search_rules)
        match_requests = find(search_rules)
        return match_requests[:stats][:requests_quantity] if match_requests

        1
      end

      def show_searches
        find_user_searches
        print_message
      end

      def find_user_searches
        @searches_data = load
        find_current_user_data
      end

      def find_current_user_data
        @searches_data.select { |search| search[:user] == email }
      end

      def print_message
        binding.pry
        if searches_data
          print_searches
        else
          puts "The searches do not exist"
        end
      end

      def print_searches
        p searches_data
      end

      private

      def save(log = USER_SEARCHES_FILE)
        entry = searches_data.to_yaml.gsub("---\n", '')
        file = File.open(File.expand_path(log), WRITE)
        file.puts(entry)
        file.close
      end

      def increase_quantity(search_rules)
        searches_data.map! do |data|
          data[:stats][:requests_quantity] += 1 if data[:rules] == search_rules
          data
        end
      end

      def initialize_search_data(search_rules)
        searches_data.push({ rules: search_rules, stats: { requests_quantity: 1 }, user: email })
      end
    end




      # # def save
      # #   create_data
      # #   find_user_searches

      # #   if @result
      # #     save_data
      # #   else

      # #   end
      # # end

      # def create_data
      #   @data = { user: email, rules: search_rules }
      # end

      # def compare_data
      #
      # end

      # def save_data
      #   entry = [@data].to_yaml.gsub("---\n", '')
      #   file = File.open(File.expand_path(USER_SEARCHES_FILE), WRITE)
      #   file.puts(entry)
      #   file.close
      # end
  end
end