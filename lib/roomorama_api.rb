require_relative "roomorama_api/version"
require "faraday"
require "json"

module RoomoramaApi

	class Client

		def initialize(oauth_token=nil)
			@oauth_token == ''
			@oauth_token = oauth_token if oauth_token
		end


		BASE_URL = 'https://api.roomorama.com/'
		API_VERSION = 'v1.0/'

		### Destinations

		def destinations_all
			api_call "destinations.json"
		end

		#### Properties

		def properties_find(options={})
			api_call "rooms.json", options
		end

		def properties_get_data(room_id, options={})
			api_call "rooms/" + room_id.to_s + ".json", options
		end

		def properties_find_similar(room_id, options={})
			api_call "rooms/" + room_id.to_s + "/similar.json", options
		end

		def properties_availabilities(room_id, options={})
			api_call "rooms/" + room_id.to_s + "/availabilities.json", options
		end

		#### Perks

		def perks_list(options={})
			api_call "perks.json", options
		end

		def perks_get_data(perk_id, options={})
			api_call "perks/" + perk_id.to_s, options
		end

		#### Users

		def users_me(options={})
			api_call "me.json", options
		end

		def users_update_profile(options={})
			api_call "me.json", options, :put
		end

		def users_get_data(user_id, options={})
			api_call "users", options
		end

		def users_register(options={})
			api_call "users", options, :post
		end


		private

		def api_url
			BASE_URL + API_VERSION
		end

		def api_call(method_name, options, verb=:get)
			options["access_token"] = @oauth_token
			response = connection(method_name, options, verb)
			parse_response response.body
		end

		def parse_response(response)
			if response == " "
				{}
			else
				JSON.parse response
			end
		end

		def connection(method_name, options, verb)

			conn = Faraday.new(:url => api_url) do |faraday|
				faraday.request  :url_encoded
  				#faraday.response :logger
  				faraday.adapter  Faraday.default_adapter
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

	end

end
