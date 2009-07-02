require File.dirname(__FILE__) + '/../../test_helper'

class MyModel
  include Unfuzzle::Model
  attribute :foo
end

module MyModule
  class MyModel
    include Unfuzzle::Model
    attribute :bar
  end
end

module Unfuzzle
  class ModelTest < Test::Unit::TestCase
    
    context "An instance of the MyModel class" do
      should "have an accessor for :foo" do
        m = MyModel.new({})
        m.foo = 'bar'
        m.foo.should == 'bar'
      end
      
      should "be able to generate a hash representation of its data" do
        m = MyModel.new('foo' => 'bar')
        m.to_hash.should == {'foo' => 'bar'}
      end
      
      should "be able to generate its tag name when the class is not namespaced" do
        m = MyModel.new({})
        m.tag_name.should == 'mymodel'
      end
      
      should "be able to generate its tag name when the class is namespaced" do
        m = MyModule::MyModel.new({})
        m.tag_name.should == 'mymodel'
      end
      
      should "be able to generate an XML representation of its data" do
        m = MyModel.new('foo' => 'bar')
        m.foo = 'bar'
        
        xml = <<-XML
          <?xml version="1.0" encoding="UTF-8"?>
          
        XML
        
        m.to_xml.should == '<?xml version="1.0" encoding="UTF-8"?><mymodel><foo>bar</foo></mymodel>'
      end
      
    end
    
  end
end