require 'puppet_x/puppetlabs/swagger/symbolize_keys'


Puppet::Type.newtype(:kubernetes_downward_api_volume_file) do
  
  @doc = "DownwardAPIVolumeFile represents information to create the file containing the pod field"
  

  ensurable

  
  validate do
    required_properties = [
    
      path,
    
      fieldRef,
    
    ]
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[property].nil? and self.provider.send(property) == :absent
        fail "You must provide a #{property}"
      end
    end
  end
  

  newparam(:name, namevar: true) do
    desc 'Name of the downward_api_volume_file.'
  end
  
    
      newproperty(:path) do
        desc "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"
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
    
  
    
      newproperty(:fieldRef) do
        desc "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported."
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
