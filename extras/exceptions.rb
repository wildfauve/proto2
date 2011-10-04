module Exceptions
  class NotAuthorized < StandardError
    def message
      "Unauthorised Access"
    end
  end
end