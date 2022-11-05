module InputOutput
  def ask_user_input
    puts 'Please select search rules.'
    search_hash = {}
    search_hash[:make] = print_message('Please choose make:')
    search_hash[:model] = print_message('Please choose model:')
    search_hash[:year_from] = print_message('Please choose year_from:').to_i
    search_hash[:year_to] = print_message('Please choose year_to:').to_i
    search_hash[:price_from] = print_message('Please choose price_from:').to_i
    search_hash[:price_to] = print_message('Please choose price_to:').to_i
    search_hash[:sort_option] = print_message('Please choose sort option (date_added|price):')
    search_hash[:sort_direction] = print_message('Please choose sort direction(desc|asc):')
    search_hash
  end

  def print_message(message)
    puts message
    gets.chomp
  end

  def show_result(database)
    puts '-' * 15
    puts
    puts 'Results:'
    puts
    if database.empty?
      puts 'None'
    else
      database.each do |car|
        car.each do |key, value|
          puts "#{key.capitalize}: #{value}"
        end
        puts
      end
    end
    puts '-' * 15
  end

  def exit?
    puts 'Exit? (N/y)'
    %w[y yes].none?(gets.chomp.downcase)
  end
end
