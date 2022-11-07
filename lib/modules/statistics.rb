module Statistics
  def total_quantity(db)
    total_quantity = db.count
  end

  def show_statistic(db, requested_quantity)
    puts '-' * 15
    puts 'Statistic:'
    puts "Total Quantity: #{total_quantity(db)}"
    puts "Requests quantity: #{requested_quantity}"
  end

  def compare_requests(current_log_hash, searches_history_arr, _requests_quantity)
    identical = searches_history_arr.count { |request| request[:rules] == current_log_hash[:rules] }
    identical += 1
  end

  def add_statistics(search_rules_hash, db, requests)
    search_rules_hash[:stats][:requests_quantity] = requests
    search_rules_hash[:stats][:total_quantity] = total_quantity(db)
    search_rules_hash
  end
end
