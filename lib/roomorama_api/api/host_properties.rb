module RoomoramaApi
  module Api
    module HostProperties
      def host_properties_list(options={})
        api_call "host/rooms", options
      end
  
      def host_properties_show(room_id, options={})
        api_call "host/rooms/" + room_id.to_s, options
      end
  
      def host_properties_create(room_id, options={})
        api_call "host/rooms/" + room_id.to_s, options, :post
      end
  
      def host_properties_update(room_id, options={})
        api_call "host/rooms/" + room_id.to_s, options, :put
      end
    end
  end
end