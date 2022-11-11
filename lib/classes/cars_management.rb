I18n.load_path << Dir[File.expand_path('config/locales') + '/*.yml']
I18n.default_locale = :en # (note that `en` is already the default!)
class CarsManagement
  include InputOutput
  include DataBase
  include SearchEngine
  include Statistics

  def initialize
    @running = true
    @requests_quantity = 1
  end

  def ask_locale
    puts 'Choose language: EN/ua: '.colorize(:blue)
    locale = gets.chomp.downcase.to_sym
    I18n.locale = if locale == :ua
                    locale
                  else
                    :en
                  end
  end

  def run
    ask_locale
    while @running == true
      @requests_quantity = 1
      search_rules_hash = ask_user_input
      database = load_database
      database = keep('make', search_rules_hash[:rules][:make], database)
      database = keep('model', search_rules_hash[:rules][:model], database)
      database = keep_range('year', search_rules_hash[:rules][:year_from], search_rules_hash[:rules][:year_to],
                            database)
      database = keep_range('price', search_rules_hash[:rules][:price_from], search_rules_hash[:rules][:price_to],
                            database)
      database = sort_by_option(database, search_rules_hash[:rules][:sort_option])
      database = sort_by_direction(database, search_rules_hash[:rules][:sort_direction])
      searches_history_arr = load_log
      current_log_hash = add_statistics(search_rules_hash, database, @requests_quantity)
      @requests_quantity = compare_requests(current_log_hash, searches_history_arr, @requests_quantity)
      show_prettified_statistic(database, @requests_quantity)
      show_prettified_result(database)
      total_quantity = total_quantity(database)
      save_log(search_rules_hash, @requests_quantity, total_quantity)
      @running = exit?
    end
  end
end
