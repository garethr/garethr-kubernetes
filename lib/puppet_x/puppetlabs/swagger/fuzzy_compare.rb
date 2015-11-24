require 'puppet_x/puppetlabs/swagger/symbolize_keys'

module PuppetX
  module Puppetlabs
    module Swagger
      class Utils
        def self.fuzzy_compare(existing, intended)
          normalized_is = existing.symbolize_keys
          normalized_should = intended.symbolize_keys
          if normalized_is.all? { |k,v| v.class == String }
            diff = normalized_is.merge(normalized_should)
            diff == normalized_is
          elsif normalized_is == normalized_should
            true
          else
            tests = normalized_should.keys.collect do |key|
              if [String, Fixnum].include? normalized_is[key].class
                normalized_is[key].to_s == normalized_should[key].to_s
              else
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
              end
            end
            tests.flatten.include? true
          end
        end
      end
    end
  end
end
