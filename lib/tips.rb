# frozen_string_literal: true

module Lib
  class Tips
    include Lib::Modules::Colorize
    include Lib::Modules::InputOutput

    def show_tips_for_email
      puts colorize_text('result', localize('authentication.tip.tip_message'))
      puts colorize_text('result', localize('authentication.tip.email.format'))
      puts colorize_text('result', localize('authentication.tip.email.number_of_symbols_before_at'))
      puts colorize_text('result', localize('authentication.tip.email.unique'))
    end

    def show_tips_for_password
      puts colorize_text('result', localize('authentication.tip.tip_message'))
      puts colorize_text('result', localize('authentication.tip.password.capital_letters'))
      puts colorize_text('result', localize('authentication.tip.password.special_characters'))
      puts colorize_text('result', localize('authentication.tip.password.number_of_symbols_min'))
      puts colorize_text('result', localize('authentication.tip.password.number_of_symbols_max'))
    end
  end
end
