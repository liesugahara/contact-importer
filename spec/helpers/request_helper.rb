module Requests
  module JsonHelpers
    def json
      @json ||= JSON.parse(response.body)
      @json
    end
    def json!
      @json = JSON.parse(response.body)
    end
  end
end
