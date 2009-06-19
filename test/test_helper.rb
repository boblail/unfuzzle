# http://sneaq.net/textmate-wtf
$:.reject! { |e| e.include? 'TextMate' }

require 'rubygems'
require 'throat_punch'

require File.dirname(__FILE__) + '/../lib/unfuzzle'


class Test::Unit::TestCase
  
  def self.read_fixture(method_name)
    file = File.dirname(__FILE__) + "/fixtures/#{method_name}.json"
    JSON.parse(File.read(file))
  end

  def read_fixture(method_name)
    self.class.read_fixture(method_name)
  end
  
  def mock_request_cycle(options)
    response = Unfuzzle::Response.new(stub())

    data = read_fixture(options[:data])

    response.stubs(:data).with().returns(data)

    Unfuzzle::Request.stubs(:get).with(options[:for]).returns(response)

    response
  end

  def self.when_populating(klass, options, &block)
    # data = options[:from].is_a?(String) ? read_fixture(options[:from])[0] : options[:from].call

    context "with data populated for #{klass}" do
      setup { @object = klass.new(read_fixture(options[:from])[0]) }
      merge_block(&block)
    end

  end

  def self.value_for(method_name, options)
    should "have a value for :#{method_name}" do
      @object.send(method_name).should == options[:is]
    end
  end
  
end