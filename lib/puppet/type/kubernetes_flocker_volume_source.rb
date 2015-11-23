require 'puppet_x/puppetlabs/swagger/symbolize_keys'


Puppet::Type.newtype(:kubernetes_flocker_volume_source) do
  
  @doc = "FlockerVolumeSource represents a Flocker volume mounted by the Flocker agent."
  

  ensurable

  
  validate do
    required_properties = [
    
      datasetName,
    
    ]
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[property].nil? and self.provider.send(property) == :absent
        fail "You must provide a #{property}"
      end
    end
  end
  

  newparam(:name, namevar: true) do
    desc 'Name of the flocker_volume_source.'
  end
  
    
      newproperty(:datasetName) do
        desc "Required: the volume name. This is going to be store on metadata -> name on the payload for Flocker"
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
