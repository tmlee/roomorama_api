require "roomorama_api/version"
require "faraday"
require "json"

module RoomoramaApi

	class Client

		def initialize(oauth_token=nil)
			@oauth_token == ''
			@oauth_token = oauth_token if oauth_token
		end


		BASE_URL = 'https://api.roomorama.com/'
		API_VERSION = 'v1.0'

		### Destinations

		def destinations_all(options={})
			api_call "destinations", options
		end

		#### Properties

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


		#### Favorites

		def favorites_list(options = {})
			api_call "favorites", options
		end

		def favorites_create(options = {})
			api_call "favorites", options, :post
		end

		def favorites_delete(id, options = {})
			api_call "favorites/" + id.to_s, options, :delete
		end

		#### Perks

		def perks_list(options={})
			api_call "perks", options
		end

		def perks_get_data(perk_id, options={})
			api_call "perks/" + perk_id.to_s, options
		end

		#### Users

		def users_me(options={})
			api_call "me", options
		end

		def users_update_profile(options={})
			api_call "me", options, :put
		end

		def users_get_data(user_id, options={})
			api_call "users/" + user_id.to_s, options
		end

		def users_register(options={})
			api_call "users", options, :post
		end

		#### Hosts/Properties

		def hosts_properties_list(options={})
			api_call "host/rooms", options
		end


		private

		def api_url
			BASE_URL + API_VERSION + '/'
		end

		def api_call(method_name, options, verb=:get)
			response = connection(method_name, options, verb)
			parse_response response
		end

		def parse_response(response)
			raise_errors response
			if response.body == " "
				{}
			else
				JSON.parse response.body
			end
		end

		def connection(method_name, options, verb)

			conn = Faraday.new(:url => api_url) do |faraday|
				faraday.request  :url_encoded
  				#faraday.response :logger
  				faraday.adapter  Faraday.default_adapter
  				faraday.headers['Authorization'] = "Bearer " + @oauth_token
			end

			if verb == :put
				response = conn.put(method_name, options)
			elsif verb == :post
				response = conn.post(method_name, options)
			elsif verb == :delete
				response = conn.delete(method_name)
			else
				response = conn.get(method_name + "?" + to_query_params(options))
			end
		end


		def to_query_params(options)
			options.collect { |key, value| "#{key}=#{value}" }.join('&')
		end

		def raise_errors(response)
      		message = "(#{response.status})"
      		
      		case response.status.to_i
      		  when 400
      		    raise BadRequest, message
      		  when 401
      		    raise Unauthorized, message
      		  when 403
      		    raise General, message
      		  when 404
      		    raise NotFound, message
      		  when 500
      		    raise InternalError, "An internal error is thrown."
      		  when 502..503
      		    raise Unavailable, message
      		end
    	end

	end


	class BadRequest < StandardError; end
  	class Unauthorized      < StandardError; end
  	class General           < StandardError; end
  	class Unavailable       < StandardError; end
  	class InternalError     < StandardError; end
  	class NotFound          < StandardError; end

end
