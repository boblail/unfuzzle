require File.dirname(__FILE__) + '/../test_helper'

class UnfuzzleTest < Test::Unit::TestCase

  context "The Unfuzzle module" do
    
    should "be able to set the subdomain" do
      Unfuzzle.subdomain = 'viget'
      Unfuzzle.subdomain.should == 'viget'
    end
    
    should "be able to set the username" do
      Unfuzzle.username = 'username'
      Unfuzzle.username.should == 'username'
    end
    
    should "be able to set the password" do
      Unfuzzle.password = 'password'
      Unfuzzle.password.should == 'password'
    end
    
  end
  
end