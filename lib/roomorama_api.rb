require "roomorama_api/version"

require "roomorama_api/api/destinations"
require "roomorama_api/api/favorites"
require "roomorama_api/api/perks"
require "roomorama_api/api/properties"
require "roomorama_api/api/users"
require "roomorama_api/api/host_properties"
require "roomorama_api/api/host_availabilities"
require "roomorama_api/api/host_inquiries"

require "faraday"
require "json"

module RoomoramaApi

  class Client

    include RoomoramaApi::Api::Destinations
    include RoomoramaApi::Api::Favorites
    include RoomoramaApi::Api::Perks
    include RoomoramaApi::Api::Properties
    include RoomoramaApi::Api::Users
    include RoomoramaApi::Api::HostProperties
    include RoomoramaApi::Api::HostAvailabilities
    include RoomoramaApi::Api::HostInquiries

    def initialize(oauth_token=nil)
      @oauth_token = oauth_token
    end

    BASE_URL = 'https://api.roomorama.com/'
    API_VERSION = 'v1.0'

    private

    def api_url
      BASE_URL + API_VERSION + '/'
    end

    def api_call(method_name, options, verb=:get)
      response = connection(method_name, options, verb)
      puts response.inspect
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
          faraday.headers['Authorization'] = "Bearer " + @oauth_token if @oauth_token
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
      when 502, 503
        raise Unavailable, message
      end
    end

  end

  class BadRequest    < StandardError; end
  class Unauthorized  < StandardError; end
  class General       < StandardError; end
  class Unavailable   < StandardError; end
  class InternalError < StandardError; end
  class NotFound      < StandardError; end

end
