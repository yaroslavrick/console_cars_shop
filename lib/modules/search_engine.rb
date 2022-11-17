module Lib
  module Modules
    module SearchEngine
      def search_by_model_and_make(option, rules, database)
        return database if rules.empty?

        database.keep_if { |car| car[option].casecmp(rules.strip).zero? }
      end

      def search_by_range(option, rule_from, rule_to, database)
        return database if rule_from.zero? && rule_to.zero?

        if rule_from.zero?
          database.keep_if { |car| car[option] <= rule_to }
        elsif rule_to.zero?
          database.keep_if { |car| car[option] >= rule_from }
        else
          database.keep_if { |car| car[option] >= rule_from && car[option] <= rule_to }
        end

        database
      end

      def search_data(database, search_rules)
        database = search_by_model_and_make('make', search_rules[:make], database)
        database = search_by_model_and_make('model', search_rules[:model], database)
        database = search_by_range('year', search_rules[:year_from].to_i, search_rules[:year_to].to_i, database)
        search_by_range('price', search_rules[:price_from].to_i, search_rules[:price_to].to_i, database)
      end

      def sort_by_option(database, sort_option)
        return database.sort_by { |car| car['price'] } if sort_option.casecmp('price').zero?

        database.sort_by { |car| Date.strptime(car['date_added'], '%d/%m/%Y') }
      end

      def sort_by_direction(database, sort_direction)
        return database if sort_direction.casecmp('asc').zero?

        database.reverse
      end

      def sort(database, sort_option, sort_direction)
        database = sort_by_option(database, sort_option)
        sort_by_direction(database, sort_direction)
      end
    end
  end
end
