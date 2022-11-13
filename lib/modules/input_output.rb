# frozen_string_literal: true

module InputOutput
  def ask_user_input
    puts I18n.t(:select_search_rules).cyan
    search_hash = {
      rules: {},
      stats: {}
    }

    print_message(I18n.t('choose.make'))
    search_hash[:rules][:make] = get_user_input
    print_message(I18n.t('choose.model'))
    search_hash[:rules][:model] = get_user_input
    print_message(I18n.t('choose.year_from'))
    search_hash[:rules][:year_from] = get_user_input.to_i
    print_message(I18n.t('choose.year_to'))
    search_hash[:rules][:year_to] = get_user_input.to_i
    print_message(I18n.t('choose.price_from'))
    search_hash[:rules][:price_from] = get_user_input.to_i
    print_message(I18n.t('choose.price_to'))
    search_hash[:rules][:price_to] = get_user_input.to_i
    print_message(I18n.t('choose.sort_option'))
    search_hash[:rules][:sort_option] = get_user_input
    print_message(I18n.t('choose.sort_direction'))
    search_hash[:rules][:sort_direction] = get_user_input
    search_hash
  end

  def print_message(message)
    puts message.light_blue
  end

  def get_user_input
    gets.chomp
  end

  def show_prettified_result(database)
    rows = add_colors_to_rows(database)
    table = Terminal::Table.new title: I18n.t('results.title').light_yellow,
                                headings: [I18n.t('results.params').cyan, I18n.t('results.data').cyan], rows: rows
    table.style = { all_separators: true, padding_left: 2, padding_right: 2, border: :unicode_thick_edge }
    puts table
  end

  def add_colors_to_rows(database)
    database.flat_map do |car|
      car.map do |key, value|
        [key.to_s.light_blue, value.to_s.magenta]
      end
    end
  end

  def exit?
    puts I18n.t(:exit).cyan
    %w[y yes].none?(gets.chomp.downcase)
  end
end
