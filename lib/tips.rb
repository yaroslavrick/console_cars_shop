# frozen_string_literal: true

module Lib
  class Tips
    include Lib::Modules::Localization
    include Lib::Modules::Colorize

    def show_tip_for_email
      puts colorize_result(localize('authentication.tip.tip_message'))
      puts colorize_result(localize('authentication.tip.email.format'))
      puts colorize_result(localize('authentication.tip.email.number_of_symbols_before_at'))
      puts colorize_result(localize('authentication.tip.email.unique'))
    end

    def show_tips_for_password
      puts colorize_result(localize('authentication.tip.tip_message'))
      puts colorize_result(localize('authentication.tip.password.capital_letters'))
      puts colorize_result(localize('authentication.tip.password.special_characters'))
      puts colorize_result(localize('authentication.tip.password.number_of_symbols_min'))
      puts colorize_result(localize('authentication.tip.password.number_of_symbols_max'))
    end
  end
end
