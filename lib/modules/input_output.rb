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

      def ask_field(rule)
        puts "Please choose #{rule}:"
        user_input.downcase
      end

      def show_result(database)
        puts "#{'-' * 15}\n\nResults:\n\n"
        database.empty? ? puts('None') : show_cars(database)
        puts '-' * 15
      end

      def exit?
        puts "\nExit? (N/y)"
        %w[y yes].include?(gets.chomp.downcase)
      end
    end
  end
end
