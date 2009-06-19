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
    
    # Create a new request for the given resource path
    def initialize(resource_path)
      @resource_path = resource_path
    end
    
    def endpoint_uri  # :nodoc:
      URI.parse("http://#{Unfuzzle.subdomain}.unfuddle.com/api/v1#{@resource_path}.json")
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
    
  end
end
