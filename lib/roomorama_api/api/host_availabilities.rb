module RoomoramaApi
	module Api
  	module HostAvailabilities
  	  def host_availabilities_list(room_id, options={})
  	    api_call "host/rooms/#{room_id}/availabilities.json", options
  	  end
  	  
  	  def host_availabilities_update(room_id, options={})
  	    api_call "host/rooms/#{room_id}/availabilities.json", options, :put
  	  end
  	end
  end
end