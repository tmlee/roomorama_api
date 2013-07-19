module RoomoramaApi
  module HostsProperties
    def hosts_properties_list(options={})
      api_call "host/rooms", options
    end

    def hosts_properties_show(room_id, options={})
      api_call "host/rooms/" + room_id.to_s, options
    end
  end
end