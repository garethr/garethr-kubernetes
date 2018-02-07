require_relative 'swagger_symbolize_keys'
require_relative 'fixnumify'


module PuppetX
  module Puppetlabs
    module Swagger
      class Utils
        def self.fuzzy_compare(existing, intended)
          normalized_is = existing.swagger_symbolize_keys.fixnumify
          normalized_should = intended.swagger_symbolize_keys.fixnumify
          do_compare(normalized_should, normalized_is)
        end

        private
        def self.do_compare(normalized_should, normalized_is)
          klass = normalized_should.class
          if [String, Fixnum, TrueClass, FalseClass].include? klass
            normalized_should.to_s == normalized_is.to_s
          elsif klass == Array
            if normalized_is.class != Array || normalized_should.length != normalized_is.length
              false
            else
              # We want to check that both arrays have the same elements regardless of their order
              tests = normalized_is.collect do |is_value|
                normalized_should.lazy.reduce(false) do |m, should_value|
                  m || do_compare(should_value, is_value)
                end
              end
              tests.flatten.compact.all?
            end
          elsif klass == Hash
            if normalized_is.class != Hash
              false
            else
              normalized_should.lazy.all? { |key, should_value| do_compare(should_value, normalized_is[key]) }
            end
          else
           raise "Don't know how to compare object '#{normalized_should}' of class #{klass}"
          end
        end
      end
    end
  end
end