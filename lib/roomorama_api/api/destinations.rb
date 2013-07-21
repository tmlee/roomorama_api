module RoomoramaApi
  module Destinations
    def destinations_all(options={})
      api_call "destinations", options
    end
  end
end