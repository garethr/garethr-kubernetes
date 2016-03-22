require_relative 'symbolize_keys'
require_relative 'fixnumify'


module PuppetX
  module Puppetlabs
    module Swagger
      class Utils
        def self.fuzzy_compare(existing, intended)
          normalized_is = existing.symbolize_keys.fixnumify
          normalized_should = intended.symbolize_keys.fixnumify
          if normalized_is.respond_to? :all? and normalized_is.all? { |k,v| v.class == String }
            diff = normalized_is.merge(normalized_should)
            diff == normalized_is
          elsif normalized_is == normalized_should
            true
          else
            tests = test_complex_structure(normalized_should, normalized_is)
            tests.flatten.compact.all?
          end
        end
        def self.test_complex_structure(normalized_should, normalized_is)
          normalized_should.keys.collect do |key|
            klass = normalized_is[key].class
            if [String, Fixnum].include? klass
              normalized_is[key].to_s == normalized_should[key].to_s
            elsif klass == Array
              normalized_is[key].collect do |is_value|
                normalized_should[key].collect do |should_value|
                  diff = if is_value.class == Hash
                    is_value.merge(should_value)
                  else
                    should_value
                  end
                  diff == is_value
                end
              end
            elsif klass == Hash
              diff = normalized_is[key].merge(normalized_should[key])
              if diff == normalized_is[key]
                true
              else
                normalized_should[key].keys.collect do |inner_key|
                  test_complex_structure(normalized_should[key][inner_key], normalized_is[key][inner_key])
                end
              end
            end
          end
        end
      end
    end
  end
end
