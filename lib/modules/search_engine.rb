module SearchEngine
  def keep(option, rules, database)
    return database if rules.strip.empty?

    database.keep_if { |car| car[option].downcase == rules.strip.downcase }
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
    return database.sort_by { |car| car['price'] } if sort_option.downcase == 'price'

    return database.sort_by { |car| car['date_added'] }

    database
  end

  def sort_by_direction(database, sort_direction)
    return database if sort_direction.downcase == 'asc'

    database.reverse
  end
end
