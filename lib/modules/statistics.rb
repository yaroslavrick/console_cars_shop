module Statistics
  def total_quantity(db)
    db.count
  end

  def show_statistic(db, requested_quantity)
    puts 'Statistic:'
    puts "Total Quantity: #{total_quantity(db)}"
    puts "Requests quantity: #{requested_quantity}"
    # puts '-' * 15
    puts "#{'-' * 15}\n\n"
  end

  def compare_requests(current_log, searches_history)
    identical = searches_history.count { |request| request[:rules] == current_log[:rules] }
    identical + 1
  end

  def add_statistics(search_rules, db, requests)
    search_rules[:stats][:requests_quantity] = requests
    search_rules[:stats][:total_quantity] = total_quantity(db)
    search_rules
  end
end
