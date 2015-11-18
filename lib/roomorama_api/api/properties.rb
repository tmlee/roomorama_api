module RoomoramaApi
  module Api
    module Properties
      def properties_find(options={})
        api_call "rooms", options
      end

      def properties_get_data(room_id, options={})
        api_call "rooms/" + room_id.to_s, options
      end

      def properties_find_similar(room_id, options={})
        api_call "rooms/" + room_id.to_s + "/similar", options
      end

      def properties_availabilities(room_id, options={})
        api_call "rooms/" + room_id.to_s + "/availabilities", options
      end

      def properties_price_check(room_id, options={})
        api_call "inquiries/new.json", options.merge(room_id: room_id)
      end

      def properties_reviews(room_id, options={})
        api_call "rooms/" + room_id.to_s + "/reviews", options
      end
    end
  end
end
