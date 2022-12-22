module Lib
  class SuperUser
    include Lib::Modules::Constants::ReadWriteType
    include Lib::Modules::Constants::FilePaths
    include Lib::Modules::Constants::RegExps
    def initialize
      @su_status = false
      @admin_data = UsersDb.new.load_logins_and_passwords(ADMIN_FILE)
    end

    def superuser_status(email:, password:)
      binding.pry
      @admin_data[:email] == email && @admin_data[:email] == password
    end
  end
end
