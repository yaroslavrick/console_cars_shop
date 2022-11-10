module Lib
  module SearchEngine
    def keep(option, rules, database)
      # return database if rules.strip.empty?
      return database if validation_for_emptiness?(rules)

      database.keep_if { |car| car[option].downcase == rules.strip.downcase }
    end

    def keep_range(option, rule_from, rule_to, database)
      # return database if rule_from.zero? && rule_to.zero?
      return database if validation_for_both_zero_values?(rule_from, rule_to)

      if rule_from.zero?
        database.keep_if { |car| car[option] <= rule_to }
      elsif rule_to.zero?
        database.keep_if { |car| car[option] >= rule_from }
      else
        database.keep_if { |car| car[option] >= rule_from && car[option] <= rule_to }
      end

      database
    end

    def filter_data(database, search_rules)
      database = keep('make', search_rules[:make], database)
      database = keep('model', search_rules[:model], database)
      database = keep_range('year', search_rules[:year_from].to_i, search_rules[:year_to].to_i, database)
      keep_range('price', search_rules[:price_from].to_i, search_rules[:price_to].to_i, database)
    end

    def sort_by_option(database, sort_option)
      return database.sort_by { |car| car['price'] } if sort_option.downcase == 'price'

      database.sort_by { |car| Date.strptime(car['date_added'], '%d/%m/%Y') }
    end

    def sort_by_direction(database, sort_direction)
      return database if sort_direction.downcase == 'asc'

      database.reverse
    end

    def sort(database, sort_option, sort_direction)
      database = sort_by_option(database, sort_option)
      sort_by_direction(database, sort_direction)
    end
  end
end
