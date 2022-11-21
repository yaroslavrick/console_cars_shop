module Lib
  module Modules
    module Localization
      # I18n.load_path << Dir[File.expand_path('config/locales') + '/*.yml']
      I18n.load_path << Dir["#{File.expand_path('config/locales')}/*.yml"]
      I18n.default_locale = :en

      def localize(key)
        I18n.t(key)
      end
    end
  end
end
