module Unfuzzle
  module Model # :nodoc:

    module ClassMethods
      def attribute(name, options = {}) # :nodoc:
        key = options.delete(:from) || name

        class_eval <<-CODE
          def #{name}
            @response_data['#{key}']
          end
          
          def #{name}=(value)
            @response_data['#{key}'] = value
          end
        CODE
      end
    end

    module InstanceMethods

      def initialize(response_data)
        @response_data = response_data
      end

      def to_hash
        @response_data
      end
      
      def tag_name
        full_class_name = self.class.to_s
        class_name = full_class_name.split('::').last
        
        class_name.downcase
      end

      def to_xml
        xml = Builder::XmlMarkup.new
        xml.instruct!
        xml.tag! tag_name do
          to_hash.each do |attribute, value|
            xml.tag! attribute, value
          end
        end
        xml.target!
      end

    end

    def self.included(other)
      other.send(:extend, Unfuzzle::Model::ClassMethods)
      other.send(:include, Unfuzzle::Model::InstanceMethods)
    end

  end
end