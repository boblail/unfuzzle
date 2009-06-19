module Unfuzzle
  module Model # :nodoc:

    module ClassMethods
      def attribute(name, options = {}) # :nodoc:
        key = options.delete(:from) || name

        class_eval %(
        def #{name}
          @response_data['#{key}']
        end
        )
      end
    end

    module InstanceMethods

      def initialize(response_data)
        @response_data = response_data
      end

    end

    def self.included(other)
      other.send(:extend, Unfuzzle::Model::ClassMethods)
      other.send(:include, Unfuzzle::Model::InstanceMethods)
    end

  end
end