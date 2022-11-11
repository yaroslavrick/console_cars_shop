module Statistics
  def total_quantity(db)
    total_quantity = db.count
  end
  
  def show_prettified_statistic(db, requested_quantity)
    rows = [[I18n.t('statistics.total_quantity').light_blue, total_quantity(db).to_s.magenta],
            [I18n.t('statistics.requests_quantity').light_blue, requested_quantity.to_s.magenta]]
    table = Terminal::Table.new title: I18n.t('statistics.statistic').light_yellow,
                                headings: [I18n.t('statistics.title').cyan, I18n.t('statistics.number').cyan], rows: rows
    table.style = { all_separators: true, padding_left: 2, padding_right: 2, border: :unicode_thick_edge }
    puts table
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
