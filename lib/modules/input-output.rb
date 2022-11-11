require 'i18n'
module InputOutput
  def ask_user_input
    # puts 'Please select search rules.'.cyan
    puts I18n.t(:select_search_rules).cyan
    search_hash = {
      rules: {},
      stats: {}
    }
    print_message('Please choose make:')
    search_hash[:rules][:make] = get_user_input
    print_message('Please choose model:')
    search_hash[:rules][:model] = get_user_input
    print_message('Please choose year_from:')
    search_hash[:rules][:year_from] = get_user_input.to_i
    print_message('Please choose year_to:')
    search_hash[:rules][:year_to] = get_user_input.to_i
    print_message('Please choose price_from:')
    search_hash[:rules][:price_from] = get_user_input.to_i
    print_message('Please choose price_to:')
    search_hash[:rules][:price_to] = get_user_input.to_i
    print_message('Please choose sort option (date_added|price):')
    search_hash[:rules][:sort_option] = get_user_input
    print_message('Please choose sort direction(desc|asc):')
    search_hash[:rules][:sort_direction] = get_user_input
    search_hash
  end

  def print_message(message)
    puts message.light_blue
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

  def show_prettified_result(database)
    rows = database.map do |car|
      car.map do |key, value|
        [key.to_s.light_blue, value.to_s.magenta]
      end
    end.flatten(1)
    table = Terminal::Table.new title: 'Results:'.light_yellow, headings: ['params:'.cyan, 'data:'.cyan], rows: rows
    table.style = { all_separators: true, padding_left: 2, padding_right: 2, border: :unicode_thick_edge }
    puts table
  end

  def exit?
    puts 'Exit? (N/y)'.cyan
    %w[y yes].none?(gets.chomp.downcase)
  end
end
