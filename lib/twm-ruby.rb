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

    def call(method, path, params={})
      headers = {
        'User-Agent' => "twm-ruby-#{VERSION}",
        'Content-Type' => 'application/json; charset=utf-8',
        'Accept' => 'application/json'
      }
      params = MultiJson.dump(params)
      r = @session.send(method, path, params)
      handle_response(r)
    end

    def handle_response(response)
      case response.status
      when 400
        raise BadRequest.new MultiJson.load(response)
      when 401
        raise Unauthorized.new
      when 404
        raise NotFound.new
      when 400...500
        raise ClientError.new MultiJson.load(response)
      when 500...600
        raise ServerError.new
      else
        begin
          MultiJson.load(response)
        rescue MultiJson.load(response)

        end
        case response.body
        when ''
          true
        when is_a?(Integer)
          response.body
        else
          MultiJson.load(response)
        end
      end
    end

    # API nodes
    def hotline # :nodoc:
      Hotline.new self
    end

  end
end