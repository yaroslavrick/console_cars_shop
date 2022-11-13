# frozen_string_literal: true

module SearchEngine
  def keep(option, rules, database)
    return database if rules.strip.empty?

    database.keep_if { |car| car[option].casecmp(rules.strip).zero? }
  end

  def keep_range(option, rule_from, rule_to, database)
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

  def filter_rules(search_rules_hash)
    search_rules_hash.delete_if { |_k, v| ['', 0].include?(v) }
  end

  def sort_by_option(database, sort_option)
    return database.sort_by { |car| car['price'] } if sort_option.casecmp('price').zero?

    database.sort_by { |car| Date.strptime(car['date_added'], '%d/%m/%Y') }
  end

  def sort_by_direction(database, sort_direction)
    return database if sort_direction.casecmp('asc').zero?

    database.reverse
  end
end
