module Unfuzzle
  
  # = Request
  #
  # A basic wrapper for GET requests to the Unfuddle API
  #
  class Request 

    # Retrieve a response from the given resource path
    def self.get(resource_path)
      request = new(resource_path)
      request.get
    end
    
    def self.put(resource_path, payload)
      request = new(resource_path, payload)
      request.put
    end
    
    # Create a new request for the given resource path
    def initialize(resource_path, payload = nil)
      @resource_path = resource_path
      @payload       = payload
    end
    
    def endpoint_uri  # :nodoc:
      URI.parse("http://#{Unfuzzle.subdomain}.unfuddle.com/api/v1#{@resource_path}.xml")
    end

    def client # :nodoc:
      Net::HTTP.new(endpoint_uri.host)
    end

    # Retrieve a response from the current resource path    
    def get
      request = Net::HTTP::Get.new(endpoint_uri.path)
      request.basic_auth Unfuzzle.username, Unfuzzle.password
      
      Response.new(client.request(request))
    end

    def put
      request = Net::HTTP::Put.new(endpoint_uri.path)
      request.basic_auth Unfuzzle.username, Unfuzzle.password
      request.content_type = 'application/xml'
      
      Response.new(client.request(request, @payload))
    end
    
  end
end
