require_relative "roomorama_api/version"
require "faraday"
require "json"

module RoomoramaApi

	class Client

		BASE_URL = 'https://api.roomorama.com/'
		API_VERSION = 'v1.0/'

		#### Properties

		def properties_find(options={})
			api_call "rooms.json", to_query_params(options)
		end

		def properties_get_data(room_id, options={})
			api_call "rooms/" + room_id.to_s + ".json", to_query_params(options)
		end

		def properties_find_similar(room_id, options={})
			api_call "rooms/" + room_id.to_s + "/similar.json", to_query_params(options)
		end

		def properties_availabilities(room_id, options={})
			api_call "rooms/" + room_id.to_s + "/availabilities.json", to_query_params(options)
		end


		private

		def api_url
			BASE_URL + API_VERSION
		end

		def api_call(method_name, options)
			response = connection(method_name, options)
			parse_response response.body
		end

		def parse_response(response)
			JSON.parse response
		end

		def connection(method_name, options)
			conn = Faraday.new(:url => api_url) do |faraday|
				faraday.request  :url_encoded
  				faraday.response :logger
  				faraday.adapter  Faraday.default_adapter
			end
			response = conn.get(method_name + "?" + options)
		end

		def to_query_params(options)
			options.collect { |key, value| "#{key}=#{value}" }.join('&')
		end

	end

end
