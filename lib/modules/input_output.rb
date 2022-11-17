module Lib
  module Modules
    module InputOutput
      def print_message(message)
        puts message
      end

      def user_input
        gets.chomp.strip
      end

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
        %w[y yes].include?(gets.chomp.downcase)
      end
    end
  end
end
