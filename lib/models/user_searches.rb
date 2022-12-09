module Lib
  class UserSearches
    WRITE = 'w'.freeze
    CURRENT_PATH = File.dirname(__FILE__)
    USER_SEARCHES_FILE = File.join(CURRENT_PATH, 'db/user_searches.yml').freeze

    attr_reader :data, :search_rules, :email

    def initialize(email, search_rules = '')
      @email = email
      @search_rules = search_rules
    end

    def load(user_searches_db = USER_SEARCHES_FILE)
      YAML.load_file(user_searches_db ) || []
    end

    def call
      find_user_searches
      print_message
    end

    def save
      create_data
      find_user_searches 
      save_data
    end

    def create_data
      @data = { user: email, rules: search_rules }
    end

    def compare_data
      # todo
    end

    def save_data
      entry = [@data].to_yaml.gsub("---\n", '')
      file = File.open(File.expand_path(USER_SEARCHES_FILE), WRITE)
      file.puts(entry)
      file.close
    end

    private

    def find_user_searches
      @searches = load
      @result = @searches.find { |search| email == search[:user] }
    end

    def print_message
      if @result
        print_searches
      else
        puts "The searches do not exist"
      end
    end

    def print_searches
      puts @result
    end

    # “My Searches” option - he should see all the searches made by him
    # before if such searches exists or some message when the searches do not exist.
    # He should see the main menu right after that.
  end
end