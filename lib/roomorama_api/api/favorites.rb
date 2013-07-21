module RoomoramaApi
  module Api
    module Favorites
      def favorites_list(options = {})
        api_call "favorites", options
      end
  
      def favorites_create(options = {})
        api_call "favorites", options, :post
      end
  
      def favorites_delete(id, options = {})
        api_call "favorites/" + id.to_s, options, :delete
      end
    end
  end
end