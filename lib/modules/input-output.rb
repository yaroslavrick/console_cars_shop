module InputOutput
  def ask_user_input
    puts 'Please select search rules.'
    search_hash = {}
    print_message('Please choose make:')
    search_hash[:make] = get_user_input
    print_message('Please choose model:')
    search_hash[:model] = get_user_input
    print_message('Please choose year_from:')
    search_hash[:year_from] = get_user_input.to_i
    print_message('Please choose year_to:')
    search_hash[:year_to] = get_user_input.to_i
    print_message('Please choose price_from:')
    search_hash[:price_from] = get_user_input.to_i
    print_message('Please choose price_to:')
    search_hash[:price_to] = get_user_input.to_i
    print_message('Please choose sort option (date_added|price):')
    search_hash[:sort_option] = get_user_input
    print_message('Please choose sort direction(desc|asc):')
    search_hash[:sort_direction] = get_user_input
    search_hash
  end

  def print_message(message)
    puts message
  end

  def get_user_input
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
