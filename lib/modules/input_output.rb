module InputOutput
  def int?(value)
    regex = /\A\d*\z/
    value.match(regex) ? true : false
  end

  def read_input
    gets.chomp.downcase
  end

  def check_input(type, input)
    return '' if input.empty?

    case type
    when 'string'
      input
    when 'integer'
      int?(input) ? input.to_i : ''
    else
      ''
    end
  end

  def ask_user_input
    puts 'Please select search rules.'
    puts 'Please choose make: '

    user_input = {}
    user_input['make'] = check_input('string', read_input)

    puts 'Please choose model: '
    user_input['model'] = check_input('string', read_input)

    puts 'Please choose year_from: '
    user_input[:year_from] = check_input('integer', read_input)

    puts 'Please choose year_to: '
    user_input[:year_to] = check_input('integer', read_input)

    puts 'Please choose price_from: '
    user_input[:price_from] = check_input('integer', read_input)

    puts 'Please choose price_to: '
    user_input[:price_to] = check_input('integer', read_input)

    puts 'Please choose sort option (date_added|price): '
    user_input[:sort_by] = check_input('string', read_input)

    puts 'Please choose sort direction(desc|asc): '
    user_input[:sort_direction] = check_input('string', read_input)

    user_input.reject { |_key, value| value.empty? }
  end

  def print_result(result)
    puts 'Results:'
    if result.size.zero?
      puts 'None'
    else
      result.each do |car|
        car.each do |key, value|
          puts "#{key.capitalize}: #{value}"
        end
        puts
      end
    end
  end

  def exit?
    puts 'Exit program? (n/y)'
    user_input = check_input('string', read_input)
    user_input == 'y'
  end
end
