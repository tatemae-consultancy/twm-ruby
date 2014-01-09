require 'faraday'
require 'multi_json'

require 'twm-ruby/version'
require 'twm-ruby/errors'
require 'twm-ruby/api'

module TWM
  class API
    attr_accessor :debug, :session

    def initialize(debug=false)
      @debug = debug
    end

    def create_session(url) # :nodoc:
      @session = Faraday.new(url: url, headers: set_headers)
    end

    # Make a GET request with the session
    #
    def get(path, params={}) # :nodoc:
      handle_response(@session.get(path, params))
    end

    # Make a POST request with the session
    #
    def post(path, params={}) # :nodoc:
      handle_response(@session.post(path, MultiJson.dump(params)))
    end

    # Make a PUT request with the session
    #
    def put(path, params={}) # :nodoc:
      handle_response(@session.put(path, MultiJson.dump(params)))
    end

    # Make a DELETE request with the session
    #
    def delete(path, params={}) # :nodoc:
      handle_response(@session.delete(path, MultiJson.dump(params)))
    end

    def handle_response(response)
      case response.status # :nodoc:
      when 400
        raise BadRequest.new response.body
      when 401
        raise Unauthorized.new
      when 404
        raise NotFound.new
      when 400...500
        raise ClientError.new response.body
      when 500...600
        raise ServerError.new
      else
        case response.body
        when ''
          true
        when is_a?(Integer)
          response.body
        else
          MultiJson.load(response.body)
        end
      end
    end

    # Set the request headers
    def set_headers # :nodoc:
      {
        'User-Agent' => "twm-ruby-#{VERSION}",
        'Content-Type' => 'application/json; charset=utf-8',
        'Accept' => 'application/json'
      }
    end

    # API nodes
    def sightings # :nodoc:
      Sightings.new self
    end

  end
end