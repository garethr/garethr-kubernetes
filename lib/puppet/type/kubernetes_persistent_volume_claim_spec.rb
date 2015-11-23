require 'puppet_x/puppetlabs/swagger/symbolize_keys'


Puppet::Type.newtype(:kubernetes_persistent_volume_claim_spec) do
  
  @doc = "PersistentVolumeClaimSpec describes the common attributes of storage devices and allows a Source for provider-specific attributes"
  

  ensurable

  

  newparam(:name, namevar: true) do
    desc 'Name of the persistent_volume_claim_spec.'
  end
  
    
      newproperty(:accessModes) do
        desc "AccessModes contains the desired access modes the volume should have. More info: http://releases.k8s.io/HEAD/docs/user-guide/persistent-volumes.md#access-modes-1"
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
    
  
    
      newproperty(:resources) do
        desc "Resources represents the minimum resources the volume should have. More info: http://releases.k8s.io/HEAD/docs/user-guide/persistent-volumes.md#resources"
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
    
  
    
      newproperty(:volumeName) do
        desc "VolumeName is the binding reference to the PersistentVolume backing this claim."
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
