# frozen_string_literal: true

module Lib
  module Models
    class UserSearches < DataBase
      include Lib::Modules::InputOutput
      include Lib::Modules::Colorize
      attr_reader :data, :search_rules, :email, :searches_history, :searches_data, :printer

      def initialize(email:)
        @email = email
        @printer = Lib::PrintData.new
      end

      def update(rules:)
        @search_rules = rules
        @searches_data = load(USER_SEARCHES_FILE)
        if find_by_email(search_rules,
                         searches_data)
          increase_quantity(search_rules)
        else
          initialize_search_data(search_rules)
        end
        save(searches_data, WRITE, USER_SEARCHES_FILE)
      end

      def show_searches
        find_user_searches
        print_searches
      end

      def find_user_searches
        @searches_data = load(USER_SEARCHES_FILE)
        find_current_user_data
      end

      def find_current_user_data
        @searches_data.select! { |search| search[:user] == email }
      end

      def print_searches
        return puts colorize_text('error', localize('user_searches.searches_do_not_exist')) if searches_data.empty?

        print_searches_result
      end

      def print_searches_result
        searches_data.each do |car|
          localize_rows(car[:rules])
          rows = car[:rules].map do |key, value|
            [colorize_text('main', key.to_s), colorize_text('result', value.to_s)]
          end
          printer.create_table('results.title', 'results.params', 'results.data', rows)
        end
      end

      def localize_rows(car)
        car.transform_keys! do |key|
          localize("table.#{key}")
        end
      end

      private

      def find_by_email(search_rules, searches_data)
        searches_data.find { |request| request[:rules] == search_rules && request[:user] == email }
      end

      def initialize_search_data(search_rules)
        searches_data.push({ rules: search_rules, stats: { requests_quantity: 1 }, user: email })
      end
    end
  end
end
