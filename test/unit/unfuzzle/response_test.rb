require File.dirname(__FILE__) + '/../../test_helper'

module Unfuzzle
  class ResponseTest < Test::Unit::TestCase
    
    context "An instance of the Response class" do
      
      should "delegate to the HTTP response to determine the body" do
        http_response = mock() {|r| r.expects(:body).with().returns('check mah boday') }
        
        response = Unfuzzle::Response.new(http_response)
        
        response.body.should == 'check mah boday'
      end
      
      should "know that there are no errors" do
        http_response = mock() do |r|
          r.expects(:is_a?).with(Net::HTTPSuccess).returns(true)
        end
        
        response = Unfuzzle::Response.new(http_response)
        response.error?.should be(false)
      end
      
      should "know if there are errors" do
        http_response = mock() do |r|
          r.expects(:is_a?).with(Net::HTTPSuccess).returns(false)
        end
        
        response = Unfuzzle::Response.new(http_response)
        response.error?.should be(true)
      end
      
      should "be able to parse the response" do
        response = Unfuzzle::Response.new(stub())
        response.expects(:body).with().returns('json')
        response.stubs(:error?).with().returns(false)
                
        JSON.expects(:parse).with('json').returns('data')
        
        response.data.should == 'data'
      end
      
      should "cache the parsed data from the response" do
        response = Unfuzzle::Response.new(stub())
        response.stubs(:body).with().returns('json')
        response.stubs(:error?).with().returns(false)
        
        JSON.stubs(:parse).with('json').once.returns('data')
        
        2.times { response.data }
      end
      
      should "return nil when parsing data if there are errors in the response" do
        response = Unfuzzle::Response.new(stub())
        response.expects(:error?).with().returns(true)
        
        response.data.should be(nil)
        
      end
      
    end
    
  end
end