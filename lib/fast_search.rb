module Lib
  class FastSearch

    include Lib::Modules::InputOutput

    attr_reader :search_params, :cars_db

    def initialize
      @cars_db = Lib::Models::DataBase.new
    end
    # If user choose “Fast search” option - he should enter the options they want to
    # search in one string in following format: “attribute1=value, attribute2 =value2”.
    # F.E: “make=tesla; model=x; year=2015”
    # o If input string has incorrect format – the user should see specific message
    # o If some attribute is unexpected, we should see the specific message that
    # consists also the list of expected attributes
    # o If input string has correct format and has expected list of attributes user
    # should see the list of advertisements in a table and should the the Main
    # menu right after that.

    def call
      print_fast_search_example
      ask_search_params
      validate_search_params
    end

    private

    def print_fast_search_example
      puts "F.E: “make=tesla; model=x; year=2015”"
    end

    def ask_search_params
      @search_params = user_input
    end

    def validate_search_params
      arr = []
      params = search_params.split(';')
      params.each do |param|
        splitted_search = param.split('=')
        splitted_search.each_with_object({}) do |value, key|
          key[value] = value
        end
      end
    end

  end
end