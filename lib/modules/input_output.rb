module Lib
  module InputOutput
    def show_cars(database)
      database.each do |car|
        car.each do |key, value|
          puts "#{key.capitalize}: #{value}"
        end
        puts
      end
    end

    def show_result(database)
      puts '-' * 15
      puts "\nResults:\n\n"
      if database.empty?
        puts 'None'
      else
        show_cars(database)
      end
      puts '-' * 15
    end

    def exit?
      puts 'Exit? (N/y)'
      %w[y yes].none?(gets.chomp.downcase)
    end
  end
end
