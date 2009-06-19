$:.unshift File.dirname(__FILE__)

require 'uri'
require 'net/http'
require 'json'

require 'unfuzzle/request'
require 'unfuzzle/response'
require 'unfuzzle/model'
require 'unfuzzle/project'
require 'unfuzzle/milestone'

# = Unfuzzle: A simple wrapper around the Unfuddle JSON API
#
# == Quick Start
#
# To get started, you need to set the subdomain and a valid username / 
# password combination:
#
#    require 'rubygems'
#    require 'unfuzzle'
#
#    Unfuzzle.subdomain = 'viget'
#    Unfuzzle.username = 'bopbip'
#    Unfuzzle.password = 'bleep'
# 
# From there, you can start accessing a list of projects:
#
#    Project.all
#
module Unfuzzle
  
  # Set the subdomain for all requests
  def self.subdomain=(subdomain)
    @subdomain = subdomain
  end

  # Set the username for all requests. Data retrieved from the API will be
  # scoped to the data that this user has access to.
  def self.username=(username)
    @username = username
  end

  # Set the password for the supplied username
  def self.password=(password)
    @password = password
  end
    
  def self.subdomain # :nodoc:
    @subdomain
  end
  
  def self.username # :nodoc:
    @username
  end
  
  def self.password # :nodoc:
    @password
  end
  
end