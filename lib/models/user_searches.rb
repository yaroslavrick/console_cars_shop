# frozen_string_literal: true

module Lib
  module Models
    class UserSearches < DataBase
      include Lib::Modules::InputOutput
      include Lib::Modules::Localization
      include Lib::Modules::Colorize
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
        searches_data.find { |car| car[:rules] == search_rules && car[:user] == email }
      end

      def find_total_requests(search_rules)
        match_requests = find(search_rules)
        return match_requests[:stats][:requests_quantity] if match_requests

        1
      end

      def show_searches
        find_user_searches
        print_searches
      end

      def find_user_searches
        @searches_data = load
        find_current_user_data
      end

      def find_current_user_data
        @searches_data.select { |search| search[:user] == email }
      end

      def print_searches
        return puts colorize_error(localize('user_searches.searches_do_not_exist')) if searches_data.empty?

        searches_data.each do |car|
          localize_rows(car[:rules])
          rows = car[:rules].map do |key, value|
            [colorize_main(key.to_s), colorize_result(value.to_s)]
          end
          create_table('results.title', 'results.params', 'results.data', rows)
        end
      end

      def create_table(title_name, first_header, second_header, rows)
        table = Terminal::Table.new(
          title: colorize_title(localize(title_name)),
          headings: [colorize_header(localize(first_header)),
                     colorize_header(localize(second_header))],
          rows: rows
        )
        table.style = TABLE_STYLE
        puts table
      end

      def localize_rows(car)
        car.transform_keys! do |key|
          localize("table.#{key}")
        end
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
  end
end
