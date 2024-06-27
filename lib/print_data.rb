# frozen_string_literal: true

module Lib
  class PrintData
    include Lib::Modules::InputOutput
    include Lib::Modules::Colorize
    include Lib::Modules::Constants::PrintConst

    def create_table(title_name, first_header, second_header, rows)
      table = Terminal::Table.new(
        title: colorize_text('title', localize(title_name)).underline,
        headings: [colorize_text('header', localize(first_header)).underline,
                   colorize_text('header', localize(second_header)).underline],
        rows: rows
      )
      table.style = TABLE_STYLE
      puts table
    end

    def show_error_wrong_input
      puts colorize_text('error', localize('main_menu.wrong_input'))
    end

    def car_deleted(id)
      puts colorize_text('result', I18n.t('admin_panel.car_deleted', id: id))
    end

    def car_updated(id)
      puts colorize_text('result', I18n.t('admin_panel.car_updated', id: id))
    end

    def car_with_id_not_exists(id)
      puts colorize_text('error', I18n.t('admin_panel.id_not_exists', id: id))
    end

    def show_car_created_message(id)
      puts colorize_text('result', I18n.t('admin_panel.car_created', id: id))
    end

    def ask_id_message
      puts colorize_text('result', localize('admin_panel.enter_id'))
    end

    def wrong_parameter(param)
      puts I18n.t('errors.wrong_parameter', param: param)
    end
  end
end
