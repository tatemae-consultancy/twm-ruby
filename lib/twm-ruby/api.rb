module TWM
  #
  # The Whale Hotline API
  # http://hotline.whalemuseum.org/api
  #
  class Hotline
    attr_accessor :api

    def initialize(api)
      @api = api
      @api.create_session('http://hotline.whalemuseum.org')
    end

    # Retrieve Hotline sighting reports
    # 
    # @param [Hash] params Optional params or filters:
    # @option params [String] species Get sighting reports for a species.
    # @option params [String] orca_type Get sighting reports for a type of orca.
    # @option params [String] orca_pod Get sighting reports for a pod of orca.
    # @option params [String] since Get sighting reports after this date.
    # @option params [String] until Get sighting reports before this date.
    # @option params [String] near Get sighting reports near a Lat/Lng point.
    # @option params [String] radius Get sighting reports within this distance of center point.
    #
    # @return [Integer] The count of sighting reports.
    #
    # @see http://hotline.whalemuseum.org/api
    # 
    # @example
    #
    #   count = twm.hotline.count
    #   => 17000
    #
    #   count = twm.hotline.count(species: 'orca')
    #
    def count(params = {})
      @api.get("api/count.json", params)
    end

    # Retrieve a specific sighting report
    # 
    # @param [String] id The ID of the sighting report to retrieve.
    #
    # @return [JSON] A sighting report object.
    #
    # @see http://hotline.whalemuseum.org/api
    # 
    # @example
    #
    #   sighting = twm.hotline.find('52b158c0686f7438d8ac0600')
    #   sighting['species']
    #   => "orca"
    #
    def find(id)
      @api.get("api/#{id.to_s}.json")
    end

    # Retrieve Hotline sighting reports
    # 
    # @param [Hash] params Optional params or filters:
    # @option params [String] species Get sighting reports for a species.
    # @option params [String] orca_type Get sighting reports for a type of orca.
    # @option params [String] orca_pod Get sighting reports for a pod of orca.
    # @option params [Integer] limit The number of sighting reports to return.
    # @option params [Integer] page The page number to return.
    # @option params [String] since Get sighting reports after this date.
    # @option params [String] until Get sighting reports before this date.
    # @option params [String] near Get sighting reports near a Lat/Lng point.
    # @option params [String] radius Get sighting reports within this distance of center point.
    #
    # @return [JSON] An array of matching sighting reports.
    #
    # @see http://hotline.whalemuseum.org/api
    # 
    # @example
    #
    #   sightings = twm.hotline.search
    #   sightings.size
    #   => 17000
    #
    #   sightings = twm.hotline.search(species: 'orca', limit: 250)
    #
    def search(params = {})
      @api.get("api.json", params)
    end
  end
end