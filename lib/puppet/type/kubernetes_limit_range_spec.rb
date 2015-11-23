require 'puppet_x/puppetlabs/swagger/symbolize_keys'


Puppet::Type.newtype(:kubernetes_limit_range_spec) do
  
  @doc = "LimitRangeSpec defines a min/max usage limit for resources that match on kind."
  

  ensurable

  
  validate do
    required_properties = [
    
      limits,
    
    ]
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[property].nil? and self.provider.send(property) == :absent
        fail "You must provide a #{property}"
      end
    end
  end
  

  newparam(:name, namevar: true) do
    desc 'Name of the limit_range_spec.'
  end
  
    
      newproperty(:limits) do
        desc "Limits is the list of LimitRangeItem objects that are enforced."
        def insync?(is)
          normalized_is = is.symbolize_keys
          normalized_should = should.symbolize_keys
          if is.all? { |k,v| v.class == String }
            diff = normalized_is.merge(normalized_should)
            diff == normalized_is
          else
            tests = normalized_should.keys.collect do |key|
              normalized_is[key].collect do |is_value|
                normalized_should[key].collect do |should_value|
                  diff = is_value.merge(should_value)
                  diff == is_value
                end
              end
            end
            tests.flatten.include? true
          end
        end
      end
    
  
end
