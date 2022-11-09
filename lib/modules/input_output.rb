module Lib
  module InputOutput

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
end
