# frozen_string_literal: true

I18n.load_path << Dir["#{File.expand_path('config/locales')}/*.yml"]
I18n.available_locales = %i[en ua]
I18n.default_locale = :en
