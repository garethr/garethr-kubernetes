require 'puppet_x/puppetlabs/swagger/symbolize_keys'


Puppet::Type.newtype(:kubernetes_secret_volume_source) do
  
  @doc = "SecretVolumeSource adapts a Secret into a VolumeSource. More info: http://releases.k8s.io/HEAD/docs/design/secrets.md"
  

  ensurable

  
  validate do
    required_properties = [
    
      secretName,
    
    ]
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[property].nil? and self.provider.send(property) == :absent
        fail "You must provide a #{property}"
      end
    end
  end
  

  newparam(:name, namevar: true) do
    desc 'Name of the secret_volume_source.'
  end
  
    
      newproperty(:secretName) do
        desc "SecretName is the name of a secret in the pod's namespace. More info: http://releases.k8s.io/HEAD/docs/user-guide/volumes.md#secrets"
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
